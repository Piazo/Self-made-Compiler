

typedef struct
{
    char* name;
    char* type;
    int index1;
    int profondeur;
}Symbol;


void addSymbol (char* NomSymbol);
void delSymbol ();
void incr_profondeur();
void decrem_profondeur();
void print_symbol();
int get_index(char* name);