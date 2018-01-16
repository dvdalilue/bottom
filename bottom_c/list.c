#include <stdio.h>
#include <stdlib.h>
#include "list.h"

void listInit (list** l)
{
    *l = (list *) malloc (sizeof(list));
    (*l)->first = NULL;
    (*l)->size = 0;
}

int isEmpty (list* l)
{
    return l->size ? 0 : 1;
}

void push (list* l, int n)
{
    node *aux = (node *) malloc (sizeof(node));

    aux->value = n;
    aux->next = l->first;

    l->first = aux;
    l->size++;
}

int head (list* l) {
    if (isEmpty(l)) {
        printf("*** Error: retriving head on empty list\n");
        exit(1);
    }

    node *tmp = l->first;
    int r = tmp->value;

    l->first = l->first->next;
    l->size--;

    free(tmp);

    return r;
}

void destroy(list** l) {
    node *aux = (*l)->first;
    node *tmp = NULL;

    while (aux != NULL)
    {
        tmp = aux->next;

        free(aux);

        aux = tmp;
    }

    free(*l);
}