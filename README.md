.dotfiles/
├── bootstrap.sh
├── zsh/
│   ├── install.sh
│   └── .zshrc
├── vim/
│   ├── install.sh
│   └── .vimrc
├── git/
│   ├── install.sh
│   └── .gitconfig
└── other tools/
    └── install.sh


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

