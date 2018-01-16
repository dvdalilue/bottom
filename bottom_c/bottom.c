#include <stdio.h>
#include <stdlib.h>
#include "list.h"

int reach(list **graph, int nodes, int from, int to)
{
    int current;
    int visited[nodes];

    list *stack;
    node *neighbor;

    listInit(&stack);
    push(stack,from);

    for (int i = 0; i < nodes; i++) {
        visited[i] = 0;
    }

    while (!isEmpty(stack))
    {
        current = head(stack);

        if (visited[current]) { continue; }

        visited[current] = 1;

        if (visited[to]) { destroy(&stack); return 1; }

        neighbor = graph[current]->first;

        while (neighbor != NULL) {
            if (neighbor->value == to)
            {
                destroy(&stack);
                return 1;
            }
            push(stack, neighbor->value);
            neighbor = neighbor->next;
        }
    }

    destroy(&stack);
    return 0;
}

void bottom(list **graph, int nodes, int edges)
{
    node *aux;
    list *sinks;

    listInit(&sinks);

    for (int i = nodes-1; i >= 0; i--)
    {
        for (int j = 0; j < nodes; j++)
        {
            if (!reach(graph,nodes,j,i))
            {
                break;
            }
            else if (j == nodes - 1)
            {
                push(sinks,i);
            }
        }
    }

    aux = sinks->first;

    while (aux != NULL)
    {
        printf("%d ", aux->value+1);
        aux = aux->next;
    }

    printf("\n");

    destroy(&sinks);
}

int main(int argc, char const *argv[])
{
    int nodes;
    int edges;

    int from;
    int to;

    list **graph;

    scanf("%d %d",&nodes,&edges);
    
    while (nodes)
    {
        graph = (list **) malloc (sizeof(list *) * nodes);

        for (int i = 0; i < nodes; i++)
        {
            listInit(&(graph[i]));
        }

        for (int i = 0; i < edges; ++i)
        {
            scanf("%d %d",&from,&to);
            push(graph[from-1],to-1);
        }

        bottom(graph, nodes, edges);

        for (int i = 0; i < nodes; i++)
        {
            destroy(&(graph[i]));
        }

        free(graph);

        scanf("%d %d",&nodes,&edges);
    }

    return 0;
}