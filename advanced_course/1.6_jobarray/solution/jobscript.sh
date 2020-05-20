#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=00:10:00
#SBATCH --partition=short
#SBATCH --job-name=Blurring
#SBATCH --array=1-31

# Check if filename has been supplied
if [ -z $1 ]
then
    echo "ERROR: No input specified"
    exit -1
fi

# Check if file exists
if [ -e $1 ]
then
    # Find the n-th image in the input file
    image=$(cat $1 | head -n ${SLURM_ARRAY_TASK_ID} | tail -n 1)
    echo "Processing image: " $image

    # Get the directory in which the file is stored
    dirname=$( dirname $image)
    filename=$( basename $image)
    
    # Determine width and height of the image
    width=$(identify -format "%w" $dirname/$filename)
    height=$(identify -format "%h" $dirname/$filename)
    echo "Width: " $width
    echo "Height: " $height
    
    # Clean up the module environment
    module purge
    # Load the compilers
    module load foss/2018a
    # Compile the program
    make

    # Convert the jpg file to the rgb format for easy processing
    convert $dirname/$filename $filename.rgb
    # Run the convolution filter program on the image
    ./mpi_omp_conv $filename.rgb $width $height 1 rgb
    # Convert the resulting file back to jpg format
    convert -size ${width}x${height}  -depth 8 conv_$filename.rgb conv_$filename
    
    # Remove the intermediate files
    rm $filename.rgb conv_$filename.rgb
else
    echo "ERROR: File does not exist"
    exit -1
fi
