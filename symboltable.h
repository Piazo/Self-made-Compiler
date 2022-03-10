Symbol TableSymbol[128];

typedef struct
{
    char* name;
    int addr;
    enum typeVar type;
    int profondeur;
}Symbol;

enum typeVar {
    t_int
};

int addSymbol (char* NomSymbol, typeVar type, int profondeur);
int delSymbol (Symbol Symbol);