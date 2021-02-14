# My Dotfiles

Here is the technique I use to automate setting up my dev environment in Manjaro using [dotfiles](https://dotfiles.github.io) while keeping it up-to-date.

It's all based on Makefile.

## Setup

```bash
cd && git clone https://github.com/sayanarijit/.files && cd .files && git checkout $(uname) && make
```

## Sync

```bash
dotsync
```

Or

```bash
cd ~/.files && make sync
```

## Manual

Theme: Aritim-Dark (layout) + ChromeOS-Dark
Window Decorators: borderline
