#!/bin/bash

source_dir="$(pwd)/home"

if [ ! -d "$source_dir" ]; then
    echo "Directory $source_dir does not exist."
    exit 1
fi

target_base="$HOME"

cd "$source_dir" || exit

# Function to check and create symlinks
symlink_file() {
    local src="$1"
    local dest="$2"

    # Check if the destination is already a symlink and points to the correct target
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        echo "$dest is already a symlink pointing to the correct target."
    elif [ ! -e "$dest" ]; then
        ln -sf "$src" "$dest"
        echo "Created symlink for file: $src -> $dest"
    else
        echo "$dest already exists as a file at $dest. Please backup and remove it first."
    fi
}

# Function to recursively symlink a directory and its contents
symlink_directory() {
    local dir="$1"
    local target_path="$2"

    for item in "$dir"/* "$dir"/.[!.]*; do
        if [ -e "$item" ]; then
            local item_name=$(basename "$item")
            local target_item="$target_path/$item_name"
            
            # Ensure the target directory exists before creating symlinks
            if [ -d "$item" ]; then
                if [ ! -d "$target_item" ]; then
                    mkdir -p "$target_item"  # Create the directory if it doesn't exist
                    echo "Created directory: $target_item"
                fi
                symlink_directory "$item" "$target_item"  # Recursively symlink directories
            elif [ -f "$item" ]; then
                symlink_file "$item" "$target_item"  # Create symlink for files using symlink_file
            fi
        fi
    done
}

# Loop through all files and directories in the source directory
for item in * .[^.]*; do
    if [ -e "$item" ]; then
        target_path="$target_base/$item"

        if [ -d "$item" ]; then
            if [ ! -d "$target_path" ]; then
                mkdir -p "$target_path"  # Create the directory if it doesn't exist
                echo "Created directory: $target_path"
            fi
            symlink_directory "$(pwd)/$item" "$target_path"  # Recursively symlink directories
        elif [ -f "$item" ]; then
            symlink_file "$(pwd)/$item" "$target_path"  # Create symlink for files
        fi
    fi
done

