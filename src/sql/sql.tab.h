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

#ifndef YY_SQL_SQL_TAB_H_INCLUDED
# define YY_SQL_SQL_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef SQL_DEBUG
# if defined YYDEBUG
#if YYDEBUG
#   define SQL_DEBUG 1
#  else
#   define SQL_DEBUG 0
#  endif
# else /* ! defined YYDEBUG */
#  define SQL_DEBUG 0
# endif /* ! defined YYDEBUG */
#endif  /* ! defined SQL_DEBUG */
#if SQL_DEBUG
extern int sql_debug;
#endif

/* Token kinds.  */
#ifndef SQL_TOKENTYPE
# define SQL_TOKENTYPE
  enum sql_tokentype
  {
    SQL_EMPTY = -2,
    SQL_EOF = 0,                   /* "end of file"  */
    SQL_error = 256,               /* error  */
    SQL_UNDEF = 257,               /* "invalid token"  */
    IDENTIFIER = 258,              /* IDENTIFIER  */
    STRING = 259,                  /* STRING  */
    NUMBER = 260,                  /* NUMBER  */
    SELECT = 261,                  /* SELECT  */
    FROM = 262,                    /* FROM  */
    WHERE = 263,                   /* WHERE  */
    INSERT = 264,                  /* INSERT  */
    INTO = 265,                    /* INTO  */
    VALUES = 266,                  /* VALUES  */
    UPDATE = 267,                  /* UPDATE  */
    SET = 268,                     /* SET  */
    DELETE = 269,                  /* DELETE  */
    CREATE = 270,                  /* CREATE  */
    TABLE = 271,                   /* TABLE  */
    DROP = 272,                    /* DROP  */
    ALTER = 273,                   /* ALTER  */
    ADD = 274,                     /* ADD  */
    COLUMN = 275,                  /* COLUMN  */
    AND = 276,                     /* AND  */
    OR = 277,                      /* OR  */
    NOT = 278,                     /* NOT  */
    NULLVAL = 279,                 /* NULLVAL  */
    ORDER = 280,                   /* ORDER  */
    BY = 281,                      /* BY  */
    GROUP = 282,                   /* GROUP  */
    HAVING = 283,                  /* HAVING  */
    JOIN = 284,                    /* JOIN  */
    LEFT = 285,                    /* LEFT  */
    RIGHT = 286,                   /* RIGHT  */
    INNER = 287,                   /* INNER  */
    OUTER = 288,                   /* OUTER  */
    ON = 289,                      /* ON  */
    AS = 290,                      /* AS  */
    COUNT = 291,                   /* COUNT  */
    SUM = 292,                     /* SUM  */
    AVG = 293,                     /* AVG  */
    MAX = 294,                     /* MAX  */
    MIN = 295,                     /* MIN  */
    DISTINCT = 296,                /* DISTINCT  */
    UNION = 297,                   /* UNION  */
    ALL = 298,                     /* ALL  */
    LIMIT = 299,                   /* LIMIT  */
    OFFSET = 300,                  /* OFFSET  */
    STAR = 301,                    /* STAR  */
    COMMA = 302,                   /* COMMA  */
    DOT = 303,                     /* DOT  */
    EQUALS = 304,                  /* EQUALS  */
    NOTEQUALS = 305,               /* NOTEQUALS  */
    GT = 306,                      /* GT  */
    LT = 307,                      /* LT  */
    GTE = 308,                     /* GTE  */
    LTE = 309,                     /* LTE  */
    PLUS = 310,                    /* PLUS  */
    MINUS = 311,                   /* MINUS  */
    MULTIPLY = 312,                /* MULTIPLY  */
    DIVIDE = 313,                  /* DIVIDE  */
    LPAREN = 314,                  /* LPAREN  */
    RPAREN = 315,                  /* RPAREN  */
    SEMICOLON = 316                /* SEMICOLON  */
  };
  typedef enum sql_tokentype sql_token_kind_t;
#endif

/* Value type.  */
#if ! defined SQL_STYPE && ! defined SQL_STYPE_IS_DECLARED
union SQL_STYPE
{
#line 23 "sql.y"

    char* string;
    int number;

#line 138 "sql.tab.h"

};
typedef union SQL_STYPE SQL_STYPE;
# define SQL_STYPE_IS_TRIVIAL 1
# define SQL_STYPE_IS_DECLARED 1
#endif


extern SQL_STYPE sql_lval;


int sql_parse (void);


#endif /* !YY_SQL_SQL_TAB_H_INCLUDED  */
