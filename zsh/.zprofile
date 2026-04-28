# Homebrew (runs once instead of every shell)
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# LLVM (depends on brew, so keep it here)
export LLVM_SYS_140_PREFIX=$(brew --prefix llvm@14)

# java
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))
export PATH="$JAVA_HOME/bin:$PATH"

# Shared library path
export LD_LIBRARY_PATH="/home/linuxbrew/.linuxbrew/lib:$LD_LIBRARY_PATH"

# NVM base (lazy loading happens in .zshrc)
export NVM_DIR="$HOME/.nvm"

# General PATH additions that don't need to rerun constantly
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
