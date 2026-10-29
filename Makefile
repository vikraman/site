# output directories
BUILD_DIR := _site
BUILD_STAMP := $(BUILD_DIR)/.lastbuild
QUARTO_DIR := .quarto

# all source files
SOURCES := $(shell find . -type f \
	\( -name '*.qmd' -o -name '*.yml' -o -name '*.scss' -o -name '*.ejs' \
	-o -name '*.lagda.md' -o -name '*.agda' \) \
	! -path "./$(BUILD_DIR)/*" ! -path "./$(QUARTO_DIR)/*" \
	! -path "./.git/*" ! -path "./.github/*" )

# launchd services for macOS
SERVICES := org.vikraman.site-preview org.vikraman.site-watch
SERVICE_DIR := contrib/launchd
LAUNCH_AGENTS := $(HOME)/Library/LaunchAgents
LAUNCH_DOMAIN := gui/$(shell id -u)

# pages with listings
LISTING_PAGES := $(shell grep -rl --include='*.qmd' '^listing:' . \
	--exclude-dir=$(BUILD_DIR) --exclude-dir=$(QUARTO_DIR) --exclude-dir=_freeze)

.PHONY: all build clean watch listings preview info fonts agda install-services uninstall-services

all: build

# Ensure build dir exists
$(BUILD_DIR):
	@echo "[INFO] Creating build directory: $(BUILD_DIR)"
	@mkdir -p $(BUILD_DIR)

# Rebuild only when sources are newer than the stamp file
$(BUILD_STAMP): $(SOURCES) | $(BUILD_DIR)
	@echo "[INFO] Sources changed; building site..."
	@echo "[INFO] Number of source files: $(words $(SOURCES))"
	@quarto render
	@echo "[INFO] Build complete."
	@echo "Updating stamp $(BUILD_STAMP)."
	@touch $(BUILD_STAMP)

build: $(BUILD_STAMP)

# Restart the preview service
preview:
	@echo "[INFO] Restarting preview..."
	@launchctl kickstart -k $(LAUNCH_DOMAIN)/org.vikraman.site-preview

# Mark listing pages stale
listings:
	@touch $(LISTING_PAGES)

# Watch files missed by preview
watch: agda
	@echo "[INFO] Watching agda, listings, theme and config..."
	@watchman-make -s 1 \
		-p 'teaching/**/_agda/**/*.lagda.md' 'teaching/**/_agda/**/*.agda' 'teaching/**/_agda/*.agda-lib' \
		-t agda \
		-p 'html/*.ejs' '*/*.yml' 'teaching/**/*.yml' \
		-t listings \
		-p 'theme/*.scss' '_brand.yml' '_quarto.yml' '**/_metadata.yml' '**/_sidebars.yml' \
		-t preview

# Install and (re)load the launchd services
install-services:
	@mkdir -p $(LAUNCH_AGENTS)
	@for s in $(SERVICES); do \
		echo "[INFO] Installing $$s..."; \
		sed -e 's#@SITE@#$(CURDIR)#g' -e 's#@HOME@#$(HOME)#g' \
			$(SERVICE_DIR)/$$s.plist.in > $(LAUNCH_AGENTS)/$$s.plist; \
		plutil -lint -s $(LAUNCH_AGENTS)/$$s.plist; \
		launchctl bootout $(LAUNCH_DOMAIN)/$$s 2>/dev/null || true; \
		launchctl bootstrap $(LAUNCH_DOMAIN) $(LAUNCH_AGENTS)/$$s.plist; \
	done

# Unload and remove the launchd services
uninstall-services:
	@for s in $(SERVICES); do \
		echo "[INFO] Removing $$s..."; \
		launchctl bootout $(LAUNCH_DOMAIN)/$$s 2>/dev/null || true; \
		rm -f $(LAUNCH_AGENTS)/$$s.plist; \
	done

info:
	@echo "Build dir: $(BUILD_DIR)"
	@echo "Stamp file: $(BUILD_STAMP)"
	@echo "Sources count: $(words $(SOURCES))"
	@printf "%s\n" $(SOURCES)

clean:
	@echo "[INFO] Cleaning output directories..."
	@rm -rf $(BUILD_DIR) $(QUARTO_DIR)
	@echo "[INFO] Clean complete."

# Typecheck and highlight literate agda
agda:
	@echo "[INFO] Typechecking agda..."
	@./scripts/agda.sh
	@echo "[INFO] Agda complete."

# Regenerate optimized font files
fonts:
	@echo "[INFO] Regenerating optimized font files..."
	@uv run scripts/build-fonts.py
	@echo "[INFO] Font regeneration complete."
