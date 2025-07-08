.PHONY: site

help:
	@echo "Available commands:"
	@echo "  site    - Create website from markdown files"

CWD=$(shell pwd)
pandoc-site:
	@echo ${CWD}
	@mkdir ${CWD}/pandoc-site/ &2>/dev/null
	@find . -name \*.md -type f | sed -En "s/\.\/(.*)\/.*\.md/\1/p" | xargs -I {} mkdir -p ${CWD}/pandoc-site/{}
	@find . -name \*.md -type f | sed -En "s/\.\/(.*)/\1/p" | xargs -I {} pandoc -o ${CWD}/pandoc-site/{}.html ./{}
