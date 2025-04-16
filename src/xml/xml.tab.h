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

#ifndef YY_XML_XML_TAB_H_INCLUDED
# define YY_XML_XML_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef XML_DEBUG
# if defined YYDEBUG
#if YYDEBUG
#   define XML_DEBUG 1
#  else
#   define XML_DEBUG 0
#  endif
# else /* ! defined YYDEBUG */
#  define XML_DEBUG 0
# endif /* ! defined YYDEBUG */
#endif  /* ! defined XML_DEBUG */
#if XML_DEBUG
extern int xml_debug;
#endif

/* Token kinds.  */
#ifndef XML_TOKENTYPE
# define XML_TOKENTYPE
  enum xml_tokentype
  {
    XML_EMPTY = -2,
    XML_EOF = 0,                   /* "end of file"  */
    XML_error = 256,               /* error  */
    XML_UNDEF = 257,               /* "invalid token"  */
    IDENTIFIER = 258,              /* IDENTIFIER  */
    QUOTED_STRING = 259,           /* QUOTED_STRING  */
    LT = 260,                      /* LT  */
    GT = 261,                      /* GT  */
    SLASH = 262,                   /* SLASH  */
    EQUALS = 263,                  /* EQUALS  */
    QUESTION = 264,                /* QUESTION  */
    BANG = 265                     /* BANG  */
  };
  typedef enum xml_tokentype xml_token_kind_t;
#endif

/* Value type.  */
#if ! defined XML_STYPE && ! defined XML_STYPE_IS_DECLARED
union XML_STYPE
{
#line 32 "xml.y"

    char* string;

#line 86 "xml.tab.h"

};
typedef union XML_STYPE XML_STYPE;
# define XML_STYPE_IS_TRIVIAL 1
# define XML_STYPE_IS_DECLARED 1
#endif


extern XML_STYPE xml_lval;


int xml_parse (void);


#endif /* !YY_XML_XML_TAB_H_INCLUDED  */
