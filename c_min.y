%{                                                                                   
   #include <stdarg.h> 
   #include "c_min_shared.h"                                                        
   #define YYSTYPE char *                                                            
   int yydebug=1; 
   void yyerror (char const *);                                                                   
   int indent=0;                                                                     
   char *iden_dum;                                                                   
%}  

%token RETURN                                                                       
%token INT                                                                           
%token ELSE
%token IF    
%token WHILE
%token VOID
%token GREATEQ
%token NOTEQ
%token EQEQ
%token LESSEQ

%token NUM
%token ID

%%    /* Grammar rules of the language */


program:
    declaration_list  { printf("%3d: FROM BISON declaration_list\n", line_number); }
;

declaration_list:
    declaration_list declaration      { printf("%3d: FROM BISON declaration_list declertion\n", line_number); } | 
    declaration                       { printf("%3d: FROM BISON declaration_list declertion\n", line_number); }
;

declaration :
    var_declaration                   { printf("%3d: FROM BISON var_declertion\n", line_number); } |
    fun_declaration                   { printf("%3d: FROM BISON fun_declertion\n", line_number); }
;

var_declaration :
    type_specifier ID ';'                     { printf("%3d: FROM BISON type_specifier ID ;\n", line_number); }
    | type_specifier ID '[' NUM ']' ';'       { printf("%3d: FROM BISON type_specifier ID [ NUM ] ;\n", line_number); }
;

fun_declaration:
    type_specifier ID '(' params ')' compound_stmt     { printf("%3d: FROM BISON type_specifier ID ( params ) compound_stmt\n", line_number); }
;

type_specifier: 
    INT                                    { printf("%3d: FROM BISON INT\n", line_number); } |
    VOID                                   { printf("%3d: FROM BISON VOID\n", line_number); }
;
params:
    param_list                    { printf("%3d: FROM BISON param_list\n", line_number); }|
    VOID                          { printf("%3d: FROM BISON VOID\n", line_number); }
;

param_list:
    param_list ',' param                      { printf("%3d: FROM BISON param_list , param\n", line_number); }
    | param                                   { printf("%3d: FROM BISON param\n", line_number); }
;

param:
    type_specifier ID                         { printf("%3d: FROM BISON type_specifier ID\n", line_number); }
    | type_specifier ID '[' ']'               { printf("%3d: FROM BISON type_specifier ID [] \n", line_number); }
;

compound_stmt:
    '{' local_declarations statement_list '}'        { printf("%3d: FROM BISON { local_declarations statement_list }\n", line_number); }
;

local_declarations: 
    local_declarations var_declaration               { printf("%3d: FROM BISON  local_declarations var_declaration\n", line_number); }  |
    %empty                                           { printf("%3d: FROM BISON %empty \n", line_number); }
;

statement_list:
    statement_list statement                         { printf("%3d: FROM BISON statement_list statement\n", line_number); } |
    %empty                                           { printf("%3d: FROM BISON %empty\n", line_number); }
; 


statement :
    expression_stmt  { printf("%3d: FROM BISON expression_stmt\n", line_number); }|  
    compound_stmt    { printf("%3d: FROM BISON compound_stmt\n", line_number); }| 
    selection_stmt   { printf("%3d: FROM BISON selection_stmt\n", line_number); }| 
    iteration_stmt   { printf("%3d: FROM BISON iteration_stmt\n", line_number); }|
    return_stmt      { printf("%3d: FROM BISON return_stmt\n", line_number); }

expression_stmt:
    expression ';'    { printf("%3d: FROM BISON expression ; \n", line_number); } |
     ';'              { printf("%3d: FROM BISON ;\n", line_number); }
;

selection_stmt:
    IF '(' expression ')' statement                            { printf("%3d: FROM BISON IF ( expression ) statement \n", line_number); }|
    IF '(' expression ')' statement ELSE statement             { printf("%3d: FROM BISON IF ( expression ) statement ELSE statement\n", line_number); }
;
iteration_stmt: 
    WHILE '(' expression ')' statement                         { printf("%3d: FROM BISON WHILE ( expression ) statement\n", line_number); }
;
return_stmt:
    RETURN ';'                                                 { printf("%3d: FROM BISON RETURN ';'\n", line_number); }|
    RETURN expression ';'                                      { printf("%3d: FROM BISON RETURN expression ';' \n", line_number); }
;
expression: 
    var '=' expression                                         { printf("%3d: FROM BISON var = expression\n", line_number); }|
    simple_expression                                          { printf("%3d: FROM BISON simple_expression\n", line_number); }
;
var: 
    ID                                                         { printf("%3d: FROM BISON ID \n", line_number); }|
    ID '[' expression ']'                                      { printf("%3d: FROM BISON ID [ expression ]\n", line_number); }
;
simple_expression :
    additive_expression relop additive_expression              { printf("%3d: FROM BISON additive_expression relop additive_expression \n", line_number); }|
    additive_expression                                        { printf("%3d: FROM BISON additive_expression \n", line_number); }
;
additive_expression:
    additive_expression addop term                             { printf("%3d: FROM BISON additive_expression addop term\n", line_number); }|
    term                                                       { printf("%3d: FROM BISON term\n", line_number); }
;
relop:
    '<'       { printf("%3d: FROM BISON <\n", line_number); }|
    LESSEQ    { printf("%3d: FROM BISON LESSEQ \n", line_number); }|
    '>'       { printf("%3d: FROM BISON >\n", line_number); }|
    GREATEQ   { printf("%3d: FROM BISON GREATEQ\n", line_number); }|
    EQEQ      { printf("%3d: FROM BISON EQEQ\n", line_number); }|
    NOTEQ     { printf("%3d: FROM BISON NOTEQ \n", line_number); }
;
addop:
    '+'       { printf("%3d: FROM BISON +\n", line_number); }|
     '-'      { printf("%3d: FROM BISON -\n", line_number); }
;
term: 
    term mulop factor  { printf("%3d: FROM BISON term mulop factor\n", line_number); }|
    factor             { printf("%3d: FROM BISON factor\n", line_number); }
;
mulop:
    '*'                { printf("%3d: FROM BISON *\n", line_number); }|
    '/'                { printf("%3d: FROM BISON /\n", line_number); }
;
factor:
    '(' expression ')' { printf("%3d: FROM BISON ( expression )\n", line_number); }|  
    var                { printf("%3d: FROM BISON var \n", line_number); } |
    call               { printf("%3d: FROM BISON call\n", line_number); } |
    NUM                { printf("%3d: FROM BISON NUM\n", line_number); }
;
call: 
    ID '(' args ')'     { printf("%3d: FROM BISON ID ( args )\n", line_number); }
;
args:
    arg_list            { printf("%3d: FROM BISON arg_list \n", line_number); }|
    %empty              { printf("%3d: FROM BISON %empty\n", line_number); }
;
arg_list: 
    arg_list ',' expression   { printf("%3d: FROM BISON arg_list ',' expression\n", line_number); }|
    expression                { printf("%3d: FROM BISON expression\n", line_number); }
;
%%



main ()                                                                              
{                                                                                    
  if(yyparse ()==0){
      printf("Code is Valid");
  }else{
      printf("Code is invalid");
  }                                                                        
}