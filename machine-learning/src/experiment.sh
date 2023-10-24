#!/bin/bash

# Ensure we're starting on the main branch
git checkout main
git pull

# Branch b1 and add three files with some delay
git checkout -b b1
for i in {1..3}
do
    echo "This is the content for file${i}_b1.txt in b1." > file${i}_b1.txt
    git add file${i}_b1.txt
    git commit -m "Added file${i}_b1.txt to b1"
    sleep 2
done

# Branch b2 from b1 and add three files with some delay
git checkout b1
git checkout -b b2
for i in {1..3}
do
    echo "This is the content for file${i}_b2.txt in b2." > file${i}_b2.txt
    git add file${i}_b2.txt
    git commit -m "Added file${i}_b2.txt to b2"
    sleep 2
done

# Branch b3 from b2 and add three files with some delay
git checkout b2
git checkout -b b3
for i in {1..3}
do
    echo "This is the content for file${i}_b3.txt in b3." > file${i}_b3.txt
    git add file${i}_b3.txt
    git commit -m "Added file${i}_b3.txt to b3"
    sleep 2
done

# Branch b4 from main and add three files with some delay
git checkout main
git checkout -b b4
for i in {1..3}
do
    echo "This is the content for file${i}_b4.txt in b4." > file${i}_b4.txt
    git add file${i}_b4.txt
    git commit -m "Added file${i}_b4.txt to b4"
    sleep 2
done

# Merge b2 into b3
git checkout b3
git merge b2 --no-ff -m "Merged b2 into b3"

# Merge b4 into b1
git checkout b1
git merge b4 --no-ff -m "Merged b4 into b1"

# Merge b3 into b1
git checkout b1
git merge b3 --no-ff -m "Merged b3 into b1"

# Delete the local branches b2, b3, and b4
git branch -d b2
git branch -d b3
git branch -d b4

# Push b1 to the remote
git push origin b1

echo "Operation complete!"

