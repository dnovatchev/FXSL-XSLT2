%token NUMBER

%left '+' '-'
%left '*' '/' '%'
%left UMINUS   /* supplies precedence for unary minus */

%% /* beginning of rules section */

expr  :  '(' expr ')'
      |  expr '+' expr
      |  expr '-' expr
      |  expr '*' expr
      |  expr '/' expr
      |  expr '%' expr
      |  '-' expr %prec UMINUS
      |  NUMBER
      ;

%%