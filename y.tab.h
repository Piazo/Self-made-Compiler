/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tFL = 258,
    tEGAL = 259,
    tPO = 260,
    tIF = 261,
    tPF = 262,
    tELSE = 263,
    tCONDEGAL = 264,
    tDIFF = 265,
    tSUP = 266,
    tINF = 267,
    tSUPEG = 268,
    tINFEG = 269,
    tAND = 270,
    tOR = 271,
    tWHILE = 272,
    tSOU = 273,
    tADD = 274,
    tDIV = 275,
    tMUL = 276,
    tERROR = 277,
    tMAIN = 278,
    tCONST = 279,
    tINT = 280,
    tPRINT = 281,
    tOB = 282,
    tCB = 283,
    tEOI = 284,
    tVIRG = 285,
    tNB = 286,
    tID = 287
  };
#endif
/* Tokens.  */
#define tFL 258
#define tEGAL 259
#define tPO 260
#define tIF 261
#define tPF 262
#define tELSE 263
#define tCONDEGAL 264
#define tDIFF 265
#define tSUP 266
#define tINF 267
#define tSUPEG 268
#define tINFEG 269
#define tAND 270
#define tOR 271
#define tWHILE 272
#define tSOU 273
#define tADD 274
#define tDIV 275
#define tMUL 276
#define tERROR 277
#define tMAIN 278
#define tCONST 279
#define tINT 280
#define tPRINT 281
#define tOB 282
#define tCB 283
#define tEOI 284
#define tVIRG 285
#define tNB 286
#define tID 287

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 10 "calc.y"
int nb; char* var; char* type; char* str

#line 124 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
