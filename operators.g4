grammar operators;
//NOTE TO SELF: ORDER IS IMPORTANT, DON'T MOVE STUFF FOR FUN

//assignment rules
start : VAR(ASSIGN|APLUS|AMINUS|MMULT|DMULT)
((OPERATION)(PARTIAL_OPP)*
 | VAR
 | NUM
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
NUM : '-'? ('0' | [1-9] [0-9]*);
FLOAT : NUM'.'[0-9]+;
BOOL : 'True' | 'False';
STRING : '"'[a-zA-Z0-9_]*'"';
SING_STRING : '\''[a-zA-Z0-9_]*'\'';

//numeric operations
OPERATION : ((NUM|FLOAT|BOOL|VAR) (PLUS | MINUS | MULT | DIV | MOD) (NUM|FLOAT|BOOL|VAR));
//allows for the chaining of many operations
PARTIAL_OPP : ((PLUS | MINUS | MULT | DIV | MOD) (NUM|FLOAT|BOOL|VAR))+;


//named variable
VAR : [a-zA-Z_][a-zA-Z0-9_]*;


//for when the type just does not matter
GENERIC : (NUM | FLOAT | STRING | SING_STRING | BOOL);

//complex types
ARRAY : '['(GENERIC(','GENERIC)*','?)?']';


//string operations
STRING_CONCAT : (STRING|SING_STRING)(PLUS)(SING_STRING|STRING);
STRING_MULT : (STRING | NUM | SING_STRING)(MULT)(NUM | STRING | SING_STRING);

WS : [ ]+ -> skip ;