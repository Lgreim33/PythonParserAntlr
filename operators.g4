grammar operators;


//assignment rules
assign : VAR(ASSIGN|APLUS|AMINUS|MMULT|DMULT)((chain) | STRING |SING_STRING| ARRAY);

//chain is the path we take for values that can chain together, we'll want special rules for
chain : (OPERATION | VAR | NUM | FLOAT | BOOL)+;



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

//numeric operations
OPERATION : ((NUM|VAR|FLOAT|BOOL)(PLUS | MINUS | MULT | DIV | MOD)(NUM|VAR|FLOAT|BOOL))+;



//data types
NUM : '-'[0-9]+ | [0-9]+;
FLOAT : NUM'.'[0-9]+;
BOOL : 'True' | 'False';
STRING : '"'[a-zA-Z0-9_]*'"';
SING_STRING : '\''[a-zA-Z0-9_]*'\'';

//named variable
VAR : [a-zA-Z_][a-zA-Z0-9_]*;


//for when the type just does not matter
GENERIC : (NUM | FLOAT | STRING | SING_STRING | BOOL);

//complex types
ARRAY : '['GENERIC(','GENERIC)*']';


//string operations
STRING_CONCAT : (STRING|SING_STRING)(PLUS)(SING_STRING|STRING);
STRING_MULT : (STRING | NUM | SING_STRING)(MULT)(NUM | STRING | SING_STRING);

