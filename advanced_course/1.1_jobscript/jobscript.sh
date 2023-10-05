#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=00:10:00
#SBATCH --partition=regular
#SBATCH --job-name=Edge_detection

# Clean up the module environment
module purge
# Load the compilers
module load foss/2022b
# Load the conversion tool
module load ImageMagick/7.1.0-53-GCCcore-12.2.0
# Compile the program
make

# Convert the jpg file to the rgb format for easy processing
convert Microcrystals.jpg Microcrystals.rgb
# Run the convolution filter program on the image
./mpi_omp_conv Microcrystals.rgb 5184 3456 1 rgb
# Convert the resulting file back to jpg format
convert -size 5184x3456 -depth 8 conv_Microcrystals.rgb conv_Microcrystals.jpg

# Remove the intermediate files
rm Microcrystals.rgb conv_Microcrystals.rgb
