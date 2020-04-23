#!/bin/bash

# Determine list of images
images=$(ls -1 ../images/*.jpg)

for image in $images
do
    # Submit a job
    sbatch ./jobscript.sh $image
done
