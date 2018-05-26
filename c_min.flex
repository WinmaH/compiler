%{                                                                                          
#include "c_min.tab.h"                                                                     
extern int line_number;
void yyerror(char const *s){
    fprintf (stderr,"%s\n",s);
}                                                                     
%}        

%option noyywrap                                                                            
 
%%       


[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]       { /* Ignore comments */ }
[/][*]                                    { yyerror("Unterminated comment"); }

"else"         { printf("FROM FLEX ELSE %s\n", yytext); return ELSE;  }                  
"if"           { printf("FROM FLEX IF %s\n", yytext); return IF; } 
"int"          { printf("FROM FLEX INT %s\n", yytext); return INT; }
"return"       { printf("FROM FLEX RETURN %s\n", yytext); return RETURN; } 
"void"         { printf("FROM FLEX VOID %s\n", yytext); return VOID; }
"while"        { printf("FROM FLEX WHILE %s\n", yytext); return WHILE; }    

"+" { printf("FROM FLEX SYMBOL %s\n", yytext); return *yytext; }
"-" { printf("FROM FLEX SYMBOL %s\n", yytext); return *yytext; }
"*" { printf("FROM FLEX SYMBOL %s\n", yytext); return *yytext; }
"/" { printf("FROM FLEX SYMBOL %s\n", yytext); return *yytext; }
"<" { printf("FROM FLEX SYMBOL %s\n", yytext); return *yytext; }
"<=" { printf("FROM FLEX SYMBOL %s\n", yytext); return LESSEQ; }
">" { printf("FROM FLEX SYMBOL %s\n", yytext); return *yytext; }
">=" {printf("FROM FLEX SYMBOL %s\n", yytext);  return GREATEQ; }
"==" {printf("FROM FLEX SYMBOL %s\n", yytext);  return EQEQ; }
"!=" {printf("FROM FLEX SYMBOL %s\n", yytext);  return NOTEQ; }
"=" { printf("FROM FLEX SYMBOL %s\n", yytext); return *yytext; }
";" { printf("FROM FLEX SYMBOL %s\n", yytext); return *yytext; }
"," { printf("FROM FLEX SYMBOL %s\n", yytext); return *yytext; }
"{" { printf("FROM FLEX SYMBOL %s\n", yytext); return *yytext; }
"}" { printf("FROM FLEX SYMBOL %s\n", yytext); return *yytext; }
"(" { printf("FROM FLEX SYMBOL %s\n", yytext); return *yytext; }
")" { printf("FROM FLEX SYMBOL %s\n", yytext); return *yytext; }
"]" { printf("FROM FLEX SYMBOL %s\n", yytext); return *yytext; }
"[" { printf("FROM FLEX SYMBOL %s\n", yytext); return *yytext; }

     



[ \t\r]+      /* discard the white spaces */  
[\n] { line_number++; }
[0-9]+ { printf("FROM FLEX NUM %s\n", yytext); return NUM;}
[a-zA-Z]+ { printf("FROM FLEX ID %s\n", yytext); return ID;}
   
   /*if a symbol other than the above was found display an error message */
.  {yyerror("un-identified character"); return 1;}                                          
                                                                     
%%