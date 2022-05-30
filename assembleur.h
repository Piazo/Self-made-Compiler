#ifndef ASM_H
#define ASM_H

enum opcode {ADD,MUL,SOU,DIV,COP,AFC,JMP,JMF,INF,SUP,EQU,PRI};

typedef struct{
    char* operation;
    int r0;
    int r1;
    int r2;
}instruction;

//Ajoute une instruction au tableau des instructions a effectuer
void add_instruc_to_tab(enum opcode operation, int r0, int r1, int r2);

//Retourne l'index de la derniere instruction dans le tableau des instructions 
int get_index ();




#endif