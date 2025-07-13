# Version-Aware Pre-commit System

A revolutionary pre-commit configuration that automatically adjusts strictness based on your project's version number. **Pedantic to Pragmatic sliding scale** - from very lenient (0.1.x) to very strict (1.0+).

## 🎯 The Problem

Traditional pre-commit setups are binary: either too strict (blocking development) or too lenient (allowing poor code quality). This creates friction between "move fast" and "maintain quality."

## 🚀 The Solution

**Version-driven strictness**: Your pre-commit checks automatically scale with your project's maturity level, guided by the version number in `pyproject.toml`.

## 📊 Strictness Levels

| Version Range | Strictness   | Description                          | Enabled Checks                      |
| ------------- | ------------ | ------------------------------------ | ----------------------------------- |
| **0.1.x**     | Very Lenient | Early development, rapid prototyping | Basic hygiene, security, formatting |
| **0.5.x**     | Moderate     | Growing codebase, adding structure   | + Type checking (warnings only)     |
| **0.9.x**     | Strict       | Pre-release, quality focus           | + Docstring style, markdown linting |
| **1.0+**      | Very Strict  | Production-ready, maintainable code  | All checks, fail on any warning     |

## 🛠️ Installation

1. **Copy the files:**

   ```bash
   cp scripts/precommit_version_checker.py your-project/
   cp .pre-commit-config.yaml your-project/
   ```

2. **Install pre-commit:**

   ```bash
   pip install pre-commit
   pre-commit install
   ```

3. **Update your `pyproject.toml`:**
   ```toml
   [project]
   name = "your-project"
   version = "0.1.0"  # Start lenient, increase as you mature
   ```

## 🎮 Usage

### Basic Usage

```bash
# Your pre-commit automatically adapts to your version
git commit -m "Your changes"
```

### Version Progression

```bash
# Start lenient (0.1.0)
version = "0.1.0"  # Only basic checks

# Add type checking (0.5.0)
version = "0.5.0"  # + mypy (warnings)

# Pre-release quality (0.9.0)
version = "0.9.0"  # + docstrings, markdown

# Production ready (1.0.0)
version = "1.0.0"  # All checks, strict mode
```

## 🔧 Configuration

### Customizing Strictness Levels

Edit `scripts/precommit_version_checker.py` to customize:

```python
def get_strictness_level(version):
    major, minor, _ = parse_version(version)

    if major == 0:
        if minor < 5:
            return "very_lenient"
        elif minor < 9:
            return "moderate"
        else:
            return "strict"
    else:
        return "very_strict"
```

### Adding Custom Hooks

1. Add your hook to `.pre-commit-config.yaml`
2. Update `should_enable_hook()` in the version checker
3. Choose which strictness levels should enable it

## 🎯 Benefits

### For Junior Developers

- **No overwhelm**: Start with basic checks, learn gradually
- **Clear progression**: Version number shows codebase maturity
- **Gentle guidance**: Best practices introduced when ready

### For Teams

- **Shared standards**: Version reflects team's quality commitment
- **No debates**: The codebase tells the truth about itself
- **Natural growth**: Standards evolve with the project

### For Open Source

- **Welcoming**: New contributors aren't blocked by strict rules
- **Quality**: Maintains standards as project matures
- **Transparency**: Version number signals project health

## 🚀 Demo

### Test Different Versions

```bash
# Test very lenient (0.1.0)
sed -i 's/version = ".*"/version = "0.1.0"/' pyproject.toml
pre-commit run --all-files

# Test moderate (0.5.0)
sed -i 's/version = ".*"/version = "0.5.0"/' pyproject.toml
pre-commit run --all-files

# Test strict (0.9.0)
sed -i 's/version = ".*"/version = "0.9.0"/' pyproject.toml
pre-commit run --all-files

# Test very strict (1.0.0)
sed -i 's/version = ".*"/version = "1.0.0"/' pyproject.toml
pre-commit run --all-files
```

## 🤝 Contributing

This system is designed to be:

- **Universal**: Works for any Python project
- **Customizable**: Easy to adapt to your needs
- **Progressive**: Grows with your project

### Ideas for Extension

- Support for other languages (JavaScript, Rust, etc.)
- Custom strictness levels for different file types
- Integration with CI/CD pipelines
- Visual badges showing current strictness level

## 📈 The Philosophy

> "Code quality should be a journey, not a destination. This system guides developers toward best practices gradually and naturally, without overwhelming them or compromising on quality."

## 🏷️ License

MIT License - Use this system to make better developers and better code, one version at a time.

---

**Ready to level up your development workflow? Start with version 0.1.0 and watch your codebase mature!** 🚀
