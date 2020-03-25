%{
# include <stdio.h>
# include <ctype.h>

int regs[26];
int base;

%}

%token STRING
%token NUMBER     
%token TRUE
%token FALSE
%token NULL

%% /* beginning of rules section */

OBJECT     : '{'     '}'

           | '{'  MEMBERS    '}'
      ;
      
MEMBERS    :  PAIR

           |  MEMBERS  ','  PAIR  
       ;

PAIR       : STRING  ':'  VALUE

       ;

ARRAY      : '['    ']'

           | '['  ELEMENTS  ']' 
       ;

ELEMENTS   :  VALUE
          
           |   ELEMENTS  ','  VALUE   

       ;

VALUE      : STRING

           | NUMBER

           | OBJECT

           | ARRAY

           | TRUE

           | FALSE

           | NULL

       ;




%% /* start of programs */

main ()

{
    while(!feof(stdin)) {
      yyparse();
   }
}

yyerror(char *s)
{  
   fprintf(stderr, "%s\n", s);
}


yylex() {   /* lexical analysis routine */
            /* returns LETTER for a lower case letter, yylval = 0 through 25 */
            /* return DIGIT for a digit, yylval = 0 through 9 */
            /* all other characters are returned immediately */

      int c;

      while( (c=getchar()) == ' ' )   { /* skip blanks */ }

      /* c is now nonblank */
      return( c );
      }
