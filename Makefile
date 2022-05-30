GRM=calc.y
LEX=calc.l
BIN=calc

CC=gcc
CFLAGS=-Wall -g

OBJ=y.tab.o lex.yy.o #main.o  

all: $(BIN)

%.o: %.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

y.tab.c: $(GRM)
	yacc -d -v -t $<

lex.yy.c: $(LEX)
	flex $<

$(BIN): $(OBJ)
	$(CC) $(CFLAGS) $(CPPFLAGS) symboltable.c assembleur.c $^ -o $@

clean:
	rm $(OBJ) y.tab.c y.tab.h lex.yy.c analyseur.out

tests_ok : all
	./test_ok.sh
