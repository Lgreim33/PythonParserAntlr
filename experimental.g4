grammar experimental;

// Combined grammar with lexer and parser rules.

start : (NL* (control | loop | assign))* NL* EOF;

control : IF truthExpr ((AND | OR) truthExpr)* ':' NL* statementBlock
 		(NL* (ELIF truthExpr ':' NL* statementBlock)*)?
 		(NL* ELSE ':' NL* statementBlock)? NL*;

loop : WHILE truthExpr ((AND | OR) truthExpr)* ':' NL* statementBlock?
     | FOR VAR IN (rangeFunc | array | VAR) ':' NL* statementBlock?;

assign : VAR ((ASSIGN | APLUS | AMINUS | MMULT | DMULT) next) NL?;

statement : control | loop | assign;

statementBlock : (INDENT statement?)+;

// Components of control
truthExpr : truth ((AND | OR | NOT | EQQ | NOT_EQQ | Gr_EQQ | LESS_EQQ | LESS | GR) truth)?;

truth : OPEN truth CLOSE
      | next (AND | OR | NOT | EQQ | NOT_EQQ | Gr_EQQ | LESS_EQQ | LESS | GR) next
      | NOT truth
      | next;

OPEN : '(';
CLOSE : ')';

rangeFunc : 'range' '(' SIGNED_NUM (',' SIGNED_NUM)* ')';

next : operation (partial_opp)* | VAR | NUM | SIGNED_NUM | FLOAT | BOOL | STRING | SING_STRING | array;

operation : ((NUM | FLOAT | BOOL | SIGNED_NUM | VAR | STRING | SING_STRING) (PLUS | MINUS | MULT | DIV | MOD) (NUM | FLOAT | BOOL | SIGNED_NUM | VAR | STRING | SING_STRING));

partial_opp : ((PLUS | MINUS | MULT | DIV | MOD) (NUM | FLOAT | BOOL | SIGNED_NUM | VAR))+;

// Ignore comments
COMMENT : '#' .*? NL -> skip;
BIGCOMMENT : '\'\'\'' NL? .*? NL? '\'\'\'' -> skip;

// Keywords and operators
FOR : 'for';
IN : 'in';
WHILE : 'while';
IF : 'if';
ELIF : 'elif';
ELSE : 'else';
AND : 'and';
NOT : 'not';
OR : 'or';
EQQ : '==';
NOT_EQQ : '!=';
LESS_EQQ : '<=';
Gr_EQQ : '>=';
GR : '>';
LESS : '<';
PLUS : '+';
MINUS : '-';
MULT : '*';
DIV : '/';
MOD : '%';
ASSIGN : '=';
APLUS : '+=';
AMINUS : '-=';
MMULT : '*=';
DMULT : '/=';

// Data types
SIGNED_NUM : '-'? ('0' | [1-9] [0-9]*);
NUM : ('0' | [1-9] [0-9]*);
FLOAT : SIGNED_NUM '.' [0-9]+;
BOOL : 'True' | 'False';
STRING : '"' .*? '"';
SING_STRING : '\'' .*? '\'';
VAR : [a-zA-Z_][a-zA-Z0-9_]*;
generic : (NUM | FLOAT | STRING | SING_STRING | BOOL | VAR | SIGNED_NUM);
array : BRACK (generic (',' generic)*)? RBRACK;

BRACK : '[';
RBRACK : ']';
COLON: ':';
NL : '\n';

WS : [ \r]+ -> skip;
INDENT : [\t]+;