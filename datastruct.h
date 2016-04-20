#include <stdio.h>
#include <malloc.h>


typedef struct shapes
{
 int shape_type;
 struct shapes *list;
 struct shapes *next;
}shapes;




