#!/bin/bash

# Determine list of images
images=$(ls -1 ../images/*.jpg)

# Submit a job
sbatch ./jobscript.sh ../images/Makemo.jpg
