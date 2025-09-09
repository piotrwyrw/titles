BUILD_DIR = build
IMG_DIR = images

build: clean
	mkdir -p $(BUILD_DIR)
	mkdir -p $(IMG_DIR)
	echo "# Titles" > README.md
	echo "A collection of LaTeX title pages" >> README.md
	for f in $(shell find . -type f -name "*.tex"); do \
		xelatex -interaction=nonstopmode -output-directory=$(BUILD_DIR) "$$f"; \
		xelatex -interaction=nonstopmode -output-directory=$(BUILD_DIR) "$$f"; \
		base=$$(basename "$$f" .tex); \
		magick "$(BUILD_DIR)/$$base.pdf"[0] -density 300 -background white -alpha on -flatten "$(IMG_DIR)/$$base.png"; \
		echo "## $$base" >> README.md; \
		echo "![](./$(IMG_DIR)/$$base.png)" >> README.md; \
	done
	find . -type f \( -name "*.aux" -o -name "*.log" \) -delete

clean:
	rm -rf $(BUILD_DIR) $(IMG_DIR)
