#include "assembleur.h"

int index_tab = 0;
int ILOE = 0; //index of the last operation executed

void add_instruc_to_tab(char* nom_ope, int r1, int r2, int r3){
    strcpy(tab_instruction[index_tab].ope, nom_ope);
    tab_instruction[index_tab].r1 = r1;
    tab_instruction[index_tab].r2 = r2;
    tab_instruction[index_tab].r3 = r3;
    index_tab++;
}

int get_index (){
    return index_tab;
}

void interpreter(){
    while (index_last_ope_executed<index_tab){
        char operation_a_faire[3];
        strcpy(operation_a_faire, tab_instruction[ILOE]);





    }
}

