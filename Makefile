name=md_spa

clean:
	@rm -rf bin

build: clean
	@shards check || shards install
	@mkdir -p bin
	crystal build -o bin/$(name) src/$(name).cr

install: build
	cp bin/$(name) /usr/local/bin

uninstall:
	rm -f /usr/local/bin/$(name)
