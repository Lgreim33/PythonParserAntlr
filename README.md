# PythonParserAntlr


This antlr4 grammar was written in a Java enviorment using the IntelliJ IDEA Ultimate IDE, with the appropriate Antlr4 plugin to generate the grammar recognizer and the parse tree.

To test our grammar, you can use any ANtlr4 enviormnet you would like, however this will walk you through how to run it in IntelliJ.

1. Download the experimental.g4 file
2. Make sure you have the IntelliJ IDEA Ultimate IDE downloaded, you can access it for free with your school account
3. Access File>Settings>Plugins. File should be at the very top of your screen.
4. Search "Antlr v4"
5. Install Antlr v4 and Antlr v4 Tools plugins
6. Create a new Java project, and place the .g4 file you downloaded earlier in the src directory, which should also have a main file with som boiler plate code in it, which we can ignore
7. Right click on the experimental.g4 file and select "Generate ANTLR recognizer"
8. Then, right click on the "start" rule, and select "Test Rule Start," there should be a green play button next to it in the pop up menu
9. From there you can either load a python file into the window, or type directly into the text field
10. Any valid code you write should begin to generate a parse tree as you go

It should be noted that any comments you write will be ignored by the parser, as they are irrelevant to the running of a program

For a more visual walkthrough and explanation of the grammar, you can watch this video: 
Link:
