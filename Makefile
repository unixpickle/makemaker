build:
	mkdir build
	coffee -o build -c lib/*.coffee

clean:
	rm -rf build
