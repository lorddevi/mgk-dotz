#!/bin/bash

# Check if correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <directory> <old_color> <new_color>"
    echo "Example: $0 ./dirname '#242424' '#2E3440'"
    exit 1
fi

# Assign command-line arguments to variables
IMAGE_DIR="$1"
OLD_COLOR="$2"
NEW_COLOR="$3"

# Check if the directory exists
if [ ! -d "$IMAGE_DIR" ]; then
    echo "Error: Directory '$IMAGE_DIR' does not exist."
    exit 1
fi

# Check if ImageMagick is installed and determine the correct command
if command -v magick &> /dev/null; then
    CONVERT_CMD="magick"
elif command -v convert &> /dev/null; then
    echo "Warning: Using older 'convert' command. Consider upgrading ImageMagick."
    CONVERT_CMD="convert"
else
    echo "Error: ImageMagick is not installed. Please install it and try again."
    exit 1
fi

# Find all image files and process them
find "$IMAGE_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) -print0 | 
while IFS= read -r -d '' file; do
    echo "Processing: $file"
    # Create a temporary file
    temp_file=$(mktemp)
    # Process the image and save to temporary file
    if $CONVERT_CMD "$file" -fuzz 5% -fill "$NEW_COLOR" -opaque "$OLD_COLOR" "$temp_file"; then
        # If successful, replace the original file with the temporary file
        mv "$temp_file" "$file"
        echo "Updated: $file"
    else
        # If there was an error, remove the temporary file and report the error
        rm "$temp_file"
        echo "Error processing: $file"
    fi
done

echo "Color replacement complete!"
