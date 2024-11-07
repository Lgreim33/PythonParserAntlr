grammar operators;
//NOTE TO SELF: ORDER IS IMPORTANT, DON'T MOVE STUFF FOR FUN

//assignment rules
start : ((VAR(ASSIGN|APLUS|AMINUS|MMULT|DMULT) next)'\n'*)*;


next : ((operation)(partial_opp)*
 | string_concat
 | string_concat*string_mult string_concat*
 | VAR
 | NUM
 | SIGNED_NUM
 | FLOAT
 | BOOL
 | STRING
 | SING_STRING
 | ARRAY);



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
FLOAT : NUM'.'[0-9]+;
BOOL : 'True' | 'False';
STRING : '"'[a-zA-Z0-9_ ]*'"';
SING_STRING : '\''[a-zA-Z0-9_ ]*'\'';

//numeric operations
operation : ((NUM|FLOAT|BOOL|SIGNED_NUM|VAR) (PLUS | MINUS | MULT | DIV | MOD) (NUM|FLOAT|BOOL|SIGNED_NUM|VAR|));
//allows for the chaining of many operations
partial_opp : ((PLUS | MINUS | MULT | DIV | MOD) (NUM|FLOAT|BOOL|SIGNED_NUM|VAR))+;


//named variable
VAR : [a-zA-Z_][a-zA-Z0-9_]*;


//for when the type just does not matter
GENERIC : (NUM | FLOAT | STRING | SING_STRING | BOOL | VAR | SIGNED_NUM);

//complex types
ARRAY : '['(GENERIC(','' '*GENERIC)*','?)?']';


//string operations
string_concat : (STRING|SING_STRING)((PLUS)(SING_STRING|STRING|string_mult))+;
partial_concat : PLUS (SING_STRING|STRING);
string_mult : (STRING | NUM | SING_STRING|string_concat)((MULT)(NUM | STRING | SING_STRING|partial_concat))+;


//simple : (STRING | SING_STRING | NUM )(PLUS|MULT)((STRING | SING_STRING | NUM ))

WS : [ ]+ -> skip;

