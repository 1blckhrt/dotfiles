SHELL := /bin/bash
MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
DOT_DIR := $(HOME)/dot
HM_SRC := $(DOT_DIR)/nix
HM_DEST := $(HOME)/.config/home-manager
REPO_URL := https://github.com/1blckhrt/dotfiles.git
FLAKE_REF := $(shell whoami)@$(shell hostname)
NIX_PROFILE := $(HOME)/.nix-profile

.PHONY: nix update-dotfiles home system update all

nix:
	@echo "› Ensuring Nix is installed"
	if ! command -v nix >/dev/null 2>&1; then \
		echo "Nix not found. Installing determinative Nix..."; \
		curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate; \
		echo "✅ Nix installed. Please restart your shell or source your profile:"; \
		echo "   source $$HOME/.nix-profile/etc/profile.d/nix.sh"; \
		exit 0; \
	else \
		echo "› Nix is already installed."; \
	fi
	@echo "✅ Nix setup done."

update-dotfiles: 
	if [[ -d "$(DOT_DIR)/.git" ]]; then \
		echo "› Pulling latest changes in $(DOT_DIR)"; \
		git -C "$(DOT_DIR)" pull --ff-only; \
	else \
		echo "› Cloning dotfiles from $(REPO_URL) to $(DOT_DIR)"; \
		git clone "$(REPO_URL)" "$(DOT_DIR)"; \
	fi

home: 
	@echo "› Setting up Home Manager for $(FLAKE_REF)"
	if [[ ! -d "$(HM_SRC)" ]]; then \
		echo "❌ Expected $(HM_SRC) to exist but it doesn't."; \
		exit 1; \
	fi

	if [[ -L "$(HM_DEST)" || -e "$(HM_DEST)" ]]; then \
		echo "› Removing existing $(HM_DEST)"; \
		rm -rf "$(HM_DEST)"; \
	fi
	echo "› Linking $(HM_DEST) → $(HM_SRC)"; \
	ln -s "$(HM_SRC)" "$(HM_DEST)"

	if command -v home-manager >/dev/null 2>&1; then \
		echo "› Running home-manager switch for $(FLAKE_REF)"; \
		home-manager switch --flake .#$(FLAKE_REF); \
	else \
		echo "› 'home-manager' not found on PATH, entering nix shell..."; \
		nix shell nixpkgs#home-manager --command "home-manager switch --flake .#$(FLAKE_REF)"; \
	fi
	@echo "✅ Home Manager setup done."

system:
	@echo "› Running system-manager setup. This will ask for your sudo password if needed."
	if grep -q '^ID=nixos' /etc/os-release; then \
		echo "⚠️  Non-system-manager setup skipped: detected NixOS."; \
	else \
		sudo env "PATH=$$HOME/.nix-profile/bin:$$PATH" nix run 'github:numtide/system-manager' -- switch --flake .; \
		echo "› System configuration applied. A reboot may be required."; \
	fi
	@echo "✅ System setup done."


update: update-dotfiles home system

all: nix update
	@echo "✅ All setup done. Please reboot your system if necessary."


