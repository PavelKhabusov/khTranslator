%{
#include <stdio.h>
#include <string.h>

char arr_ID[256][40];
char temp_str[256][40];

int i;
int flag = 0;
int err;
 
int yywrap()
{
	return 1;
}

void yyerror(const char *str)
{
	fprintf(stderr,"Error: %s\n",str);
}
int yylex();

// FILE* yyget_out(yyscan_t);
FILE* yyget_out(scanf);
%}

%union {
	char *name;
	char *num;
}

%token <num> INTEGER
%token <name> ID
%token VAR BG END    
%token BOOL
%token SEMICOLUMN ASSIGN COMMA LPAREN RPAREN LINEBREAK
%left PLUS MULTIPLE DIVIDE
%left MINUS


%%

program: | var_declaration calculations;

var_declaration: var var_list semicolumn linebreak
	| var_declaration var var_list semicolumn linebreak;

calculations:
	{
		flag = 1; 
		printf("Begin\n"); 
		fprintf(yyget_out(scanf), ("Begin\n"));
	} 
	assignments_list 
	{
		printf("End\n"); 
		fprintf(yyget_out(scanf), ("End\n"));
	}

var: 
	VAR
	{
		printf("Var ");
		fprintf(yyget_out(scanf), ("Var"));
	}

semicolumn:
	SEMICOLUMN semi

semi:
	{
		printf(";");
		fprintf(yyget_out(scanf), (";"));
	}

linebreak: 
	LINEBREAK
	{
		printf("\n");
		fprintf(yyget_out(scanf), ("\n"));
	}

var_list:
	ident | ident comma var_list;

comma:
	COMMA
	{
		printf(", ");
		fprintf(yyget_out(scanf), (","));
	}
	
ident: 
	ID
	{
		if (flag == 0) {
			strcpy(arr_ID[i], $1);
			++i;
			
			printf("%s", $1);
			fprintf(yyget_out(scanf), $1);
		} else {
			for (int j = 0; j < i; ++j) {
				strcpy(temp_str[0], $1);
				for (int k = 0; k < 40; ++k) {
					if (arr_ID[j][k] == temp_str[0][k]) {
						err = 2;
					} else {
						err = 1;
						break;
					}
				}
				if (err == 2)
					break;
			}
			if (err != 2) {
				printf("\t!!! Variable '%s' has not being declared\n", $1);
				err = 0;
				memset(&temp_str[0], 0, sizeof(temp_str));
			}
			
			printf("\t%s", $1);
			fprintf(yyget_out(scanf), "\t%s", $1);
		}
	}

assignments_list:
	assignments | assignments assignments_list;

assignments:
	ident assignment expression semi linebreak;

assignment:
	ASSIGN
	{
		printf(" := ");
		fprintf(yyget_out(scanf), (" := "));
	}

expression:
	unop subexpression | subexpression;

unop: 
	minus

subexpression:
	lparen expression rparen | subexpression binop subexpression | constant;

lparen:
	LPAREN
	{
		printf("( ");
		fprintf(yyget_out(scanf), ("( "));
	}

rparen:
	RPAREN
	{
		printf(" )");
		fprintf(yyget_out(scanf), (" )"));
	}

constant:
	INTEGER
	{
		fprintf(yyget_out(scanf), $1);
		printf("%s", $1);
	}

binop:
	minus | plus | multiple | divide;

minus: 
	MINUS
	{
		printf("-");
		fprintf(yyget_out(scanf), ("-"));
	}

plus: 
	PLUS
	{
		printf(" + ");
		fprintf(yyget_out(scanf), (" + "));
	}

multiple:
	MULTIPLE
	{
		printf(" * ");
		fprintf(yyget_out(scanf), (" * "));
	}

divide:
	DIVIDE
	{
		printf(" / ");
		fprintf(yyget_out(scanf), (" / "));
	}

%%