#!/bin/bash

# Determine list of images
images=../images/*.jpg

for image in $images
do
    # Submit a job
    sbatch ./jobscript.sh $image
done
