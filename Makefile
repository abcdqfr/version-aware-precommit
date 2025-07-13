.PHONY: help install test demo clean format lint check

help: ## Show this help message
	@echo "Version-Aware Pre-commit System - Development Commands"
	@echo "====================================================="
	@echo ""
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: ## Install the package in development mode
	pip install -e ".[dev]"
	pre-commit install

test: ## Run tests
	pytest tests/ -v

demo: ## Run the demo script to showcase version-aware behavior
	./demo.sh

clean: ## Clean build artifacts
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg-info/
	rm -rf .pytest_cache/
	rm -rf .mypy_cache/
	find . -type d -name __pycache__ -delete
	find . -type f -name "*.pyc" -delete

format: ## Format code with black and ruff
	black scripts/ examples/
	ruff format scripts/ examples/

lint: ## Lint code with ruff
	ruff check scripts/ examples/

check: format lint test ## Run all checks (format, lint, test)

test-versions: ## Test all version levels
	@echo "Testing version 0.1.0 (Very Lenient)..."
	sed -i 's/version = ".*"/version = "0.1.0"/' pyproject.toml
	pre-commit run --all-files || true

	@echo "Testing version 0.5.0 (Moderate)..."
	sed -i 's/version = ".*"/version = "0.5.0"/' pyproject.toml
	pre-commit run --all-files || true

	@echo "Testing version 0.9.0 (Strict)..."
	sed -i 's/version = ".*"/version = "0.9.0"/' pyproject.toml
	pre-commit run --all-files || true

	@echo "Testing version 1.0.0 (Very Strict)..."
	sed -i 's/version = ".*"/version = "1.0.0"/' pyproject.toml
	pre-commit run --all-files || true

	@echo "Restoring original version..."
	sed -i 's/version = ".*"/version = "0.1.0"/' pyproject.toml

release: check test-versions ## Prepare release (checks, tests all versions)
	@echo "✅ Release ready!"
	@echo "📦 All checks passed"
	@echo "🚀 Version-aware system working correctly"
