NAME = md_spa
BUILD_FLAGS = -s -p --error-trace

clean:
	@rm -rf bin

setup:
	@shards check || shards install
	@mkdir -p bin

build: clean setup
	@crystal build src/$(NAME).cr -o bin/$(NAME) $(BUILD_FLAGS)
	@echo

test:
	@crystal spec

install: build
	cp bin/$(NAME) /usr/local/bin

uninstall:
	rm -f /usr/local/bin/$(NAME)
