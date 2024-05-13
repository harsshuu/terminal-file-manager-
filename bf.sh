#!/bin/bash

current_dir=$(pwd)

function list_files() {
    ls -lA --color=auto
}

function create_directory() {
    read -p "Enter directory name: " dirname
    mkdir -p "$dirname"
}

function delete_file() {
    read -p "Enter file/directory name to delete: " filename
    rm -ir "$filename"
}

function file_information() {
    read -p "Enter file name: " filename
    if [ -e "$filename" ]; then
        echo "File Information for $filename:"
        stat "$filename"
    else
        echo "File not found!"
    fi
}

function copy_file() {
    read -p "Enter source file: " source_file
    read -p "Enter destination directory: " destination_dir
    cp -ir "$source_file" "$destination_dir"
}

function move_file() {
    read -p "Enter source file: " source_file
    read -p "Enter destination directory: " destination_dir
    mv -i "$source_file" "$destination_dir"
}

function change_permissions() {
    read -p "Enter file/directory name: " target
    read -p "Enter permissions (e.g., 755): " permissions
    chmod "$permissions" "$target"
}

function search_file() {
    read -p "Enter search term: " search_term
    echo "Search results for '$search_term':"
    find . -type f -iname "*$search_term*"
}

function edit_file() {
    read -p "Enter file name to edit: " filename
    nano "$filename"
}

function navigate_directory() {
    read -p "Enter directory path (or '.' for current directory): " dir
    if [ "$dir" = "." ]; then
        dir="$current_dir"
    fi
    if [ -d "$dir" ]; then
        cd "$dir" || return
        current_dir=$(pwd)
    else
        echo "Directory not found!"
    fi
}

function print_menu() {
    echo "File Manager - $(basename "$current_dir")"
    echo "-----------------------------------"
    echo "1. List files"
    echo "2. Create directory"
    echo "3. Delete file/directory"
    echo "4. File information"
    echo "5. Copy file"
    echo "6. Move file"
    echo "7. Change permissions"
    echo "8. Search for file"
    echo "9. Edit file"
    echo "10. Navigate to directory"
    echo "11. Exit"
}

while true; do
    clear
    print_menu
    read -p "Enter your choice: " choice

    case $choice in
        1) list_files ;;
        2) create_directory ;;
        3) delete_file ;;
        4) file_information ;;
        5) copy_file ;;
        6) move_file ;;
        7) change_permissions ;;
        8) search_file ;;
        9) edit_file ;;
        10) navigate_directory ;;
        11) echo "Exiting..."
            exit ;;
        *) echo "Invalid option!" ;;
    esac

    read -p "Press Enter to continue..."
done

