#ifndef ASM_H
#define ASM_H

typedef struct instruction{
    char* operation;
    int r0;
    int r1;
    int r2;
}instruction;

//Ajoute une instruction au tableau des instructions a effectuer
void add_instruc_to_tab(char* operation, int r0, int r1, int r2);

//Retourne l'index de la derniere instruction dans le tableau des instructions 
int get_index_last_instr ();

int push_var_tempo();
int pop_var_tempo();

void add_ope_to_tab(char* ope);

void push_while();
void pop_while();

void push_cond_if();
void pop_cond_if();

void push_cond_else();
void pop_cond_else();

void remove_jmp();

void print_instruction_table();

void interpreter();

#endif