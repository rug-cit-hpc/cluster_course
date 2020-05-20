#!/bin/bash

# Determine list of images
images=../images/*.jpg

# Submit a job
sbatch ./jobscript.sh ../images/Makemo.jpg
