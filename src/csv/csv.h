/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
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
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_CSV_SRC_CSV_CSV_H_INCLUDED
# define YY_CSV_SRC_CSV_CSV_H_INCLUDED
/* Debug traces.  */
#ifndef CSV_DEBUG
# if defined YYDEBUG
#if YYDEBUG
#   define CSV_DEBUG 1
#  else
#   define CSV_DEBUG 0
#  endif
# else /* ! defined YYDEBUG */
#  define CSV_DEBUG 0
# endif /* ! defined YYDEBUG */
#endif  /* ! defined CSV_DEBUG */
#if CSV_DEBUG
extern int csv_debug;
#endif

/* Token kinds.  */
#ifndef CSV_TOKENTYPE
# define CSV_TOKENTYPE
  enum csv_tokentype
  {
    CSV_EMPTY = -2,
    CSV_EOF = 0,                   /* "end of file"  */
    CSV_error = 256,               /* error  */
    CSV_UNDEF = 257,               /* "invalid token"  */
    FIELD = 258,                   /* FIELD  */
    COMMA = 259,                   /* COMMA  */
    NEWLINE = 260                  /* NEWLINE  */
  };
  typedef enum csv_tokentype csv_token_kind_t;
#endif

/* Value type.  */
#if ! defined CSV_STYPE && ! defined CSV_STYPE_IS_DECLARED
union CSV_STYPE
{
#line 35 "src/csv/csv.y"

    char* string;

#line 81 "src/csv/csv.h"

};
typedef union CSV_STYPE CSV_STYPE;
# define CSV_STYPE_IS_TRIVIAL 1
# define CSV_STYPE_IS_DECLARED 1
#endif


extern CSV_STYPE csv_lval;


int csv_parse (void);


#endif /* !YY_CSV_SRC_CSV_CSV_H_INCLUDED  */
