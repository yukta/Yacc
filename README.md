# Yacc
YML - A yaccparsed markup language

To make:
yacc -d semantic.y

lex lexeme.l

cc -g lex.yy.c y.tab.c -lgraph -lm -o xyz

./xyz <program

Compiled and Written by
Abhay Raj Malhotra
