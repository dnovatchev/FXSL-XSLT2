%{
# include <stdio.h>
# include <ctype.h>

int regs[26];
int base;

%}

%% /* beginning of rules section */

E     : E  '*' B

      | E  '+' B

      | B
      ;
      
B     :  '0'

      |  '1'
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
