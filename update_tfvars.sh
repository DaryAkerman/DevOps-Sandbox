#!/bin/bash

# File path to terraform.tfvars
TFVARS_FILE="terraform.tfvars"

# Check if terraform.tfvars exists
if [ ! -f "$TFVARS_FILE" ]; then
    echo "Error: $TFVARS_FILE file does not exist. Please create it before running this script."
    exit 1
fi

# Get user input for students
echo "Enter student names (comma-separated):"
read -r student_names

# Parse student names into an array
IFS=',' read -r -a students_array <<< "$student_names"

# Get user input for each student's email
declare -A student_info
for student in "${students_array[@]}"; do
    student=$(echo "$student" | xargs)
    echo "Enter email for $student:"
    read -r email
    student_info["$student"]="name = \"$student\"\n    email = \"$email\""
done

# Read existing terraform.tfvars content
existing_content=$(<"$TFVARS_FILE")

# Update or insert 'students'
if grep -q "^students =" "$TFVARS_FILE"; then
    sed -i "/^students =/c\students = [$(printf '"%s", ' "${students_array[@]}" | sed 's/, $//')]" "$TFVARS_FILE"
else
    echo -e "\nstudents = [$(printf '"%s", ' "${students_array[@]}" | sed 's/, $//')]" >>"$TFVARS_FILE"
fi

# Update or insert 'students_info'
if grep -q "^students_info =" "$TFVARS_FILE"; then
    # Remove old students_info
    sed -i "/^students_info = {/,/^}/d" "$TFVARS_FILE"
fi

# Append the new 'students_info'
echo -e "\nstudents_info = {" >>"$TFVARS_FILE"
for student in "${!student_info[@]}"; do
    echo -e "  $student = {\n    ${student_info[$student]}\n  }" >>"$TFVARS_FILE"
done
echo "}" >>"$TFVARS_FILE"

echo "Updated $TFVARS_FILE successfully."
