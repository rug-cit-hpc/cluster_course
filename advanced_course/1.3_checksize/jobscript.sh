#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=00:10:00
#SBATCH --partition=short
#SBATCH --job-name=Edge_detection

# Check if filename has been supplied
if [ -z $1 ]
then
    echo "ERROR: No input specified"
    exit -1
fi

# Check if file exists
if [ -e $1 ]
then
    # Clean up the module environment
    module purge
    # Load the compilers
    module load foss/2018a
    # Compile the program
    make

    # Convert the jpg file to the rgb format for easy processing
    convert $1 $1.rgb
    # Run the convolution filter program on the image
    ./mpi_omp_conv $1.rgb 5184 3456 1 rgb
    # Convert the resulting file back to jpg format
    convert -size 5184x3456  -depth 8 conv_$1.rgb conv_$1

    # Remove the intermediate files
    rm $1.rgb conv_$1.rgb
else
    echo "ERROR: File does not exist"
    exit -1
fi