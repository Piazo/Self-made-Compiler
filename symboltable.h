#define TABLESIZE 128

typedef struct
{
    char* name;
    char* type;
    int index;
    int profondeur;
    int est_une_cst; //si 0, var pas constante, si 1 var constante
}Symbol;

Symbol TableSymbol[TABLESIZE];

void addSymbol (char* NomSymbol);
void delSymbol ();
void incr_profondeur();
void decrem_profondeur();
void update_type(char* type, int cst);
void print_symbol();
int get_index(char* name);