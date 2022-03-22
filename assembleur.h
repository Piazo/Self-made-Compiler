#ifndef ASM_H
#define ASM_H

enum opcode {ADD,MUL,SOU,DIV,COP,AFC,AFCA,JMP,JMF};

typedef struct{
    char* operation;
    int r0;
    int r1;
    int r2;
}instruction;

void add_instruc_to_tab(enum opcode operation, int r1, int r2, int r3);

#endif