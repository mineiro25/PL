ontologia: y.tab.o lex.yy.o 
	gcc -o  ontologia  y.tab.o lex.yy.o 

y.tab.o: y.tab.c
	gcc -c y.tab.c

lex.yy.o: lex.yy.c y.tab.h
	gcc -c lex.yy.c

y.tab.c y.tab.h: 
	yacc -d -v ontologia.y

lex.yy.c: ontologia.l
	flex -d ontologia.l




clean:
	rm -f ontologia lex.yy.c lex.yy.o y.tab.h y.tab.o y.tab.c



