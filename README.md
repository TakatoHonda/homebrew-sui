# Homebrew Tap for Sui

This is a Homebrew tap for [Sui](https://github.com/TakatoHonda/sui-lang) - a programming language optimized for LLM code generation.

## Installation

```bash
brew tap TakatoHonda/sui
brew install sui-lang
```

## Usage

```bash
# Run Sui code
sui examples/fibonacci.sui

# Transpile Sui to Python
sui2py examples/fibonacci.sui

# Convert Python to Sui
py2sui your_code.py
```

## Upgrade

```bash
brew upgrade sui-lang
```

## Uninstall

```bash
brew uninstall sui-lang
brew untap TakatoHonda/sui
```

