# output directories
BUILD_DIR := _site
BUILD_STAMP := $(BUILD_DIR)/.lastbuild
QUARTO_DIR := .quarto

# all source files
SOURCES := $(shell find . -type f \
	\( -name '*.qmd' -o -name '*.yml' -o -name '*.scss' -o -name '*.ejs' \) \
	! -path "./$(BUILD_DIR)/*" ! -path "./$(QUARTO_DIR)/*" \
	! -path "./.git/*" ! -path "./.github/*" )

.PHONY: all build clean cont preview info

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

# Start preview server in background
preview:
	@echo "[INFO] Starting preview..."
	@./preview.sh &

# Start preview server and then run watchman to trigger rebuilds
cont: preview
	@echo "[INFO] Starting watchman to trigger preview on changes..."
	@watchman-make -p 'html/**/*.ejs' 'theme/**/*.scss' '**/*.yml' -t preview

info:
	@echo "Build dir: $(BUILD_DIR)"
	@echo "Stamp file: $(BUILD_STAMP)"
	@echo "Sources count: $(words $(SOURCES))"
	@printf "%s\n" $(SOURCES)

clean:
	@echo "[INFO] Cleaning output directories..."
	@rm -rf $(BUILD_DIR) $(QUARTO_DIR)
	@echo "[INFO] Clean complete."
