# PythonParserAntlr

This is a parser for Python written in Antlr4, it very simply reads in a file stream or a string of characters, and parses them accordingly into a parse tree

Group Members: 
Zachary Czarnik,
Landis Bargatze,
Josiah Manners,
and William Greim


REQUIREMENTS: 
1. Intellij Ultimate IDEA 2024.2.4 or newer
2. Antlr v4 plugin version 1.24, comes with ANTLR 4.13.2
4. While it does not hurt to have Java installed, Intellij comes with a Java Runtime Enviorment Installed
   
This antlr4 grammar was written in a Java enviorment using the IntelliJ IDEA Ultimate IDE, with the appropriate Antlr4 plugin to generate the grammar recognizer and the parse tree.

How it works: 

Our start rule is defined in such a way that the program can have as many control blocks, assignment statements, or loops as you want, in any order of declaration. These are children of 
start, and are treated as though they had "global" scope.

An assignmnet is the simplest of these, as it will never contain itseld or one of the other main three rule structures. It is defined as a valid variable name, one of the main equal sign operators, and some value or another variable. It also accepts operations, so you could 
set a variable equal to the result of an equation: such as "x = 4 + 3 * 5".

The control statement is the if...elif...else structure, in which you must define an if block, you may define as many elif blocks asy youd like with an if statement preceeding them, and you can have only one else block. Each block (exluding the else block) must contain
a truth expression, which are made up of grammar rules. Truth statements can be incredibly simple like: "if True:", or you can chain truth expressions together: "if x==7 and y==1:". It does not necessarily need to be a check for equality, as all python comparison operators are supported. To end the truth expression you must follow it with a colon ":," a newline, and a tab. Note that this implementation uses tabs, not spaces, so make sure you set your IDE to use the actual tab character, or it will not recognie the indentation. The body of the control block is made up of block statements, which contain smaller statements as it's children, these statemnets can be another control block, loops, or simply assignment statements. The indentation of the statement denotes which block statement the statement belongs to. This captures the nesting behavior in a way that allows for seamless tree parsing and no extra java code. 

The for and while loops, are combined into one rule for the sake of simplicity. 'while' is incredibly similar to the if statement, as it rewuires the keyword 'while,' a truth expression, a colon, then a newline and a tab. It then uses the same statement block model 
as the control statemnt. The for stemtement is slightly different, as it requires the keyword 'for,' followed by a variable, followed by the keyword 'in,' which then can be followed by
an array, variable, or the range function defined as: 'range(some_number,optional_number,optional_number,...),' then finally the colon, newline, and tab. Again, the for statement uses the 
same statement block system as the control structure and while loop. 

Comments, as stated before, are defined as lexer rules that the parser will simply skip over if it sees something is denoted as a comment. Which is: '#' unitl a newline is declared, or
"'''" to another "'''".



How to Use: 

To test our grammar, you can use any Antlr4 enviormnet you would like, however this will walk you through how to run it in IntelliJ.

1. Download the experimental.g4 file
2. Make sure you have the IntelliJ IDEA Ultimate IDE downloaded, you can access it for free with your school account
3. Access File>Settings>Plugins. File should be at the very top of your screen.
4. Search "Antlr v4"
5. Install Antlr v4 plugin
6. Create a new Java project, and place the .g4 file you downloaded earlier in the src directory, which should also have a main file with som boiler plate code in it, which we can ignore
7. Right click on the experimental.g4 file and select "Generate ANTLR recognizer"
8. Then, right click on the "start" rule, and select "Test Rule Start," there should be a green play button next to it in the pop up menu
9. From there you can either load a python file into the window, or type directly into the text field
10. Any valid code you write should begin to generate a parse tree as you go

It should be noted that any comments you write will be ignored by the parser, as they are irrelevant to the running of a program

For a more visual walkthrough and explanation of the grammar, you can watch this video: https://youtu.be/5owmopwlkcA

