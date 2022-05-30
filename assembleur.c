#include "assembleur.h"

#define MAX_TABLESIZE 2000
instruction tab_instruction[MAX_TABLESIZE];
int registre[256];

int index_last_instr_tab = 0;
int index_current_instr = 0;
int index_var_tempo = 0;

void add_instruc_to_tab(char* nom_ope, int r0, int r1, int r2){
    struct instruction new_instr = {nom_ope, r0, r1, r2};
    tab_instruction[index_last_instr_tab] = new_instr;
    index_last_instr_tab++;
}

int get_index (){
    return index_last_instr_tab;
}

int pop_var_tempo(){
    index_var_tempo--;
    return 128+index_var_tempo;

}

int push_var_tempo(){
    index_var_tempo++;
    return 128+index_var_tempo;
}

void add_ope_to_tab(char* ope){
    int OperandeDeGauche = pop_var_tempo();
    int OperandeDeDroite = pop_var_tempo();
    add_instruc_to_tab(ope, OperandeDeGauche, OperandeDeGauche, OperandeDeDroite);
    push_var_tempo;
}

void interpreter(){
    while(index_current_instr < index_last_instr_tab){
        char operator[5],
        strcpy(operator, tab_instruction[index_current_instr].operation);
        int r0 = tab_inter[index_current_instr].r0;
		int r1 = tab_inter[index_current_instr].r1;
		int r2 = tab_inter[index_current_instr].r2;

        if (!strcmp(op, "ADD")) {
			registre[r0] = registre[r1] + registre[r2];
        }
        else if (!strcmp(op, "MUL")) {
			registre[r0] = registre[r2] * registre[r1];
		}
        else if (!strcmp(op, "SOU")) {
			registre[r0] = registre[r2] - registre[r1];
		}
        else if (!strcmp(op, "DIV")) {
			registre[r0] = registre[r2] / registre[r1];
		}
        else if (!strcmp(op, "COP")) {
			registre[r0] = registre[r1];
		}
        else if (!strcmp(op, "AFC")) {
			registre[r0] = r1;
		}

        index_current_instr++;

    }
}


