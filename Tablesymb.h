#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int code=0;
//table des symboles des mots clés
typedef struct tablesymbmc
{
    char nom[30];
    int code;
    struct tablesymbmc *suiv;
} eltc;
//table des symboles des mots clés
typedef struct tablesymbsep
{
    char nom[30];
    int code;
    struct tablesymbsep *suiv;
} elts;
//table des symboles des id et variables et constantes
typedef struct tablesymb
{
    
	char nom[20];
	int code;
	char type[20];
	float valeur;
	char constante[20];
    int taille;
    struct tablesymb *suiv;
} elt;

elt *T; eltc *Tc; elts *Ts;

void inserermc( char nom[30])
{
    code++;
    eltc *q, *p;
    q=Tc;
    while(q->suiv!=NULL){
        q=q->suiv;
    }
    p = (eltc *)malloc(sizeof(eltc));
    strcpy((*p).nom,nom);
    (*p).code=code;
    p->suiv=NULL;
    q->suiv=p;

}

void inserersep( char nom[30])
{
    code++;
    elts *q, *p;
    q=Ts;
    while(q->suiv!=NULL){
        q=q->suiv;
    }
    p = (elts *)malloc(sizeof(elts));
    strcpy((*p).nom,nom);
    (*p).code=code;
    p->suiv=NULL;
    q->suiv=p;

}


void inserer( char nom[30],char type[20],float val,char constante[20],int taille)
{
     code++;
    elt *q, *p;
    q=T;
    while(q->suiv!=NULL){
        q=q->suiv;
    }
    p = (elt *)malloc(sizeof(elt));
    strcpy((*p).nom,nom);
    strcpy((*p).type,type);
    (*p).code=code;
    strcpy((*p).constante,constante);
    (*p).valeur=val;
    (*p).taille=taille;
    p->suiv=NULL;
    q->suiv=p;

}

int recherche(char nom[30]){
    elt *P;
    P=T;
    while(P!=NULL){
        if(strcmp((*P).nom,nom)==0){
            break;
        }
        P=P->suiv;
    }
    if (P==NULL)
    {
        return 1;
    }else
    { 
        return 0;
        /*l'entité existe déja c'est pas la paine de l'inserer*/
    }
    

}

void recherchemc(char nom[30]){

    eltc *P;
    P=Tc;
    while(P!=NULL){
        if(strcmp((*P).nom,nom)==0){
            break;
        }
        P=P->suiv;
    }
    if (P==NULL)
    {
        inserermc(nom);
    }else
    { 
        /*l'entité existe déja c'est pas la paine de l'inserer*/
    }
    
    
}

void recherchesep(char nom[30],char code[20]){

    elts *P;
    P=Ts;
    while(P!=NULL){
        if(strcmp((*P).nom,nom)==0){
            break;
        }
        P=P->suiv;
    }
    if (P==NULL)
    {
        inserersep(nom);
    }else
    {
        /*l'entité existe déja c'est pas la paine de l'inserer*/
    }
    
    
}


void initialisation(){
    
    T = (elt *)malloc(sizeof(elt));
    strcpy((*T).nom,"tete");
    strcpy((*T).type,"ignorer");
    (*T).code==0;
    (*T).valeur=0;
    T->suiv=NULL;
    Ts = (elts *)malloc(sizeof(elts));
    strcpy((*Ts).nom,"tete");
    (*Ts).code==0;
    Ts->suiv=NULL;
    Tc = (eltc *)malloc(sizeof(eltc));
    strcpy((*Tc).nom,"tete");
    (*Tc).code==0;
    Tc->suiv=NULL;
}


void afficher()
{
    elt *P; eltc *Pc; elts *Psep;
    P=T; Pc=Tc; Psep=Ts;

printf("/***************Table des symboles IDF*************/\n");
printf("_________________________________________________________________________________________\n");
printf("\t|           Nom_Entite         |   Code_Entite    | Type_Entite | Val_Entite\n");
printf("__________________________________________________________________________________________\n");
  
while(P!=NULL)
{	
	

        printf("\t|          %10s           |%15d | %12s | %12f\n",(*P).nom,(*P).code,(*P).type,(*P).valeur);
         P=P->suiv;

}

 
printf("\n/***************Table des symboles mots cles *************/\n");

printf("_______________________________________________________\n");
printf("\t| \t \t NomEntite | \t CodeEntite\n");
printf("_______________________________________________________\n");
  
 while(Pc!=NULL){
    
        printf("\t|%25s |\t%12d\n",(*Pc).nom,(*Pc).code);
               
      Pc=Pc->suiv;}


 
printf("\n/***************Table des symboles separateurs*************/\n");

printf("_______________________________________________________\n");
printf("\t| \t \t NomEntite | \t CodeEntite\n");
printf("_______________________________________________________\n");
  
 while(Psep!=NULL){
    
        printf("\t|%25s |\t%12d\n",(*Psep).nom,(*Psep).code);
               
      Psep=Psep->suiv;}

}

