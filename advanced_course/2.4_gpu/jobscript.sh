#!/bin/bash
#SBATCH --nodes=<n>
#SBATCH --ntasks-per-node=<t>
#SBATCH --cpus-per-task=<c>
#SBATCH --mem=4GB
#SBATCH --time=00:10:00
#SBATCH --partition=short
#SBATCH --job-name=Blurring
#SBATCH --output=mpi.out

convert Microcrystals.jpg Microcrystals.rgb
./mpi_omp_conv Microcrystals.rgb 5184 3456 50 rgb
convert -size 5184x3456  -depth 8 conv_Microcrystals.rgb conv_Microcrystals.jpg
