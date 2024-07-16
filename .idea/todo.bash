

TODO_FILE="todo.txt"
DONE_FILE="done.txt"
DELETED_FILE="deleted.txt"

# Create files if they don't exist
touch "$TODO_FILE" "$DONE_FILE" "$DELETED_FILE"

# Function to display the menu
display_menu() {
    echo "To-Do List Manager"
    echo "1. Add a new task"
    echo "2. Display unfinished tasks"
    echo "3. Mark task as done"
    echo "4. Display completed tasks"
    echo "5. Delete a task"
    echo "6. Display deleted tasks"
    echo "7. Search tasks"
    echo "8. Exit"
    echo "Choose an option:"
}

# Function to add a new task
add_task() {
    read -p "Enter the new task: " task
    echo "$task" >> "$TODO_FILE"
    echo "Task added."
}

# Function to display unfinished tasks with row numbers
display_unfinished_tasks() {
    echo "Unfinished tasks:"
    nl -w2 -s'. ' "$TODO_FILE"
}

# Function to display completed tasks with row numbers
display_completed_tasks() {
    echo "Completed tasks:"
    nl -w2 -s'. ' "$DONE_FILE"
}

# Function to mark a task as done
mark_task_as_done() {
    display_unfinished_tasks
    read -p "Enter the number of the task to mark as done: " task_num
    task=$(sed "${task_num}q;d" "$TODO_FILE")
    if [ -n "$task" ]; then
        sed -i "${task_num}d" "$TODO_FILE"
        echo "$task" >> "$DONE_FILE"
        echo "Task marked as done."
    else
        echo "Invalid task number."
    fi
}

# Function to delete a task from the unfinished list
delete_task_from_todo() {
    display_unfinished_tasks
    read -p "Enter the number of the task to delete: " task_num
    task=$(sed "${task_num}q;d" "$TODO_FILE")
    if [ -n "$task" ]; then
        sed -i "${task_num}d" "$TODO_FILE"
        echo "$task" >> "$DELETED_FILE"
        echo "Task deleted from unfinished tasks."
    else
        echo "Invalid task number."
    fi
}

# Function to delete a task from the completed list
delete_task_from_done() {
    display_completed_tasks
    read -p "Enter the number of the task to delete: " task_num
    task=$(sed "${task_num}q;d" "$DONE_FILE")
    if [ -n "$task" ]; then
        sed -i "${task_num}d" "$DONE_FILE"
        echo "$task" >> "$DELETED_FILE"
        echo "Task deleted from completed tasks."
    else
        echo "Invalid task number."
    fi
}

# Function to delete a task
delete_task() {
    echo "1. Delete from unfinished tasks"
    echo "2. Delete from completed tasks"
    read -p "Choose an option: " delete_option

    case $delete_option in
        1) delete_task_from_todo ;;
        2) delete_task_from_done ;;
        *) echo "Invalid option. Please try again." ;;
    esac
}

# Function to display deleted tasks with row numbers
display_deleted_tasks() {
    echo "Deleted tasks:"
    nl -w2 -s'. ' "$DELETED_FILE"
}

# Function to search tasks
search_tasks() {
    read -p "Enter search term: " term
    echo "Unfinished tasks:"
    grep -n "$term" "$TODO_FILE"
    echo "Completed tasks:"
    grep -n "$term" "$DONE_FILE"
    echo "Deleted tasks:"
    grep -n "$term" "$DELETED_FILE"
}

# Main loop
while true; do
    display_menu
    read -p "Select an option: " option

    case $option in
        1) add_task ;;
        2) display_unfinished_tasks ;;
        3) mark_task_as_done ;;
        4) display_completed_tasks ;;
        5) delete_task ;;
        6) display_deleted_tasks ;;
        7) search_tasks ;;
        8) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac

    echo
done
