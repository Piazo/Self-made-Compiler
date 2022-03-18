#ifndef ASM_H
#define ASM_H

#define MAX_TABLESIZE 200


#define ADD 1
#define MUL 2
#define SOU 3
#define DIV 4
#define COP 5
#define AFC 6
#define JMP 7
#define JMF 8

typedef struct{
    char ope[3];
    int r0;
    int r1;
    int r2;
}instruction;

instruction tab_instruction[MAX_TABLESIZE];


void add_instruc_to_tab(char* nom_ope, int r1, int r2, int r3);



#endif