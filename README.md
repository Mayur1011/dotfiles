# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system. (Below are the commands for fedora).

### Git

```
sudo dnf install git
```

### Stow

```
sudo dnf install stow
```

## Installation

First, clone this repo in your $HOME directory

```
git clone git@github.com:Mayur1011/dotfiles.git
cd dotfiles
```

Now, use GNU stow to create symlinks

``` 
stow .
```

