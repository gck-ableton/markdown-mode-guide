LEANPUB_SLUG = markdown-mode
LEANPUB_URL = https://leanpub.com/$(LEANPUB_SLUG)

BOOK = manuscript/Book.txt
BOOK_SRC = $(shell cat $(BOOK))

CURL = curl -s

preview:
	@echo "\nGenerating Preview…"
	@$(CURL) -d "api_key=$(LEANPUB_API_KEY)" $(LEANPUB_URL)/preview.json | json_pp

partial:
	@$(CURL) -d "api_key=$(LEANPUB_API_KEY)" $(LEANPUB_URL)/preview/subset.json | json_pp

status:
	@$(CURL) "$(LEANPUB_URL)/job_status?api_key=$(LEANPUB_API_KEY)" | json_pp

info:
	@$(CURL) "$(LEANPUB_URL).json" | json_pp
