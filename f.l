%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "b.tab.h"  
void append_init(FILE *fp){
	time_t t = time(NULL);
	struct tm now = *localtime(&t);
	char version_msg[32];
	char owners_msg[128];
	char date_msg[128];

	char *version = "1.0";
	char owner[64] = {"https://github.com/PavelKhabusov"};
	char aux[54];

	sprintf(version_msg, "//\tVersion:\t%s\n", version);
	sprintf(version_msg, "//\tVersion:\t%s\n", version);
	sprintf(owners_msg, "//\tCode owner:\t%s\n", owner);
	sprintf(date_msg, "//\tTranslated on:\t%d-%02d-%02d %02d:%02d:%02d \n", now.tm_year + 1900, now.tm_mon + 1, now.tm_mday, now.tm_hour, now.tm_min, now.tm_sec);

	fputs("//\n//\t===================================================================\n",fp);
	printf("//\n//\t===================================================================\n");
	fputs("//\tTranslated from Input language to Target language using khTranslator\n",fp);
	printf("//\tTranslated from Input language to Target language using khTranslator\n");
	fputs(version_msg,fp);
	printf(version_msg);
	fputs(owners_msg,fp);
	printf(owners_msg);
	fputs(date_msg,fp);
	printf(date_msg);
	fputs("//\t===================================================================\n//\n\n",fp);
	printf("//\t===================================================================\n//\n\n");
}
%}

%%
"Var"                   { return VAR;}

" = "                   { return ASSIGN;}
";"                     { return SEMICOLUMN; }
","                     { return COMMA; }
"("                     { return LPAREN; }
")"                     { return RPAREN; }

"-"                     { return MINUS; }
"+"                     { return PLUS; }
"*"                     { return MULTIPLE; }
"/"                     { return DIVIDE; }

[0123456789]+           { 
                                yylval.num = yytext; 
                                // printf(" _ID=%s_ ", yytext); 
                                return INTEGER; 
                        }
[a-zA-Z][a-zA-Z0-9]*    {
                                // char *n = lookup_name( yytext );
                                yylval.name = yytext; 
                                // printf(" _W=%s_ ", yytext); 
                                return ID;
                        }
[\n]                    { return LINEBREAK; }
%%

int main(int argc, char* argv[])
{
        FILE * fh;
        FILE * myfd;

        if (fh = fopen(argv[1], "r"))
                yyin = fh;
        if (myfd = fopen(argv[2], "w"))
                yyout = myfd;

        append_init(yyout);
        if( ! yyin )
                printf("Error: No input file.\n");
        if( ! yyout )
                yyout = fopen("out.psc","w");
        
        yyparse();
        fclose(yyin);
        fclose(yyout);
        return 0;
}