#include <stdio.h>
#include <stdlib.h>
#include "include/absyn.h"
#include "include/prabsyn.h"
#include "include/parse.h"

int main(int argc, char **argv)
{

    A_exp prog;
    
    if(!(prog = parse(argv[1])))
        exit(1);
    
    pr_exp(stdout, prog, 0);
    printf("\n");
    
    return 0;
}
