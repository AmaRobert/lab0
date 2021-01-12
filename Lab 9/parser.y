%{
#include <stdio.h>
#include <stdlib.h>

#define YYDEBUG 1
%}

%token intreg
%token adevar
%token caractere
%token daca
%token altfel
%token citeste
%token afiseaza
%token merge
%token lista
%token incepe
%token sfarsit
%token mergeee
%token baga
%token id
%token ct
%token plus
%token minus
%token inmultire
%token impartire
%token rest
%token mic
%token micE
%token egal
%token mareE
%token mare
%token atribuie
%token acoladaD
%token acoladaI
%token patratD
%token patratI
%token parantezaD
%token parantezaI
%token punctVirgula
%token virgula
%token si
%token sau
%token afara

%start program

%%

program: StmtList;

StmtList: Stmt StmtList
        | Stmt;

Stmt: Decl 
    | Ifstmt
    | Forstmt
    | Assignstmt
    | Iostmt;

Decl: DType id punctVirgula
    | DType id virgula Cont;
Cont: id virgula Cont
    | id punctVirgula;

DType: intreg patratD ct patratI
     | caractere patratD ct patratI
     | intreg
     | caractere
     | adevar;

Ifstmt: daca parantezaD Condition parantezaI acoladaD StmtList acoladaI altfel acoladaD StmtList acoladaI
      | daca parantezaD Condition parantezaI acoladaD StmtList acoladaI;

Condition: Expression Relation Expression si Condition
         | Expression Relation Expression sau Condition
         | Expression Relation Expression;

Relation: mic
        | micE
        | egal
        | mareE
        | mare;

Forstmt: merge ForCond ForBody;

ForCond: parantezaD Assignstmt Condition punctVirgula Assignstmt parantezaI;

ForBody: acoladaD StmtList acoladaI;

Assignstmt: id atribuie Expression punctVirgula;
Iostmt: Istmt
      | Ostmt;

Istmt: citeste id punctVirgula;

Ostmt: afara parantezaD id parantezaI punctVirgula
     | afiseaza parantezaD ct parantezaI punctVirgula;

Expression: ArithmExpr;

ArithmExpr : term
           | term plus ArithmExpr
           | term minus ArithmExpr 
           | term inmultire ArithmExpr 
           | term impartire ArithmExpr 
           | term rest ArithmExpr
           | parantezaD ArithmExpr parantezaI ;

term : id | ct ;    

%%

yyerror(char *s)
{
  printf("%s\n", s);
}

extern FILE *yyin;

main(int argc, char **argv)
{
  if (argc > 1) 
    yyin = fopen(argv[1], "r");
  if ( (argc > 2) && ( !strcmp(argv[2], "-d") ) ) 
    yydebug = 1;
  if ( !yyparse() ) 
    fprintf(stderr,"\t No errors detected\n");
}