#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=00:10:00
#SBATCH --partition=regular
#SBATCH --job-name=Sharpening

# Check if filename has been supplied
if [ -z $1 ]
then
    echo "ERROR: No input specified"
    exit -1
fi

# Check if file exists
if [ -e $1 ]
then
    echo "Processing image: " $1

    # Clean up the module environment
    module purge
    # Load the conversion and identification tools
    module load ImageMagick/7.1.0-53-GCCcore-12.2.0
    # Load the compilers
    module load foss/2022b
    # Determine width and height of the image
    width=$(identify -format "%w" $1)
    height=$(identify -format "%h" $1)
    echo "Width: " $width
    echo "Height: " $height
    
    # Compile the program
    make

    # Convert the jpg file to the rgb format for easy processing
    convert $1 $1.rgb
    # Run the convolution filter program on the image
    ./mpi_omp_conv $1.rgb $width $height 1 rgb
    # Convert the resulting file back to jpg format
    convert -size ${width}x${height}  -depth 8 conv_$1.rgb conv_$1
    
    # Remove the intermediate files
    rm $1.rgb conv_$1.rgb
else
    echo "ERROR: File $1 does not exist"
    exit -1
fi
