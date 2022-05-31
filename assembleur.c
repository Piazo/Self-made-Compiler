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
int index_current_instr = 0;
int index_var_tempo = -1;

int profondeur_de_while = -1;
int profondeur_de_if = -1;
int profondeur_de_else = -1;


void add_instruc_to_tab(char* nom_ope, int r0, int r1, int r2){
    instruction new_instr = {nom_ope, r0, r1, r2};
    tab_instruction[index_last_instr_tab] = new_instr;
    index_last_instr_tab++;
}


int get_index_last_instr (){
    return index_last_instr_tab;
}


int push_var_tempo(){
    index_var_tempo++;
    return 128+index_var_tempo;
}
int pop_var_tempo(){
    index_var_tempo--;
    return 128+index_var_tempo;
}


void add_ope_to_tab(char* ope){
    int OperandeDeGauche = pop_var_tempo();
    int OperandeDeDroite = pop_var_tempo();
    add_instruc_to_tab(ope, OperandeDeGauche, OperandeDeGauche, OperandeDeDroite);
    index_var_tempo++;
}


void push_while(){
    profondeur_de_while++;
    tab_while[profondeur_de_while] = index_last_instr_tab;
}
void pop_while(){
    add_instruc_to_tab("JMP", tab_while[profondeur_de_while]+1, -1, -1);
    profondeur_de_while--;
}


void push_cond_if(){
    profondeur_de_if++;
    tab_cond_if[profondeur_de_if] = index_last_instr_tab;
}
void pop_cond_if(){
    tab_instruction[tab_cond_if[profondeur_de_if]].r1 = index_last_instr_tab+1;
    profondeur_de_if--;
}

void push_cond_else(){
    profondeur_de_else++;
    tab_cond_else[profondeur_de_else] = index_last_instr_tab;
}
void pop_cond_else(){
    tab_instruction[tab_cond_else[profondeur_de_else]].r0 = index_last_instr_tab+1;
    profondeur_de_else--;
}

void remove_jmp(){
    index_last_instr_tab--;
    for(int i=0; i <= index_last_instr_tab; i++){
        if (strcmp(tab_instruction[i].operation, "JMF") == 0 && tab_instruction[i].r1 > index_last_instr_tab){
            tab_instruction[i].r1--;
        }
        else if (strcmp(tab_instruction[i].operation, "JMP") == 0 && tab_instruction[i].r0 > index_last_instr_tab){
            tab_instruction[i].r0--;
        }
    }
}


void print_instruction_table(){
    FILE* as;
    as = fopen("./output_asm.asm", "w");
    for (int i = 0; i < index_last_instr_tab; i++){
        printf("Operation = %s, R0 = %d, R1 = %d, R2 = %d", tab_instruction[i].operation, tab_instruction[i].r0, tab_instruction[i].r1, tab_instruction[i].r2);
        fprintf(as, "%s ", tab_instruction[i].operation);
        fprintf(as, "\n");
    }
}



/*
void interpreter(){
    while(index_current_instr < index_last_instr_tab){
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
            //A faire
        } 
        else if(!strcmp(operator, "JMF")) {
            //A faire
        } 
        else if(!strcmp(operator, "PRI")) {
            printf("ZZZZZZZZZZAAAAAZEZAZDA%d\n", registre[r0]);
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
        index_current_instr++;
    }
} 



*/