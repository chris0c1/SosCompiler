%option nounput
%option noyywrap 
%{
	#include "../inc/code_proj.tab.h"
	#include "tokens.h"
	#include <stdlib.h>
	#include <stdbool.h>
	#include <errno.h>
	#include <limits.h>
	int yyerror(char * msg);
	bool checkNombres(char *nombres);
	bool checkAscii(char * str, bool com);
	bool testAscii;

	#define MAX_NUM 2147483647
	#define MIN_NUM -2147483648
%}

espace [ \t]
endline [\n]
com [#]
digit [0-9]
signe [+-]

%%

^{espace}*if{espace}+				return MR;
{espace}+then({espace}+|{endline}) 	return MR;
^{espace}*for{espace}+				return MR;
{espace}do({espace}+|{endline}) 	return MR;
^{espace}*done{espace};{endline}	return MR;
{espace}+in{espace}+				return MR;
^{espace}*while{espace}+			return MR;
^{espace}*until{espace}+			return MR;
^{espace}*case{espace}+				return MR;
^{espace}*esac{espace}+				return MR;
^{espace}*echo{espace}+				return MR;
^{espace}*read{espace}+				return MR;
^{espace}*return{espace}+			return MR;
^{espace}*exit{espace}+				return MR;
^{espace}*local{espace}+ 			return MR;
^{espace}*elif{espace}+ 			return MR;
^{espace}*else{endline} 			return MR;
^{espace}*fi{espace};{endline}		return MR;
^{espace}*declare{espace}+			return MR;
{espace}+test{espace}+				return MR;
{espace}+expr{espace}+				return MR;
\"(\\.|[^\\\"])*\"					return (checkAscii(&yytext[1], true) ? CC : yyerror("Caractère non ASCII"));
\'(\\.|[^\\\'])*\'					return (checkAscii(&yytext[1], true) ? CC : yyerror("Caractère non ASCII"));

{signe}?{digit}+				return (checkNombres(yytext) ? NB : yyerror("Nombres trop grand/trop petit"));

{com}+.*{endline}					return COM;
. 									return (checkAscii(yytext, false) ? CHAR : yyerror("Caractère non ASCII"));

%%

int yyerror(char * msg)
{
	fprintf(stderr," %s\n",msg);
	return 1;
}

bool checkNombres(char *nombreStr) {
	char *ptrFin;
	errno = 0;
	long nombre = strtol(nombreStr, &ptrFin, 10); // On converti en base 10

	if (
		(errno == ERANGE && (nombre == LONG_MAX || nombre == LONG_MIN)) ||
		(errno != 0 && nombre == 0)
	) {
		if (nombre == LONG_MAX)
			perror("Nombre trop grand");
		else if (nombre == LONG_MIN)
			perror("Nombre trop petit");
		exit(EXIT_FAILURE);
	}

	return (nombre > MAX_NUM || nombre < MIN_NUM) ? false : true;
}

bool checkAscii(char * str, bool com) 
{
	bool b = testAscii;
	testAscii = false;
	if (b && !com)
		if(!(*str == '\"' || *str == '\'' || *str == '\\' 
			|| *str == 't' || *str == 'n'))
			return false;
	if (b && com)
			return false;
	if (com)	// Si on est dans une chaine de caractère
		str[strlen(str)-1] = '\0';	// On enlève le dernier guillemet
	while (*str != '\0') {
		if (*str < 32 || *str > 126)
			return false;
		if (*str == '\"' || *str == '\'')
			return false;
		if (*str == '\\') {
			if (com) {
				str++;
				if (!(*str == '\"' || *str == '\'' || *str == '\\' 
					|| *str == 't' || *str == 'n'))
					return false;
			}
			else {
				testAscii = true;
			}
		}
		str++;
	}
	return true;
}
