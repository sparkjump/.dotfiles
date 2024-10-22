# Dotfiles

This repository contains my configuration files (dotfiles) for various tools and applications. 
The goal is to maintain a consistent development environment across all machines.

## Examples included

- **Package Manager:** Homebrew / APT
- **Version Control:** Git
- **Shell:** Zsh (with Oh My Zsh)

## Installation

To set up these dotfiles on your machine, follow these steps:

1. **Clone the repository:**
   ```bash
   chmod +x .dotfiles/install.sh
   ./.dotfiles/bootstrap.sh
   ```

## Testing

Use the dockerfile to test the settings.

Build and run the container:
``` bash
docker build -f dotfiles-test.Dockerfile -t dotfiles-test .
docker run -it --rm dotfiles-test
```

After the test, simply remove the container and rebuild to start fresh.
``` bash
docker rm $(docker ps -aq)
docker build -f dotfiles-test.Dockerfile -t dotfiles-test .
```
