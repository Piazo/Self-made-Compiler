#include "assembleur.h"
#include <stdio.h>
#include <string.h>


int main(){
    int a;
    a= add_instruc_to_tab("AFC", 5, -1,-1);
    printf("%d", a);
}
