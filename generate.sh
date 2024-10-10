#!/bin/bash

# Display directories and prompt for selection
select_directory() {
    local parent_dir="$1"
    echo "Select a directory from $parent_dir:"
    
    # List directories in the parent directory
    select dir in $(find "$parent_dir" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;) "Cancel"; do
        if [[ "$dir" == "Cancel" ]]; then
            echo "Operation canceled."
            exit 1
        elif [ -n "$dir" ]; then
            echo "You selected: $dir"
            selected_dir="$parent_dir/$dir"
            break
        else
            echo "Invalid selection, try again."
        fi
    done
}


# Call function to select boilerplates directory
base_boilerplate=".boilerplates"
selected_dir="$base_boilerplate"

# Keep selecting subdirectories if any exist
while true; do
    select_directory "$selected_dir"
    
    # Check if there are further subdirectories
    if [ -z "$(find "$selected_dir" -mindepth 1 -maxdepth 1 -type d)" ]; then
        echo "No more subdirectories. Using boilerplate from: $selected_dir"
        break
    fi
    echo "Using boilerplate from: $selected_dir"
done

# Prompt user for the target directory with tab completion
read -e -p "Enter the target directory (absolute or relative path): " target_directory
# Check if the target directory exists
if [ ! -d "$target_directory" ]; then
    echo "Target directory does not exist. Please provide a valid directory."
    exit 1
fi

# Prompt user for folder name (file name will follow the folder name)
read -p "Enter the folder name: " folder_name


# Create the new folder using the provided folder name in the target directory
mkdir -p "$target_directory/$folder_name"

# Copy all files and subfolders from the selected boilerplate folder to the new folder
cp -r "$selected_dir"/* "$target_directory/$folder_name"

# Replace placeholders with the folder name in copied files
for file in "$folder_name"/*; do
    sed -i "s/{{fileName}}/$folder_name/g" "$file"
done

# Rename all files to follow the folder name but keep their extensions
for file in "$folder_name"/*; do
    extension="${file#*.}" # Extract file extension
    mv "$file" "$folder_name/$folder_name.$extension"
done

echo "Boilerplate copied to $folder_name with files renamed to $folder_name with their respective extensions."
