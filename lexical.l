%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include"tablesymb.h"
#include"syntaxique.tab.h"
extern nb_ligne,nb_col;

extern YYSTYPE yylval;



%}

IDF [A-Z]([A-Z|a-z]|[0-9])*
chaine \"(\\.|[^"\\])*\"
chiffres [0-9]
chiffres1 [1-9]
nombrepos {chiffres}|{chiffres1}{chiffres}*
integer {nombrepos}|"("[-]?{nombrepos}")"
reel [+-]?[[0-9]+("."[0-9]+)]
OPAR ("+"|"-"|"*"|"/")
OPL ("AND."|"OR."|"NOT.")
OPC (".G."|".L."|".GE."|"LE."|".EQ."|".DI.")
%%
"IDENTIFICATION DIVISION." {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_identification;}
"DATA DIVISION." {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_data;}
"PROCEDURE DIVISION." {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_pro;}
"WORKING-STORAGE SECTION." {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_workst;}
"PROGRAM-ID." {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_progid;}
"STOP-RUN." {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_fin;}
"INTEGER"  {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_int;}
"FLOAT"  {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_reel;}
"CHAR" {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_char;}
"STRING" {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_chaine;}
"CONST" {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_const;}
"LINE" {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_line;}
"SIZE" {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_size;}
{OPAR} {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_opar;}
{OPL}  {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_oplog;}
{OPC} {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_opcomp;}
"IF" {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_if;}
"ELSE" {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_else;}
"END" {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_end;}
"DISPLAY" {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_disp;}
"ACCEPT" {yylval.string=strdup(yytext);nb_col=+strlen(yytext);recherchemc(yytext);return mc_accept;}
"@" {nb_col=+strlen(yytext);recherchemc(yytext);return sep_at;}
":" {nb_col=+strlen(yytext);recherchemc(yytext);return sep_deuxpoints;}
"(" {nb_col=+strlen(yytext);recherchemc(yytext);return sep_parouvr;}
")" {nb_col=+strlen(yytext);recherchemc(yytext);return sep_parferm;}
"." {nb_col=+strlen(yytext);recherchemc(yytext);return sep_point;}
\" {nb_col=+strlen(yytext);recherchemc(yytext);return sep_gui;}
"MOVE" {nb_col=+strlen(yytext);recherchemc(yytext);return mc_move;}
"TO" {nb_col=+strlen(yytext);recherchemc(yytext);return mc_to;}
"=" { nb_col=+strlen(yytext);recherchemc(yytext);return sep_eg;}
";" {nb_col=+strlen(yytext);recherchemc(yytext);return sep_pvir;}
"|" {nb_col=+strlen(yytext);recherchemc(yytext);return sep_bare;}
"#".*"!" {
   int l = strlen(yytext) , i = 0;
   for( i = 0; i< l; i++){
      if(yytext[i]=='\n'){
         nb_ligne ++;
         nb_col = 0;
      }
      nb_col++;
   }}
[\t] nb_col++;
[\n] {nb_ligne++; nb_col=1;}
{IDF} {yylval.string=strdup(yytext);nb_col=+strlen(yytext);if(yyleng > 8) { printf("\nErreur lexicale: Identificateur %s a la ligne %d et position %d a une taille de %d , ceci est trop long \n",yytext,nb_ligne, nb_col, yyleng); };return idff;}
{chaine} { nb_col =nb_col+ yyleng; yylval.string=strdup(yytext); return chaine;}
{reel} { nb_col =nb_col+ yyleng; yylval.reel = atof(yytext); return reel;}
{integer} { 
   if(yytext[0]!='(')
      yylval.entier = atoi(yytext); 
   else{
      sscanf(yytext,"(%d)",&yylval.entier);
   }
   nb_col =nb_col+ yyleng;return entier;}
. printf("erreur lexicale, entite %s non-reconnue ligne %d colonne %d \n",yytext,nb_ligne,nb_col) ;
%%
