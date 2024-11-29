grammar experimental;

// Combined grammar with lexer and parser rules.


tokens { INDENT, DEDENT }
@lexer::header {
  import com.yuvalshavit.antlr4.DenterHelper;
}
@lexer::members {
  private final DenterHelper denter = new DenterHelper(NL, experimentalParser.INDENT, experimentalParser.DEDENT) {
    @Override
    public Token pullToken() {
    System.out.println("Pulled Token: " + token.getText() + " (" + token.getType() + ")");
      return experimentalLexer.super.nextToken();
    }
  };

  @Override
  public Token nextToken() {
    return denter.nextToken();
  }
}


start :  (BIGCOMMENT | COMMENT | control | loop | assign)* EOF;

control : IF truthExpr ((AND | OR) truthExpr)* ':'  INDENT statement* DEDENT
        (ELIF truthExpr ':' NL INDENT statement* DEDENT)*
        (ELSE ':' NL INDENT statement* DEDENT)?
        ;

loop : whileLoop | forLoop;

whileLoop : 'while' truthExpr ':'  NL INDENT statement* DEDENT;
forLoop : 'for' VAR 'in' generic':' NL INDENT statement* DEDENT;

assign : VAR ((ASSIGN | APLUS | AMINUS | MMULT | DMULT) next) NL*;

statement : BIGCOMMENT | COMMENT | control | loop | assign;

truthExpr : truth (AND | OR | NOT | EQQ | NOT_EQQ | Gr_EQQ | LESS_EQQ | LESS | GR) truth;

truth : OPEN truth CLOSE
      | next (AND | OR | NOT | EQQ | NOT_EQQ | Gr_EQQ | LESS_EQQ | LESS | GR) next
      | NOT truth
      | next;
OPEN : '(';
CLOSE : ')';
next : operation(partial_opp)*
     | VAR
     | NUM
     | SIGNED_NUM
     | FLOAT
     | BOOL
     | STRING
     | SING_STRING
     | array;

operation : ((NUM|FLOAT|BOOL|SIGNED_NUM|VAR|STRING|SING_STRING) (PLUS | MINUS | MULT | DIV | MOD) (NUM|FLOAT|BOOL|SIGNED_NUM|VAR|STRING|SING_STRING));
//allows for the chaining of many operations
partial_opp : ((PLUS | MINUS | MULT | DIV | MOD) (NUM|FLOAT|BOOL|SIGNED_NUM|VAR))+;


//ingore comments
COMMENT : '#' .*? NL ->skip ;
BIGCOMMENT : '\'\'\'' NL* .*? NL* '\'\'\'' -> skip;

// Keywords and operators
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
NUM : ('0' | [1-9] [0-9]*);
SIGNED_NUM : '-'? ('0' | [1-9] [0-9]*);
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
NL: ('\r'? '\n''\t'*);
WS : [ \t]+ -> channel(HIDDEN);

