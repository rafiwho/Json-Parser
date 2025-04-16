%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sql.h"

#define YY_NO_INPUT
#define YY_NO_UNPUT

#define YY_DECL int sql_lex(void)
%}

%option prefix="sql_"

%%

[ \t\n\r]+    ; /* Skip whitespace */

"SELECT"      { return SELECT; }
"FROM"        { return FROM; }
"WHERE"       { return WHERE; }
"INSERT"      { return INSERT; }
"INTO"        { return INTO; }
"VALUES"      { return VALUES; }
"UPDATE"      { return UPDATE; }
"SET"         { return SET; }
"DELETE"      { return DELETE; }
"CREATE"      { return CREATE; }
"TABLE"       { return TABLE; }
"DROP"        { return DROP; }
"ALTER"       { return ALTER; }
"ADD"         { return ADD; }
"COLUMN"      { return COLUMN; }
"AND"         { return AND; }
"OR"          { return OR; }
"NOT"         { return NOT; }
"NULL"        { return NULLVAL; }
"ORDER"       { return ORDER; }
"BY"          { return BY; }
"GROUP"       { return GROUP; }
"HAVING"      { return HAVING; }
"JOIN"        { return JOIN; }
"LEFT"        { return LEFT; }
"RIGHT"       { return RIGHT; }
"INNER"       { return INNER; }
"OUTER"       { return OUTER; }
"ON"          { return ON; }
"AS"          { return AS; }
"COUNT"       { return COUNT; }
"SUM"         { return SUM; }
"AVG"         { return AVG; }
"MAX"         { return MAX; }
"MIN"         { return MIN; }
"DISTINCT"    { return DISTINCT; }
"UNION"       { return UNION; }
"ALL"         { return ALL; }
"LIMIT"       { return LIMIT; }
"OFFSET"      { return OFFSET; }

"*"           { return STAR; }
","           { return COMMA; }
"."           { return DOT; }
"="           { return EQUALS; }
"<>"          { return NOTEQUALS; }
">"           { return GT; }
"<"           { return LT; }
">="          { return GTE; }
"<="          { return LTE; }
"+"           { return PLUS; }
"-"           { return MINUS; }
"/"           { return DIVIDE; }
"("           { return LPAREN; }
")"           { return RPAREN; }
";"           { return SEMICOLON; }

\"[^\"]*\"    { 
    sql_lval.string = strdup(yytext + 1);
    sql_lval.string[strlen(sql_lval.string) - 1] = '\0';
    return STRING;
}

\'[^\']*\'    { 
    sql_lval.string = strdup(yytext + 1);
    sql_lval.string[strlen(sql_lval.string) - 1] = '\0';
    return STRING;
}

[0-9]+        { 
    sql_lval.string = strdup(yytext);
    return NUMBER;
}

[0-9]+\.[0-9]+ { 
    sql_lval.string = strdup(yytext);
    return NUMBER;
}

[a-zA-Z_][a-zA-Z0-9_]* { 
    sql_lval.string = strdup(yytext);
    return IDENTIFIER;
}

.             { printf("Invalid character: %s\n", yytext); }

%%

int sql_wrap() { return 1; } 