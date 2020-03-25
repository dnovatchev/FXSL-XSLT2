%{
# include <stdio.h>
# include <ctype.h>

int regs[26];
int base;

%}

%token COMMENT_START
%token COMMENT_END     
%token DOUBLE_LITERAL
%token DECIMAL_LITERAL
%token INTEGER_LITERAL
%token STRING_LITERAL
%token OR
%token AND
%token EQ
%token NE
%token LT
%token LE
%token GT
%token GE
%token IS
%token TO
%token DIV
%token IDIV
%token MOD
%token UNION
%token INTERSECT
%token EXCEPT
%token INSTANCE_OF
%token CAST_AS
%token CASTABLE_AS
%token TREAT_AS
%token FOR
%token SOME
%token EVERY
%token IF
%token THEN
%token ELSE
%token IN
%token RETURN
%token SATISFIES
%token QNAME2
%token CHILD_AXIS
%token DESCENDANT_AXIS
%token ATTRIBUTE_AXIS
%token SELF_AXIS
%token DESCENDANT_OR_SELF_AXIS
%token FOLLOWING_SIBLING_AXIS
%token FOLLOWING_AXIS
%token NAMESPACE_AXIS
%token PARENT_AXIS
%token ANCESTOR_AXIS
%token PRECEDING_SIBLING_AXIS
%token PRECEDING_AXIS
%token ANCESTOR_OR_SELF_AXIS
%token EMPTY_TYPE
%token ITEM_TYPE
%token ELEMENT_TEST
%token ATTRIBUTE_TEST
%token SCHEMA_ELEMENT_TEST
%token SCHEMA_ATTRIBUTE_TEST
%token PROCESSING_INSTRUCTION_TEST
%token DOCUMENT_NODE_TEST
%token COMMENT_TEST
%token NODE_TEST
%token TEXT_TEST
%token WILD_NAME
%token WILD_PREFIX
%token ','
%token '<<'
%token '>>'
%token '+'
%token '-'
%token '*'
%token '//'
%token '/'
%token '('
%token ')'
%token '['
%token ']'
%token '::'
%token '@'
%token '.'
%token '..'
%token '='
%token '!='
%token '<'
%token '<='
%token '>'
%token '>='
%token '$'
%token '?'
%token '$end'
%token 'error'

%% /* beginning of rules section */

Expr         :  ExprSingle 
             |  Expr  ',' ExprSingle
             
ExprSingle   :  ForExpr
             |  QuantifiedExpr
             |  IfExpr
             |  OrExpr
             
ForExpr      :  FOR  VarnameList RETURN  ExprSingle  

VarnameList  :  VariableReference  IN   ExprSingle
             |  VarnameList 
                ',' VariableReference  IN   ExprSingle
                
QuantifiedExpr : SomeOrEvery 
                   VarnameList SATISFIES  ExprSingle 
                   
SomeOrEvery  : SOME | EVERY                   
                   
IfExpr       :  IF '(' Expr ')' 
                   THEN ExprSingle
                   ELSE ExprSingle
                   
OrExpr       :  AndExpr
             |  OrExpr   OR  AndExpr
             
AndExpr      :  ComparisonExpr 
             |  AndExpr  AND ComparisonExpr
             
ComparisonExpr :  RangeExpr 
               |  RangeExpr  ValGenNodeComp RangeExpr
               
ValGenNodeComp :  ValueComp |GeneralComp |  NodeComp 

ValueComp    :  EQ | NE | LT | LE | GT | GE

GeneralComp  : '=' | '!=' | '<' | '<=' | '>' | '>='

NodeComp     : IS  | '<<' | '>>'

RangeExpr    : AdditiveExpr
             | AdditiveExpr  TO  AdditiveExpr
             
AdditiveExpr : MultiplicativeExpr
             | AdditiveExpr Sign  MultiplicativeExpr
             
Sign         : '+' | '-'

MultiplicativeExpr : UnionExpr
                   | MultiplicativeExpr MultOper UnionExpr 
                   
MultOper     : '*' | DIV | IDIV | MOD

UnionExpr    : IntersectExceptExpr
             | UnionExpr  UNION  IntersectExceptExpr
             
IntersectExceptExpr : InstanceOfExpr
                    | IntersectExceptExpr IntersectExcept InstanceOfExpr
                    
IntersectExcept  :  INTERSECT  | EXCEPT

InstanceOfExpr : TreatExpr
               | TreatExpr INSTANCE_OF  SequenceType
               
TreatExpr    :  CastableExpr
             |  CastableExpr  TREAT_AS  SequenceType
            
CastableExpr :  CastExpr
             |  CastExpr  CASTABLE_AS   SingleType
             
CastExpr     :  UnaryExpr
             |    CAST_AS  SingleType

UnaryExpr    :  PathExpr
             |  Sign  PathExpr
             
PathExpr     : '/'  RelativePathExpr
             | '/'
             | '//' RelativePathExpr
             |  RelativePathExpr

