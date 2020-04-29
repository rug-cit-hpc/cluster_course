#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=00:10:00
#SBATCH --partition=short
#SBATCH --job-name=Edge_detection

# Convert the jpg file to the rgb format for easy processing
convert $1 $1.rgb
# Run the convolution filter program on the image
srun ./mpi_omp_conv $1.rgb 5184 3456 1 rgb
# Convert the resulting file back to jpg format
convert -size 5184x3456  -depth 8 conv_$1.rgb conv_$1
# Remove the intermediate files
rm $1.rgb conv_$1.rgb
