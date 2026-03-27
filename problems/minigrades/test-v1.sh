#!/bin/bash

# --- Color Definitions ---
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# --- Variables ---
DATA_DIR=".minigrades"
SOLUTION="solution.py"

# --- Helper Functions ---
run_cmd() {
    # Ensure environment is initialized for every command to maintain state consistency
    python3 "$SOLUTION" init > /dev/null 2>&1
    # Execute the command and trim whitespace using xargs
    result=$(python3 "$SOLUTION" "$@" | xargs)
    echo "$result"
}

setup() {
    # Reset the environment by removing the data directory
    if [ -d "$DATA_DIR" ]; then
        rm -rf "$DATA_DIR"
    fi
}

assert_equals() {
    local test_name=$1
    local expected=$2
    local actual=$3

    if [ "$actual" == "$expected" ]; then
        echo -e "${GREEN}[PASSED]${NC} $test_name"
    else
        echo -e "${RED}[FAILED]${NC} $test_name"
        echo -e "  Expected: $expected"
        echo -e "  Actual:   $actual"
    fi
}

assert_contains() {
    local test_name=$1
    local expected=$2
    local actual=$3

    if [[ "$actual" == *"$expected"* ]]; then
        echo -e "${GREEN}[PASSED]${NC} $test_name"
    else
        echo -e "${RED}[FAILED]${NC} $test_name"
        echo -e "  Expected to contain: $expected"
        echo -e "  Actual:              $actual"
    fi
}

# --- Test Execution ---

echo "Running mini-grades v1 test suite..."
echo "---------------------------------"

# --- add_student tests ---
setup
response=$(run_cmd add 101 Berke)
assert_equals "test_add_student_success" "Student added successfully." "$response"

setup
run_cmd add 101 Berke > /dev/null
response=$(run_cmd add 101 Efe)
assert_equals "test_add_student_duplicate" "Error: Student with ID 101 already exists." "$response"

setup
response=$(run_cmd add abc Berke)
assert_equals "test_add_student_non_numeric_id" "Invalid input: Please enter a numeric value." "$response"

# --- add_grade tests ---
setup
run_cmd add 101 Berke > /dev/null
response=$(run_cmd add-grade 101 80)
assert_equals "test_add_grade_success" "Grades added successfully for student 101." "$response"

setup
run_cmd add 101 Berke > /dev/null
response=$(run_cmd add-grade 101 105)
assert_equals "test_add_grade_range_error" "Invalid grade: Grades must be between 0 and 100." "$response"

setup
run_cmd add 101 Berke > /dev/null
response=$(run_cmd add-grade 101 abc)
assert_equals "test_add_grade_non_numeric" "Invalid input: Please enter a numeric value." "$response"

setup
response=$(run_cmd add-grade 999 80)
assert_equals "test_add_grade_student_not_found" "Error: No student found with ID 999." "$response"

# --- delete_student tests ---
setup
run_cmd add 101 Berke > /dev/null
response=$(run_cmd delete 101)
assert_equals "test_delete_student_success" "Student deleted successfully." "$response"

setup
response=$(run_cmd delete 999)
assert_equals "test_delete_student_not_found" "Error: No student found with ID 999." "$response"

# --- calculate_average tests (Mock in v1) ---
setup
run_cmd add 101 Berke > /dev/null
response=$(run_cmd average 101)
assert_equals "test_calculate_average_v1_mock" "Average calculation will be implemented in future weeks." "$response"

setup
response=$(run_cmd average 999)
assert_equals "test_calculate_average_not_found" "Error: No student found with ID 999." "$response"

# --- list_students tests ---
setup
run_cmd add 101 Berke > /dev/null
run_cmd add 102 Efe > /dev/null
response=$(run_cmd list)
assert_contains "test_list_students_contains_101" "101 | Berke" "$response"
assert_contains "test_list_students_contains_102" "102 | Efe" "$response"

setup
response=$(run_cmd list)
assert_equals "test_list_students_empty" "Error: No students found in the system. Operation aborted." "$response"

# --- unknown-command test ---
setup
response=$(run_cmd hello)
assert_contains "test_unknown_command" "Unknown command: hello. Please select from the menu." "$response"

# --- initialization test ---
# We remove the data dir and run a command without 'init' (run_cmd calls init, so we call python directly)
rm -rf "$DATA_DIR"
response=$(python3 "$SOLUTION" list | xargs)
assert_equals "test_not_initialized" "Not initialized. Run: python solution.py init" "$response"

echo "---------------------------------"
echo "Test execution completed for v1."
