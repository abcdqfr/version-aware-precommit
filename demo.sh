#!/bin/bash

# Version-Aware Pre-commit Demo Script
# This script demonstrates how the pre-commit strictness changes with version

set -e

echo "🚀 Version-Aware Pre-commit Demo"
echo "================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to update version and run pre-commit
demo_version() {
    local version=$1
    local description=$2

    echo -e "${BLUE}Testing version: ${version} - ${description}${NC}"
    echo "----------------------------------------"

    # Update version in pyproject.toml
    sed -i "s/version = \".*\"/version = \"${version}\"/" pyproject.toml

    # Run version checker to show strictness level
    echo -e "${YELLOW}Version checker output:${NC}"
    python scripts/precommit_version_checker.py

    echo ""
    echo -e "${YELLOW}Running pre-commit (showing which hooks are enabled/disabled):${NC}"

    # Run pre-commit and capture output
    if pre-commit run --all-files 2>&1 | tee /tmp/precommit_output; then
        echo -e "${GREEN}✅ Pre-commit passed for version ${version}${NC}"
    else
        echo -e "${RED}❌ Pre-commit failed for version ${version}${NC}"
    fi

    echo ""
    echo "========================================"
    echo ""
}

# Check if we're in the right directory
if [ ! -f "pyproject.toml" ] || [ ! -f "scripts/precommit_version_checker.py" ]; then
    echo -e "${RED}Error: Please run this script from the project root directory${NC}"
    echo "Make sure pyproject.toml and scripts/precommit_version_checker.py exist"
    exit 1
fi

# Check if pre-commit is installed
if ! command -v pre-commit &> /dev/null; then
    echo -e "${RED}Error: pre-commit is not installed${NC}"
    echo "Install it with: pip install pre-commit"
    exit 1
fi

echo -e "${GREEN}Starting demo...${NC}"
echo ""

# Demo each version level
demo_version "0.1.0" "Very Lenient - Early development, rapid prototyping"
demo_version "0.5.0" "Moderate - Growing codebase, adding structure"
demo_version "0.9.0" "Strict - Pre-release, quality focus"
demo_version "1.0.0" "Very Strict - Production-ready, maintainable code"

echo -e "${GREEN}🎉 Demo complete!${NC}"
echo ""
echo "Key observations:"
echo "- Version 0.1.x: Only basic checks run (ruff, black, bandit)"
echo "- Version 0.5.x: Adds type checking (mypy)"
echo "- Version 0.9.x: Adds docstring and markdown checks"
echo "- Version 1.0+: All checks enabled, strict mode"
echo ""
echo "This system automatically guides developers toward best practices"
echo "as their codebase matures, without overwhelming them early on!"
