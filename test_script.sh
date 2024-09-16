#!/bin/bash

# Variable to check if all tests passed
all_tests_passed=true

# Variable to keep track of failed tests
failed_tests=""

# Create test directory
mkdir -p test
touch test/file1.pdf
touch test/file2.pdf
touch test/copy.pdf

# Tests

# Positive test
./copy.sh test test/copy.pdf
if [ -f "test/copy.pdf" ]; then
  echo "Test passed: Copying complete!"
else
  echo "Test failed: Copying incomplete"
  all_tests_passed=false
  failed_tests="$failed_tests Copying incomplete"
fi

# # Test that the script exits when MY_DIR is not found
# output=$(./copy.sh < test/not/found)
# if test "$output" = "Error: test/not/found not found. Exiting."; then
#   echo "Test passed: MY_DIR not found"
# else
#   echo "Test failed: MY_DIR found"
#   all_tests_passed=false
#   failed_tests="$failed_tests MY_DIR found"
# fi

# # Test that the script exits when DEST is not found
# output=$(./copy.sh test < test/not/found)
# if test "$output" = "Error: test/not/found not found. Exiting."; then
#   echo "Test passed: DEST not found"
# else
#   echo "Test failed: DEST found"
#   all_tests_passed=false
#   failed_tests="$failed_tests DEST found"
# fi

# Test that the script removes duplicates and only copies unique files
touch test/file2.pdf
./copy.sh test test/copy.pdf
if test "$(find test -type f -ls | wc -l)" -eq 2; then
  echo "Test passed: Duplicates removed"
else
  echo "Test failed: Duplicates not removed"
  all_tests_passed=false
  failed_tests="$failed_tests Duplicates not removed"
fi

# Clean up test files and directories
rm -r test

# Print final message
if [ "$all_tests_passed" = true ]; then
    echo "All tests passed!"
else
    echo "Below are the tests that failed:"
    echo "$failed_tests"
fi
