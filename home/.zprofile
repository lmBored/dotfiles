eval "$(/opt/homebrew/bin/brew shellenv)"

# Setting PATH for Python 3.10
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PATH

# Added by Toolbox App
export PATH="$PATH:/Users/master/Library/Application Support/JetBrains/Toolbox/scripts"

# Function to automatically compile zsh configuration files
# Merged function to check and compile zsh files
zsh_compile_check() {
    # Ensure zcompile function is available
    autoload -U zcompile

    # Function to check and compile a file if needed
    local zcompare
    zcompare() {
        if [[ -f "$1" && ( ! -f "$1.zwc" || "$1" -nt "$1.zwc" ) ]]; then
            echo "Compiling $1..."
            zcompile -R "$1" 2>/dev/null || echo "Failed to compile $1"
        fi
    }

    # Compile main configuration files
    for file in "${HOME}/.zshrc" "${HOME}/.zcompdump-$ZSH_VERSION" "${HOME}/.p10k.zsh"; do
        if [[ "$file" != "${HOME}/.zshrc" && -f "$file" && ( ! -f "$file.zwc" || "$file" -nt "$file.zwc" ) ]]; then
            echo "Compiling $file..."
            zcompile "$file" 2>/dev/null || echo "Failed to compile $file"
        fi
    done

    # Compile oh-my-zsh scripts if they exist
    #local ZSH="${HOME}/.oh-my-zsh"
    #if [[ -d "$ZSH" ]]; then
    #    for file in "$ZSH"/**/*.zsh; do
    #        zcompare "$file"
    #    done
    #fi

    # Additional plugins or custom files
    for file in "$ZSH/custom/**/^(README.md|*.zwc)(.)"; do
        zcompare "$file"
    done
}

# Run the compilation check asynchronously
zsh_compile_check &

