YACC=win_bison
LEX=win_flex
NAME=dev.exe
CC=gcc
TEST=programs

all: build

test: test1 test2

.PHONY: test1 test2

test1 test2: test%: 
	$(NAME) $(TEST)\$*.pas $(TEST)\$*.out.pas

build: b.tab.c lex.yy.c
	$(CC) lex.yy.c b.tab.c -o $(NAME)

b.tab.c:
	$(YACC) -d b.y

lex.yy.c:
	$(LEX) f.l

clean:
	del /f *.yy.c
	del /f *.tab.*
	del /f $(NAME)
	del /f $(TEST)\*.out.pas