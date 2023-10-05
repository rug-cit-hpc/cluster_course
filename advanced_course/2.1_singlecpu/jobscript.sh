#!/bin/bash
#SBATCH --nodes=<n>
#SBATCH --ntasks-per-node=<t>
#SBATCH --cpus-per-task=<c>
#SBATCH --mem=4GB
#SBATCH --time=00:10:00
#SBATCH --partition=regular
#SBATCH --job-name=Blurring
#SBATCH --output=singlecpu.out

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
./mpi_omp_conv Microcrystals.rgb 5184 3456 50 rgb
# Convert the resulting file back to jpg format
convert -size 5184x3456 -depth 8 conv_Microcrystals.rgb conv_Microcrystals.jpg

# Remove the intermediate files
rm Microcrystals.rgb conv_Microcrystals.rgb
