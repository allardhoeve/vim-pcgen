#!/bin/bash

# Run tests for vim-pcgen plugin

echo "Running vim-pcgen tests..."

# Run the automated test
echo "Running automated test..."
vim -N -u NONE -n -c "source test_pcgen.vim" -c "quitall!"

echo ""
echo "Running manual test (with visual output)..."
vim -N -u NONE -n -c "source manual_test.vim" -c "quitall!"

echo ""
echo "Tests completed."