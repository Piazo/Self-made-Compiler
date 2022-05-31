#include "stdlib.h"
#include "symboltable.h"
#include "stdio.h"
#include <stdbool.h>
#include <string.h>




#define TABLESIZE 128
Symbol TableSymbol[TABLESIZE];

int index1 = -1;
int type_index1 = -1;
int profondeur = 0;

void incr_profondeur(){
    profondeur++;
}

void decrem_profondeur(){
    delSymbol();
}

void addSymbol (char* NomSymbol){
    index1++;
    char* name = (char*) malloc(strlen(NomSymbol));
    strncpy(name, NomSymbol, strlen(NomSymbol));
    TableSymbol[index1].name = name;
    TableSymbol[index1].type = "int";
    TableSymbol[index1].index1 = index1;
    TableSymbol[index1].profondeur = profondeur;
}

void delSymbol (){
    int profdr = TableSymbol[index1].profondeur;
    profondeur--;
    while(index1>1 && TableSymbol[index1].profondeur == profdr){
        index1--;
    }
}

void print_symbol(){
    for (int i = 0; i<index1; i++){
        printf("Nom : %s, Type : %s, index : %d, Profondeur : %d", TableSymbol[i].name,
            TableSymbol[i].type, TableSymbol[i].index1, TableSymbol[i].profondeur);
    }
}

int get_index(char* name){
    int index1temp = 0;
    bool notfound = true;
    while (index1temp<index1 && notfound){
        if (0 == strcmp(name, TableSymbol[index1temp].name)){
            notfound = false;
        }
        index1temp++;
    }
    if (notfound) {
        return -1;
    } else {
        return index1temp;
    }
}
