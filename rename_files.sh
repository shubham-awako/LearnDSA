#!/bin/bash

# Function to rename files in a directory based on the order in README.md
rename_files_from_readme() {
    local dir="$1"
    local readme_path="${dir}/README.md"
    
    # Check if README exists
    if [ ! -f "$readme_path" ]; then
        echo "README not found in $dir"
        return
    fi
    
    echo "Processing $dir..."
    
    # Extract file names and their order from the README table
    # Format is typically: "| 1 | Problem Name | Difficulty | [Solution](./Problem_Name.md) |"
    grep -E "^\|[[:space:]]*[0-9]+[[:space:]]*\|" "$readme_path" | while read -r line; do
        # Extract the number
        number=$(echo "$line" | sed -E 's/^\|[[:space:]]*([0-9]+).*/\1/')
        
        # Extract the file path
        file_path=$(echo "$line" | sed -E 's/.*\[Solution\]\((\.\/[^)]+)\).*/\1/')
        
        # Skip if we couldn't extract the number or file path
        if [ -z "$number" ] || [ -z "$file_path" ]; then
            continue
        fi
        
        # Remove the ./ prefix from the file path
        file_name=$(basename "$file_path")
        
        # Check if the file exists
        if [ ! -f "${dir}/${file_name}" ]; then
            echo "  Warning: File ${dir}/${file_name} not found"
            continue
        fi
        
        # Format the number with leading zeros
        padded_number=$(printf "%02d" "$number")
        
        # Create the new file name
        new_file_name="${padded_number}_${file_name}"
        
        # Skip if the file is already properly named
        if [[ "$file_name" == "${padded_number}_"* ]]; then
            echo "  Skipping already numbered file: ${file_name}"
            continue
        fi
        
        # Rename the file
        mv "${dir}/${file_name}" "${dir}/${new_file_name}"
        
        # Update the README.md to reference the new file name
        sed -i '' "s|\./${file_name}|./${new_file_name}|g" "$readme_path"
        
        echo "  Renamed: ${file_name} -> ${new_file_name}"
    done
    
    echo "Completed processing $dir"
}

# Process each numbered directory
for dir in [0-9][0-9]_*/; do
    # Remove trailing slash
    dir=${dir%/}
    rename_files_from_readme "$dir"
done

echo "All directories processed!"