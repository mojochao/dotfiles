# ==============================================================================
# Build shell
# ==============================================================================

# Setting SHELL to bash allows bash commands to be executed by recipes.
# Options are set to exit when a recipe line exits non-zero or a piped command fails.
SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -ec

# Show help by default
.DEFAULT_GOAL := help

# ==============================================================================
# Build variables
# ==============================================================================

ROOT_DIR ?= $(PWD)

# ==============================================================================
# Build targets
# ==============================================================================

# The default help target prints out all targets with their descriptions within
# their categories. The categories are defined by '##@' and the target
# descriptions by '##'. The `awk` command is responsible for reading the
# entire set of makefiles included in this invocation, looking for lines of the
# file as xyz: ## something, and then pretty-format the target and help. Then,
# if there's a line with ##@ something, that gets pretty-printed as a category.
# More info on the usage of ANSI control characters for terminal formatting:
# https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters
# More info on the awk command:
# http://linuxcommand.org/lc3_adv_awk.php

##@ Info targets

.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: vars
vars: ## Show environment variables used by this Makefile
	@echo "ROOT_DIR:  $(ROOT_DIR)"

##@ Install targets

.PHONY: install
install: ## Install dotfiles
	@echo "Installing dotfiles ..."
	@./dotfiles install

.PHONY: uninstall
uninstall: ## Uninstall dotfiles
	@echo "Uninstalling dotfiles ..."
	@./dotfiles uninstall
