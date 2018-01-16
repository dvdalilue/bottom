#ifndef list

typedef struct nodeS
{
    int value;
    struct nodeS *next;
} node;

typedef struct listS
{
    struct nodeS *first;
    int size;
} list;

void listInit (list **l);
int isEmpty (list* l);
void push (list* l, int n);
int head (list* l);
void destroy(list **l);

#endif