#!/bin/bash

source_dir="$(pwd)/home"

if [ ! -d "$source_dir" ]; then
    echo "Directory $source_dir does not exist."
    exit 1
fi

target_base="$HOME"

cd "$source_dir" || exit

# Function to recursively symlink a directory and its contents
symlink_directory() {
    local dir="$1"
    local target_path="$2"

    # Symlink the directory itself
    ln -sf "$dir" "$target_path"
    echo "Created symlink for directory: $dir -> $target_path"

    # Recursively symlink the contents of the directory
    for item in "$dir"/* "$dir"/.[!.]*; do
        if [ -e "$item" ]; then
            local item_name=$(basename "$item")
            local target_item="$target_path/$item_name"
            if [ -d "$item" ]; then
                symlink_directory "$item" "$target_item"  # Recursively handle directories
            elif [ -f "$item" ]; then
                ln -sf "$item" "$target_item"  # Create symlink for files
                echo "Created symlink for file: $item -> $target_item"
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
                mkdir -p "$target_path"
            fi
            symlink_directory "$(pwd)/$item" "$target_path"  # Recursively symlink directories
        elif [ -f "$item" ]; then
            if [ -e "$target_path" ]; then
                echo "$item already exists as a file at $target_path. Please backup and remove it first."
            else
                ln -sf "$(pwd)/$item" "$target_path"  # Create symlink for files
                echo "Created symlink for file: $item -> $target_path"
            fi
        fi
    fi
done
