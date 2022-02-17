
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     mc_identification = 258,
     mc_data = 259,
     mc_pro = 260,
     mc_workst = 261,
     mc_progid = 262,
     mc_fin = 263,
     mc_int = 264,
     mc_reel = 265,
     mc_char = 266,
     mc_chaine = 267,
     mc_const = 268,
     mc_opar = 269,
     mc_oplog = 270,
     mc_opcomp = 271,
     mc_if = 272,
     mc_size = 273,
     mc_else = 274,
     mc_end = 275,
     mc_disp = 276,
     mc_accept = 277,
     mc_compute = 278,
     sep_at = 279,
     sep_deuxpoints = 280,
     sep_parouvr = 281,
     sep_parferm = 282,
     sep_gui = 283,
     sep_point = 284,
     mc_move = 285,
     mc_to = 286,
     sep_eg = 287,
     sep_pvir = 288,
     idff = 289,
     sep_bare = 290,
     sep_virgule = 291,
     sep_et = 292,
     sep_pourc = 293,
     sep_diaz = 294,
     sep_dolar = 295,
     chaine = 296,
     entier = 297,
     reel = 298,
     mc_line = 299
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 7 "syntaxique.y"

     int entier;
     char* string;
     float reel;



/* Line 1676 of yacc.c  */
#line 104 "syntaxique.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


