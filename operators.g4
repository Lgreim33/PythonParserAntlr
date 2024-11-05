grammar operators;


assign : VAR(ASSIGN|APLUS|AMINUS|MMULT|DMULT)((chain) | STRING | ARRAY);
chain : (OPERATION | VAR | NUM | FLOAT)+;

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


NUM : [0-9]+ ;
FLOAT : NUM'.'[0-9]+;
STRING : '"'[a-zA-Z0-9_]*'"';
VAR : [a-zA-Z_][a-zA-Z0-9_]*;
GENERIC : (NUM | FLOAT | STRING);


ARRAY : '['GENERIC(','GENERIC)*']';

OPERATION : ((NUM|VAR|FLOAT)(PLUS | MINUS | MULT | DIV | MOD)(NUM|VAR|FLOAT))+;

