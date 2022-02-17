%{
int nb_ligne = 1;
int nb_col = 1;
char sauveType1[20];
char sauveType2[20];
%}
%union {
     int entier;
     char* string;
     float reel;
}

%token  <string>mc_identification <string>mc_data <string>mc_pro <string>mc_workst <string>mc_progid <string>mc_fin <string>mc_int <string>mc_reel <string>mc_char <string>mc_chaine <string>mc_const <string>mc_opar <string>mc_oplog <string>mc_opcomp <string>mc_if <string>mc_size
<string>mc_else <string>mc_end <string>mc_disp <string>mc_accept <string>mc_compute sep_at sep_deuxpoints sep_parouvr sep_parferm sep_gui sep_point mc_move mc_to sep_eg sep_pvir <string>idff sep_bare 
sep_virgule sep_et sep_pourc sep_diaz sep_dolar <string>chaine <entier>entier <reel>reel <string>mc_line
%start S
%%

S :  mc_identification mc_progid idff sep_point mc_data mc_workst DEC  mc_pro LIST_INSTRUCTION mc_fin   
                     {    printf ("Programme syntaxiquement correct !\n");    YYACCEPT;}
;



DEC: LIST_DEC_VAR LIST_DEC_CONST 
     |
;

LIST_DEC_VAR: DEC_VAR  LIST_DEC_VAR
       		|
;

DEC_VAR: LIST_IDF TYPE sep_point
;
TYPE: mc_int {strcpy(sauveType1,"entier");}
     |mc_reel {strcpy(sauveType1,"reel");}
	 |mc_char {strcpy(sauveType1,"chaine");}
	 |mc_chaine{strcpy(sauveType1,"chaine");}
;

LIST_IDF: idff sep_bare LIST_IDF 
                {
                        if(recherche($1)==1)
                         inserer($1,sauveType1,0,"non",1);
                	  else printf("Erreur Semantique: double declaration  de %s a la ligne %d , position %d\n", $1, nb_ligne, nb_col);
                }
          |idff{
                        if(recherche($1)==1)
                         inserer($1,sauveType1,0);
                	  else printf("Erreur Semantique: double declaration  de %s a la ligne %d , position %d\n", $1, nb_ligne, nb_col);
                }
          |idff mc_line entier sep_virgule mc_size entier		  //Déclaration dun tableau  
                     { if(recherche($1)==1)
                         inserer($1,sauveType1,0,"non",$5);
                	  else printf("Erreur Semantique: double declaration  de %s a la ligne %d , position %d\n", $1, nb_ligne, nb_col);  }
;
val : entier {strcpy(sauveType2,"entier");}
|chaine {strcpy(sauveType2,"chaine");}
|reel {strcpy(sauveType2,"reel");}

LIST_DEC_CONST: mc_const idff sep_eg val sep_pvir 
                   { if(recherche($2)==1)
                         inserer($2,sauveType2,0,"oui",0);
                	  else printf("Erreur Semantique: double declaration  de %s a la ligne %d , position %d\n", $1, nb_ligne, nb_col);  }  
              | mc_const idff TYPE
                     { if(recherche($2)==1)
                         inserer($2,sauveType1,0,"oui",0);
                	  else printf("Erreur Semantique: double declaration  de %s a la ligne %d , position %d\n", $1, nb_ligne, nb_col);  }  
;

    
/*----------------------------------------------------------------------------*/

LIST_INSTRUCTION:INST sep_point LIST_INSTRUCTION 
         |
;	

INST: INST_AFF
   	| INST_READ
	| INST_WRITE
	| INST_LOOP
	| INST_CONDITION
;
INST_CONDITION: mc_if sep_parouvr cond sep_parferm sep_deuxpoints LIST_INSTRUCTION mc_else sep_deuxpoints LIST_INSTRUCTION mc_end
              | mc_if cond sep_point LIST_INSTRUCTION mc_end

;

cond: OPERANDE  EXPRESSION_ARTHMTQ 
     |EXPRESSION_logique
;
COMP : OPERANDE mc_opcomp EXPRESSION_ARTHMTQ
      | OPERANDE mc_opcomp val
      |OPERANDE mc_opcomp OPERANDE
;

EXPRESSION_ARTHMTQ: OPERANDE mc_opar EXPRESSION_ARTHMTQ
     |OPERANDE
					
;
EXPRESSION_logique: EXPRESSION_logique mc_oplog EXPRESSION_logique
                 | COMP


;

OPERANDE: idff
                   { if(recherche($1)==1)
                   printf("Erreur Semantique: variable non-declaree %s a la ligne %d , position %d\n", $1, nb_ligne, nb_col);  }  
|val

;

INST_LOOP: mc_move idff mc_to OPERANDE LIST_INSTRUCTION mc_end
                   { if(recherche($2)==1)
                   printf("Erreur Semantique: variable non-declaree %s a la ligne %d , position %d\n", $1, nb_ligne, nb_col);  } 
	
;


INST_READ: mc_accept sep_parouvr sep_gui SIGNE_FORMAT sep_gui sep_deuxpoints sep_at idff sep_parferm 
			
;

SIGNE_FORMAT: sep_et    
			| sep_pourc
			| sep_diaz
			| sep_dolar  
;
INST_WRITE:  mc_disp sep_parouvr sep_gui chaine  SIGNE_FORMAT sep_gui sep_deuxpoints idff sep_parferm
;


INST_AFF:  mc_compute idff sep_eg EXPRESSION_ARTHMTQ
;

;

%%
main ()
{
 

 initialisation();
  yyparse();
 afficher();
 

}


yywrap()
{}
int yyerror (char *msg )
{ printf ("Erreur syntaxique a la ligne %d, colonne : %d\n",nb_ligne,nb_col);
        return 1; }
