# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ "$BASH_VERSION" != "" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

# expand aliases needed by nvim
export BASH_ENV="$HOME/.bash_env"

export PATH=/usr/lib/postgresql/15/bin:$PATH

export JAVA_HOME=/opt/jdk-20.0.1
export PATH="$JAVA_HOME/bin:$PATH"

export GOPATH="$HOME/.gopath"
export PATH="$PATH:$GOPATH/bin"

# pnpm
export PNPM_HOME="/home/hacker/.local/share/pnpm"
export PATH="$PATH:$PNPM_HOME"
# pnpm end

export DENO_INSTALL="/home/hacker/.deno"
export PATH="$PATH:$DENO_INSTALL/bin"

export PATH="$PATH:$HOME/.babashka/bbin/bin"

. "$HOME/.cargo/env"

[ -f "/home/hacker/.ghcup/env" ] && source "/home/hacker/.ghcup/env"

if [ -e /home/hacker/.nix-profile/etc/profile.d/nix.sh ]; then . /home/hacker/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

eval "$(direnv hook bash)"

exec zsh
