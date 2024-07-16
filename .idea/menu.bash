FILES=("file1.txt" "file2.txt" "file3.txt" "file4.txt" "file5.txt")

# Function to display the menu
display_menu() {
    echo "Menu"
    echo "1. Create five empty files"
    echo "2. Add 'Hello world' to the files"
    echo "3. Replace 'world' with 'bash' in the files"
    echo "4. Make all files empty"
    echo "5. Delete all files completely"
    echo "Choose an option:"
}

# Function to create five empty files
create_files() {
    for file in "${FILES[@]}"; do
        touch "$file"
    done
    echo "Five files created."
}

# Function to add 'Hello world' to the files
add_hello_world() {
    for file in "${FILES[@]}"; do
        echo "Hello world" > "$file"
    done
    echo "'Hello world' added to the files."
}

# Function to replace 'world' with 'bash' in the files
replace_world_with_bash() {
    for file in "${FILES[@]}"; do
        if [ -f "$file" ]; then
            sed -i 's/world/bash/g' "$file"
        fi
    done
    echo "'world' replaced with 'bash' in the files."
}

# Function to make all files empty
make_files_empty() {
    for file in "${FILES[@]}"; do
        > "$file"
    done
    echo "All files have been emptied."
}

# Function to delete all files completely
delete_all_files() {
    for file in "${FILES[@]}"; do
        rm -f "$file"
    done
    echo "All files have been deleted."
}

# Main loop
while true; do
    display_menu
    read -p "Select an option: " option

    case $option in
        1) create_files ;;
        2) add_hello_world ;;
        3) replace_world_with_bash ;;
        4) make_files_empty ;;
        5) delete_all_files ;;
        *) echo "Invalid option. Please try again." ;;
    esac

    echo
done