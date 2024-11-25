grammar experimental;

// Combined grammar with lexer and parser rules.

tokens { INDENT , DEDENT }

@lexer::members {
  private java.util.LinkedList<Token> tokens = new java.util.LinkedList<>();
  private java.util.Stack<Integer> indents = new java.util.Stack<>();
  private Token lastToken = null;
  private static final int TAB_SIZE = 4;

  @Override
  public void emit(Token t) {
    super.setToken(t);
    tokens.offer(t);
    System.out.println("Emitted token: " + t.getText() + " of type " +
  }

@Override
public Token nextToken() {
    if (_input.LA(1) == EOF && !indents.isEmpty()) {
        // Emit DEDENT tokens for all remaining indents
        while (!indents.isEmpty()) {
            this.emit(createDedent());
            indents.pop();
        }
        // Emit EOF token
        this.emit(commonToken(EOF, "<EOF>"));
    }

    Token next = super.nextToken();
    if (next.getChannel() == Token.DEFAULT_CHANNEL) {
        this.lastToken = next;
    }

    return tokens.isEmpty() ? next : tokens.poll();
}


  private Token createDedent() {
    CommonToken dedent = commonToken(experimental.DEDENT, "");
    dedent.setLine(this.lastToken.getLine());
    return dedent;
  }

  private CommonToken commonToken(int type, String text) {
    int stop = getCharIndex() - 1;
    int start = text.isEmpty() ? stop : stop - text.length() + 1;
    return new CommonToken(_tokenFactorySourcePair, type, DEFAULT_TOKEN_CHANNEL, start, stop);
  }

static int getIndentationCount(String spaces) {
  int count = 0;
  boolean hasSpaces = false;
  boolean hasTabs = false;

  for (char ch : spaces.toCharArray()) {
    switch (ch) {
      case '\t':
        hasTabs = true;
        count += TAB_SIZE - (count % TAB_SIZE); // Tabs count as TAB_SIZE spaces
        break;
      case ' ':
        hasSpaces = true;
        count++;
        break;
    }
  }

  if (hasSpaces && hasTabs) {
    throw new RuntimeException("Mixed spaces and tabs in indentation");
  }

  return count;
}
}

start : NEWLINE * (BIGCOMMENT | COMMENT | control | loop | assign)* EOF;

control : IF truthExpr ((AND | OR) truthExpr)* ':' NEWLINE  statement*
        (ELIF truthExpr ':' NEWLINE INDENT statement* DEDENT)*
        (ELSE ':' NEWLINE INDENT statement* DEDENT)?
        ;

loop : whileLoop | forLoop;

whileLoop : 'while' truthExpr ':' NEWLINE INDENT statement* DEDENT;
forLoop : 'for' VAR 'in' generic':' NEWLINE INDENT statement* DEDENT;

assign : VAR ((ASSIGN | APLUS | AMINUS | MMULT | DMULT) next) NEWLINE*;

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
COMMENT : '#' .*? NEWLINE ->skip ;
BIGCOMMENT : '\'\'\'' NEWLINE* .*? NEWLINE* '\'\'\'' -> skip;

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
STRING : '"' [a-zA-Z0-9_ ]* '"';
SING_STRING : '\'' [a-zA-Z0-9_ ]* '\'';
VAR : [a-zA-Z_][a-zA-Z0-9_]*;
generic : (NUM | FLOAT | STRING | SING_STRING | BOOL | VAR | SIGNED_NUM);
array : BRACK (generic (',' generic)*)? RBRACK;

BRACK : '[';
RBRACK : ']';
COLON: ':';
NEWLINE
 : ('\r'? '\n') [ \t]* {
     String leadingWhitespace = getText().replaceAll("[\r\n]+", ""); // Extract leading tabs/spaces
     int indent = getIndentationCount(leadingWhitespace); // Calculate indentation
     int previous = indents.isEmpty() ? 0 : indents.peek(); // Get last indentation level

     if (indent == previous) {
         skip(); // No change in indentation level
     } else if (indent > previous) {
         indents.push(indent);
         emit(commonToken(experimental.INDENT, leadingWhitespace)); // Emit INDENT token
     } else {
         while (!indents.isEmpty() && indents.peek() > indent) {
             emit(createDedent()); // Emit DEDENT tokens for each unmatched level
             indents.pop();
         }
     }
     setText("\n"); // Emit the newline token with proper text
   }
 ;

WS : [ \r]+ -> skip;