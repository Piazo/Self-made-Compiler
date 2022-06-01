#include "assembleur.h"
#include <string.h>
#include <stdio.h>



#define MAX_TABLESIZE 2000
instruction tab_instruction[MAX_TABLESIZE];
int registre[1024];
int tab_while[16];
int tab_cond_if[16];
int tab_cond_else[16];

int index_last_instr_tab = 0;
int index_current_instr = -1;
int index_var_tempo = -1;

int profondeur_de_while = -1;
int profondeur_de_if = -1;
int profondeur_de_else = -1;


int add_instruc_to_tab(char* nom_ope, int r0, int r1, int r2){
    instruction new_instr = {nom_ope, r0, r1, r2};
    tab_instruction[index_last_instr_tab] = new_instr;
    index_last_instr_tab++;
    return (index_last_instr_tab-1);
}


int get_index_last_instr (){
    return index_last_instr_tab;
}

void patchJMF(int adrJMF, int newDestination){
    tab_instruction[adrJMF].r1 = newDestination+1;
}

void patchJMP(int adrJMP, int newDestination){
    tab_instruction[adrJMP].r0 = newDestination+1;
}

int push_var_tempo(){
    index_var_tempo++;
    return 666+index_var_tempo;
}
int pop_var_tempo(){
    index_var_tempo--;
    return 666+index_var_tempo;
}



void print_instruction_table(){
    FILE* as;
    as = fopen("./Print_Instruction_Table", "w+");
    for (int i = 0; i < index_last_instr_tab; i++){
        fprintf(as, "%s %d %d %d", tab_instruction[i].operation, tab_instruction[i].r0, tab_instruction[i].r1, tab_instruction[i].r2);
        fprintf(as, "\n");
    }
}




void interpreter(){
    while(index_current_instr < index_last_instr_tab-1){
        index_current_instr++;
        char operator[5];
        strcpy(operator, tab_instruction[index_current_instr].operation);
        int r0 = tab_instruction[index_current_instr].r0;
		int r1 = tab_instruction[index_current_instr].r1;
		int r2 = tab_instruction[index_current_instr].r2;

        if (!strcmp(operator, "ADD")) {
			registre[r0] = registre[r1] + registre[r2];
        }
        else if (!strcmp(operator, "MUL")) {
			registre[r0] = registre[r2] * registre[r1];
		}
        else if (!strcmp(operator, "SOU")) {
			registre[r0] = registre[r2] - registre[r1];
		}
        else if (!strcmp(operator, "DIV")) {
			registre[r0] = registre[r2] / registre[r1];
		}
        else if (!strcmp(operator, "COP")) {
			registre[r0] = registre[r1];
		}
        else if (!strcmp(operator, "AFC")) {
			registre[r0] = r1;
		}
        else if(!strcmp(operator, "JMP")) {
            if(tab_instruction[index_current_instr].r2 == 51){
                index_current_instr = tab_instruction[index_current_instr].r0-1;
            }else{
               index_current_instr = tab_instruction[index_current_instr].r0-2;
            }

        } 
        else if(!strcmp(operator, "JMF")) {
            if(tab_instruction[index_current_instr].r2 == 51 && registre[r0] == 0){
                index_current_instr = tab_instruction[index_current_instr].r1;
            }else{
                if(registre[r0] == 0){
                    index_current_instr = tab_instruction[index_current_instr].r1-2;
                }
            }
        } 
        else if(!strcmp(operator, "PRI")) {
            printf("Valeur = %d\n", registre[r0]);
        }
        else if(!strcmp(operator, "EQU")) {
            registre[r0] = registre[r1] == registre[r2];
        } 
        else if(!strcmp(operator, "INF")) {
            registre[r0] = registre[r1] < registre[r2];
        } 
        else if(!strcmp(operator, "SUP")) {
            registre[r0] = registre[r1] > registre[r2];
        } 
    }
} 

