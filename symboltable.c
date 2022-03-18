#include "stdlib.h"
#include "symboltable.h"
#include "stdio.h"

int index = -1;
int type_index = -1
int profondeur = 0;

void incr_profondeur(){
    profondeur++;
}

void decrem_profondeur(){
    profondeur--;
}

void addSymbol (char* NomSymbol){
    index++;
    TableSymbol[index] = {.name = NomSymbol, .type=NULL, .index = index, .profondeur = profondeur}
}

void delSymbol (){
    int profdr = TableSymbol[index].profondeur;
    profondeur--;
    while(index>1 && TableSymbol[index].profondeur == profdr){
        index--;
    }
}

void update_type(char* type, int cst){
    while (type_index < index){
        type_index++;
        TableSymbol[type_index].type = type;
        TableSymbol[type_index].est_une_cst = cst;
    }
}

void print_symbol(){
    for (int i = 0; i<index; i++){
        printf("Nom : %s, Type : %s, Index : %d, Profondeur : %d, Cst : %d", TableSymbol[i].name,
            TableSymbol[i].type, TableSymbol[i].index, TableSymbol[i].profondeur, TableSymbol[i].est_une_cst);
    }
}

int get_index(char* name){
    int indextemp = 0;
    bool notfound = true;
    while (indextemp<index && notfound){
        if (0 == strcmp(name, TableSymbol[indextemp].name)){
            notfound = false;
        }
    }
    if (notfound) {
        return -1;
    } else {
        return indextemp;
    }
}