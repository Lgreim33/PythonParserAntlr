grammar operators;
//NOTE TO SELF: ORDER IS IMPORTANT, DON'T MOVE STUFF FOR FUN


start : (control | assign)*;


control : IF(truth(AND|OR|NOT|EQQ|NOT_EQQ|Gr_EQQ|LESS_EQQ|LESS|GR)truth|(truth))+':''\n'INDENT assign*
            (ELIF (truth(AND|OR|NOT|EQQ|NOT_EQQ|Gr_EQQ|LESS_EQQ|LESS|GR)truth|(truth))+':''\n'INDENT assign*)*
            ((ELSE)':''\n'INDENT assign*)?;

//assignment rules
assign : ((VAR(ASSIGN|APLUS|AMINUS|MMULT|DMULT) next)'\n'*);

//truth statements
truth : '(' truth ')'                        // Parentheses for nested expressions
      | truth (AND | OR | NOT | EQQ | NOT_EQQ | Gr_EQQ | LESS_EQQ | LESS | GR) truth
      | NOT truth                                                            // Chained conditions
      | next;

next : ((operation)(partial_opp)*

 | VAR
 | NUM
 | SIGNED_NUM
 | FLOAT
 | BOOL
 | STRING
 | SING_STRING
 | ARRAY);


//control symbols
IF : 'if';
ELSE : 'else';
ELIF: 'elif';
AND: 'and';
NOT: 'not';
OR: 'or';
EQQ: '==';
NOT_EQQ : '!=';
LESS_EQQ : '<=';
Gr_EQQ : '>=';
GR : '>';
LESS : '<';

//opp symbols
PLUS : '+';
MINUS : '-';
MULT : '*';
DIV : '/';
MOD : '%';
//assignment opp symbols
ASSIGN : '=';
APLUS : '+=';
AMINUS : '-=';
MMULT : '*=';
DMULT : '/=';


//data types
NUM : ('0' | [1-9] [0-9]*);
SIGNED_NUM : '-'? ('0' | [1-9] [0-9]*);
FLOAT : SIGNED_NUM'.'[0-9]+;
BOOL : 'True' | 'False';
STRING : '"'[a-zA-Z0-9_ ]*'"';
SING_STRING : '\''[a-zA-Z0-9_ ]*'\'';

//numeric operations
operation : ((NUM|FLOAT|BOOL|SIGNED_NUM|VAR|STRING|SING_STRING) (PLUS | MINUS | MULT | DIV | MOD) (NUM|FLOAT|BOOL|SIGNED_NUM|VAR|STRING|SING_STRING));
//allows for the chaining of many operations
partial_opp : ((PLUS | MINUS | MULT | DIV | MOD) (NUM|FLOAT|BOOL|SIGNED_NUM|VAR))+;


//named variable
VAR : [a-zA-Z_][a-zA-Z0-9_]*;


//for when the type just does not matter
GENERIC : (NUM | FLOAT | STRING | SING_STRING | BOOL | VAR | SIGNED_NUM);

//complex types
ARRAY : '['(GENERIC(','' '*GENERIC)*','?)?']';

INDENT : '\t';

WS : [ ]+ -> skip;
