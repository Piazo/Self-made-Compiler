#ifndef ASM_H
#define ASM_H

typedef struct instruction{
    char* operation;
    int r0;
    int r1;
    int r2;
}instruction;

//Ajoute une instruction au tableau des instructions a effectuer
int add_instruc_to_tab(char* operation, int r0, int r1, int r2);

//Retourne l'index de la derniere instruction dans le tableau des instructions 
int get_index_last_instr ();

int push_var_tempo();
int pop_var_tempo();

void add_ope_to_tab(char* ope, int a, int b);

void print_instruction_table();

void interpreter();

void patchJMF(int adrJMF, int newDestination);
void patchJMP(int adrJMP, int newDestination); 

#endif