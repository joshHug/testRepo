# This code takes a list of files as input from stdin (one line per file)
# and computes and prints the relevant categories corresponding to those files

# for example, suppose the input is:
# machine-learning/src/perfectrec_mllib/models/headphone/recommender.py
# machine-learning/src/perfectrec_mllib/models/tv/rec_notes.py
#
# Then this code would print:
#   headphone tv

# The sets of files for each category are given by paths["phone"], paths["tv"], etc.
# If any file in paths["all"] is modified, then all categories will be printed.
# The keys of paths comprise the set of all categories.

# This code is used by github workflows, specifically when figuring which categories to use when:
# 1. Creating / updating endpoints for pull requests.
# 2. Deleting pull request endpoints and updating prod endpoints.
#
# Example local test:
#    git diff --name-only main 7d587a2eb1a506e70b57292d89ae30befecfd3bb | python compute_categories_for_automatic_endpoint_updates.py

import sys
available_categories = ["phone", "tv", "laptop", "headphone"]

paths = {}
for category in available_categories:
    paths[category] = [
        f"perfectrec_mllib/models/{category}",
        f"data/train/{category}",
        f"endpoint_{category}.py"
    ]
paths["all"] = [
    "train.py",
    "perfectrec_mllib/models/common"
]

def find_category(file_path):
    for category, category_paths in paths.items():
        for path in category_paths:
            if path in file_path:
                return category
    return None

if __name__ == "__main__":
    categories_to_print = set()
    for file_path in sys.stdin:
        file_path = file_path.strip()
        category = find_category(file_path)
        if category in available_categories:
            categories_to_print.add(category)
        elif category == "all":
            categories_to_print.update(available_categories)
            break
    
    print(" ".join(categories_to_print))