RelativePathExpr : StepExpr 
                 | RelativePathExpr '/' StepExpr
                 | RelativePathExpr '//' StepExpr 

StepExpr     :  AxisStep  |  FilterExpr                                                                                                

AxisStep     :  ForwardStep  PredicateList
             |  ReverseStep  PredicateList
             
FilterExpr   :  PrimaryExpr  PredicateList

PredicateList : 
              | PredicateList  Predicate

Predicate    :  '['  Expr  ']'


PrimaryExpr  :  Literal
             |  VariableReference
             |  ParenthesizedExpr
             |  ContextItemExpr
             |  FunctionCall

Literal      :  NumericLiteral
             |  STRING_LITERAL                        

NumericLiteral : INTEGER_LITERAL
               | DECIMAL_LITERAL 
               | DOUBLE_LITERAL

ParenthesizedExpr : '(' Expr ')'
                  | '('  ')'

ContextItemExpr : '.'

FunctionCall : FunctionName '(' ExprSingleList  ')'
             | FunctionName '('  ')'

ExprSingleList : ExprSingle
               | ExprSingleList  ','  ExprSingle                   

FunctionName :  QName

ForwardStep  :  ForwardAxis  NodeTest
             |  AbbrevForwardStep
             

ReverseStep  :  ReverseAxis  NodeTest
             |  AbbrevReverseStep
             

AbbrevForwardStep : '@' NodeTest
                  | NodeTest

AbbrevReverseStep : '..'

ForwardAxis  :  CHILD_AXIS
             |  DESCENDANT_AXIS
             |  ATTRIBUTE_AXIS
             |  SELF_AXIS
             |  DESCENDANT_OR_SELF_AXIS
             |  FOLLOWING_SIBLING_AXIS
             |  FOLLOWING_AXIS
             |  NAMESPACE_AXIS

ReverseAxis  :  PARENT_AXIS
             |  ANCESTOR_AXIS
             |  PRECEDING_SIBLING_AXIS
             |  PRECEDING_AXIS
             |  ANCESTOR_OR_SELF_AXIS
             
NodeTest     :  KindTest
             |  NameTest

NameTest     :  QName  |  WildCard

WildCard     :  '*' | WILD_NAME | WILD_PREFIX

SingleType   :  AtomicType  
             |  AtomicType '?' 

SequenceType : '(' ItemType ')'
             | '(' ItemType OccurenceIndicator ')'
             |  EMPTY_TYPE  

AtomicType   :  QName

ItemType     :  AtomicType
             |  KindTest
             |  ITEM_TYPE 

OccurenceIndicator : '?' | '*' | '+'

KindTest     :  DocumentTest
             |  ElementTest                                                            
             |  AttributeTest                                                            
             |  PITest                                                            
             |  CommentTest                                                            
             |  TextTest                                                            
             |  AnyKindTest

ElementTest  :  BasicElementTest
             |  SchemaElementTest

AttributeTest : BasicAttributeTest
              | SchemaAttributeTest

BasicElementTest : ELEMENT_TEST '(' ')'
                 | ELEMENT_TEST '(' ElementNameOrWildCard  ')'
                 | ELEMENT_TEST '(' ElementNameOrWildCard ',' TypeName ')'
                 | ELEMENT_TEST '(' ElementNameOrWildCard ',' TypeName '?' ')'

BasicAttributeTest
             : ATTRIBUTE_TEST '(' ')'
             | ATTRIBUTE_TEST '(' AtttibuteNameOrWildCard  ')'
             | ATTRIBUTE_TEST '(' AtttibuteNameOrWildCard ',' TypeName ')'

ElementNameOrWildCard  : ElementName  |  '*'

AtttibuteNameOrWildCard : AttributeName  |  '*'

ElementName   : QName             
                   
AttributeName : QName             
                   
TypeName      : QName             
                   

SchemaElementTest : SCHEMA_ELEMENT_TEST  ElementName ')'

SchemaAttributeTest : SCHEMA_ATTRIBUTE_TEST  AttributeName ')'

PITest        :  PROCESSING_INSTRUCTION_TEST  ')'
              |  PROCESSING_INSTRUCTION_TEST  QName ')'
              |  PROCESSING_INSTRUCTION_TEST  STRING_LITERAL ')'

DocumentTest  :  DOCUMENT_NODE_TEST '('  ')'
              |  DOCUMENT_NODE_TEST '(' ElementTest ')'  

CommentTest   :  COMMENT_TEST                        

TextTest      :  TEXT_TEST                        

AnyKindTest   :  NODE_TEST                        

QName         : QNAME2 

                  |  OR
                  |  AND
                  |  EQ
                  |  NE
                  |  LT
                  |  LE
                  |  GT
                  |  GE
                  |  IS
                  |  TO
                  |  DIV
                  |  IDIV
                  |  MOD
                  |  UNION
                  |  INTERSECT
                  |  EXCEPT
                  |  THEN
                  |  ELSE
                  |  IN
                  |  RETURN
                  |  SATISFIES


VariableReference   : '$'     QName

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