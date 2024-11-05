grammar operators;

//assignment rules
assign : VAR(ASSIGN|APLUS|AMINUS|MMULT|DMULT)((chain) | STRING |SING_STRING| ARRAY);

//chain is the path we take for values that can chain together, we'll want special rules for
chain : (OPERATION | VAR | NUM | FLOAT)+;


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


//named variable
VAR : [a-zA-Z_][a-zA-Z0-9_]*;

//data types
NUM : '-'[0-9]+ | [0-9]+;
FLOAT : NUM'.'[0-9]+;
STRING : '"'[a-zA-Z0-9_]*'"';
SING_STRING : '\''[a-zA-Z0-9_]*'\'';

//for when the type just does not matter
GENERIC : (NUM | FLOAT | STRING | SING_STRING );

//complex types
ARRAY : '['GENERIC(','GENERIC)*']';


//numeric operations
OPERATION : ((NUM|VAR|FLOAT)(PLUS | MINUS | MULT | DIV | MOD)(NUM|VAR|FLOAT))+;

