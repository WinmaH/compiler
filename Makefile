c_min: lex.yy.o c_min.tab.o
	gcc -o simple $^

c_min.tab.h: c_min.y
	bison --debug --verbose -d c_min.y

c_min.tab.c: c_min.y
	bison -d simple.y

lex.yy.c: c_min.flex c_min.tab.h
	flex  c_min.flex