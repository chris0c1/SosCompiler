#include "../inc/fct_tests.h"
#include "tokens.h"

int test_motsreserves_s() {
	char *filename = "fichiers_tests/motsreserves_s";
	yyin=fopen(filename,"r"); 
	if(yyin==NULL)
		perror(filename);
	
	int t;
	t = yylex();
	int result_t = 0;
	int nb_mots_res_detectables = 5;
	nb_mots_res_detectables *= MR; // on multiplie par la valeur du token 
	while(t != 0) {
		result_t += (t == MR ? MR : 0);
		t = yylex();
	}
    fclose(yyin); //fermeture de l'entrée*/
	return (result_t == nb_mots_res_detectables) ? 0 : 1;
}

int test_motsreserves_m() {
	char *filename = "exemple_sos/exemple1";
	yyin=fopen(filename,"r");
	if(yyin==NULL)
		perror(filename);
	
	int t;
	t = yylex();
	int result_t = 0;
	int nb_mots_res_detectables = 33;
	nb_mots_res_detectables *= MR;
	while(t != 0) {
		result_t += (t == MR ? MR : 0);
		t = yylex();
	}
    fclose(yyin); //fermeture de l'entrée*/
	return (result_t == nb_mots_res_detectables) ? 0 : 1;
}

int test_motsreserves_d() {
	char *filename = "fichiers_tests/motsreserves_d";
	yyin=fopen(filename,"r");
	if(yyin==NULL)
		perror(filename);
	
	int t;
	t = yylex();
	int result_t = 0;
	int nb_mots_res_detectables = 5;
	nb_mots_res_detectables *= MR;
	while(t != 0) {
		result_t += (t == MR ? MR : 0);
		t = yylex();
	}
    fclose(yyin); //fermeture de l'entrée*/
	return (result_t == nb_mots_res_detectables) ? 0 : 1;
}


int test_chainescarac_s() {
	char *filename = "fichiers_tests/chainescarac_s";
	yyin = fopen(filename, "r");
	if (yyin == NULL)
		perror(filename);
	int t;
	int result_t = 0;
	//3 chaines dans le fichier chainescarac_s
	int res_att = 3;
	while ((t = yylex()) != 0){
		result_t += (t == CC ? 1 : 0);
	}
	fprintf(stderr, "nombre de string detectés(s): %i (attendu : %i)\n", result_t, res_att);
	fclose(yyin);
	return (result_t == res_att ? 0 : 1);

}


int test_chainescarac_m() {
	char *filename = "exemple_sos/exemple1";
	yyin = fopen(filename, "r");
	if (yyin == NULL)
		perror(filename);
	int t;
	int result_t = 0;
	//9 chaines dans le fichier exemple1
	int res_att = 9;
	while ((t = yylex()) != 0){
		result_t += (t == CC ? 1 : 0);
	}
	fprintf(stderr, "nombre de string detectés(m): %i (attendu : %i)\n", result_t, res_att);
	fclose(yyin);
	return (result_t == res_att ? 0 : 1);
}

int test_chainescarac_d() {
	char *filename = "fichiers_tests/chainescarac_d";
	yyin = fopen(filename, "r");
	if (yyin == NULL)
		perror(filename);
	int t;
	int result_t = 0;
	//8 chaines dans le fichier chainescarac_d
	int res_att = 8;
	while ((t = yylex()) != 0){
		result_t += (t == CC ? 1 : 0);
	}
	fprintf(stderr, "nombre de string detectés(d) : %i (attendu : %i)\n", result_t, res_att);
	fclose(yyin);
	return (result_t == res_att ? 0 : 1);
}
