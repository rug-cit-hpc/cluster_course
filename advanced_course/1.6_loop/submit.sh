#!/bin/bash

# Clean up the module environment
module purge
# Load the compilers
module load foss/2020a
# Compile the program
make

# Determine list of images
images=../images/*.jpg

# Submit a job
sbatch ./jobscript.sh "../images/Sarus Crane Duet.jpg"
