#!/bin/bash

# Clean up the module environment
module purge
# Load the compilers
module load foss/2018a
# Compile the program
make

# Determine list of images
images=../images/*.jpg

for image in $images
do
    # Submit a job
    sbatch ./jobscript.sh "$image"
done
