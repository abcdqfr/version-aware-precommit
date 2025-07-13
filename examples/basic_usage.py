#!/usr/bin/env python3
"""Example Python file to demonstrate version-aware pre-commit.

This file will be checked by pre-commit hooks, and the strictness
of the checks will depend on the version in pyproject.toml.

Try changing the version in pyproject.toml and running:
  pre-commit run --all-files
"""

import os
import sys
from typing import Optional, List


def greet(name: str, times: int = 1) -> str:
    """Greet someone multiple times.

    Args:
        name: The name to greet
        times: Number of times to greet (default: 1)

    Returns:
        A greeting string
    """
    if times <= 0:
        return ""

    greeting = f"Hello, {name}!"
    return " ".join([greeting] * times)


def process_items(items: List[str], filter_empty: bool = True) -> List[str]:
    """Process a list of items.

    This function demonstrates different code quality levels:
    - Version 0.1.x: Basic syntax and security checks only
    - Version 0.5.x: + Type checking (warnings)
    - Version 0.9.x: + Docstring style enforcement
    - Version 1.0+: All checks, strict mode

    Args:
        items: List of items to process
        filter_empty: Whether to filter out empty items

    Returns:
        Processed list of items
    """
    if not items:
        return []

    processed = []
    for item in items:
        if filter_empty and not item.strip():
            continue
        processed.append(item.strip())

    return processed


def main():
    """Main function demonstrating the version-aware system."""
    # This would trigger different levels of checking:
    # - 0.1.x: Basic syntax check
    # - 0.5.x: + Type checking
    # - 0.9.x: + Docstring style
    # - 1.0+: All checks

    names = ["Alice", "Bob", "Charlie"]
    for name in names:
        print(greet(name, 2))

    items = ["item1", "", "item2", "  ", "item3"]
    result = process_items(items)
    print(f"Processed items: {result}")


if __name__ == "__main__":
    main()
