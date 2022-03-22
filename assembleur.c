#include "assembleur.h"

#define MAX_TABLESIZE 2000
instruction tab_instruction[MAX_TABLESIZE];
char* operator;

int index_tab = 0;
int var

void add_instruc_to_tab(char* nom_ope, int r1, int r2, int r3){
    struct instruction new_instr = {nom_ope, r1, r2, r3};
    tab_instruction[index_tab] = new_instr;
    index_tab++;
}

int get_index (){
    return index_tab;
}

void select_operator (char* op){
    operator = op;
}

void ope_sur_nb(int nb){
    if (operator == NULL){
        add_instruct_to_tab("AFC", )
    }
}

void ope_sur_var(char* nom_var){
    int adr = get_adr(name_variable);
    if (operator == NULL){
        add_instruct_to_tab("COP", target_affect, adr, -1);
    }
    else{
        add_instruction(operator, target_affect, target_affect, adr);
    }
}

