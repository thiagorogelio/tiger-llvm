all:
	clear
	bison src/*.y -d
	flex src/*.l
	mv *.c src
	mv *.h src
	gcc src/*.c -w -g -o tiger-llvm
clear:
	rm tiger-llvm -f
	rm src/tiger.t* -f
	rm src/lex* -f
