#!/bin/bash

# Check if an argument was provided
if [ -z "$1" ]
    then
        echo "No argument supplied. Please provide the type of source files to generate (ex: cpp, python, etc)"
        exit 1
fi

# Remove the generated directory if it exists
if [ -d "generated" ]
    then
        rm -rf generated
fi

# Create the generated directory if it doesn't exist
mkdir -p generated

# Change the working directory to ./src
cd src

# Generate the source files for each .proto file in the src directory
for file in *.proto
do
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    filename="${filename%.*}"

    # Generate the source files based on the provided argument
    case "$1" in
        cpp)
            protoc --cpp_out=../generated "$file"
            ;;
        python)
            protoc --python_out=../generated "$file"
            ;;
        *)
            echo "Invalid argument. Please provide a valid type of source files to generate (ex: cpp, python, etc)"
            exit 1
            ;;
    esac
done
