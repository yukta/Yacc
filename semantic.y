/*
    YML 
    Designed by: Abhay Raj Malhotra - 1215
                 Smarth Mehta - 1525 
                 Simranpreet Kaur - 1203 
                 Jasmine Kaur - 1258 
                 Ruby Sharma -
*/

/*
color -> 1 for RED
         2 for GREEN
         3 for BLUE

shape_tyoe -> 1 for circle
              2 for square
*/

%{
#include <stdio.h>
#include <string.h>
#include <malloc.h>
#include "datastruct.h"
#include "draw.h"

void drawshape(shapes *n); // function for drawing shapes 
void callshape(shapes *n); // function for accessing linked list
int nesting=40; int counter=0; //defaults of nesting and counter
%}

%union
{
struct shapes *shape;
int num; 
}

%type <shape> run // from where program starts 
%type <shape> start // forms multiple design 
%type <shape> pursue  //forms nested design 
%type <shape> Circle // circle and within
%type <shape> Square //square and within
%type <void> YS 
%type <void> YSE
%token <num> NUMBER // detects number occurence 
%token 	CIRCLE_START CIRCLE_STOP SQUARE_START SQUARE_STOP yml_start yml_end YML YMLE CLR BORDER NEST_MAX //tokens for different lexemes 



%%
run: YS CLR NUMBER yml_end start YSE								// case where only color is specified i.e '010'
     {  $$ = $5;graphinit(); set_color($3);callshape($5);}
    |YS NEST_MAX NUMBER yml_end start YSE							// maximum nesting specified i.e '001'
     {  $$ = $5; nesting=$3;  graphinit(); set_color(10);callshape($5);}
    |YS CLR NUMBER NEST_MAX NUMBER yml_end start YSE						// both color and nesting specified i.e. '011'
     {  $$ = $7; nesting=$5;  graphinit(); set_color($3);callshape($7);}
    |YS BORDER NEST_MAX NUMBER yml_end start YSE 						// border nesting specified i.e. '101'
     {  $$ = $6; nesting=$4;  graphinit(); set_color(10); l_draw(); callshape($6);}
    |YS BORDER CLR NUMBER NEST_MAX NUMBER yml_end start YSE 					// all 3 specified i.e '111'
     {  $$ = $8; nesting=$6;  graphinit(); set_color($4); l_draw(); callshape($8);} 
    |YS BORDER yml_end start YSE 								// for only border i.e '100'
     {  $$ = $4;graphinit(); set_color(10); l_draw(); callshape($4);}
    |YS BORDER CLR NUMBER yml_end start YSE 							// border and color specified i.e '110'
     {  $$ = $6;graphinit(); set_color($4); l_draw(); callshape($6);}
    |YS yml_end start YSE 
     { $$ = $3;graphinit();set_color(10);callshape($3);};					// nothing  i.e '000'
   
     
YS: yml_start YML  {};

YSE:  yml_start YMLE yml_end   {};


start: 
       Circle start										// case for circle begin
       {  $1->next= $2; $$ = $1;  }  
       |
       Square start 										//case for square begin
       {$1->next = $2; $$ = $1; } 
       |											// case for start = NULL 
       {$$= NULL; }		
       ;

pursue: Circle { $$ = $1;} 									// so as to resist further new shapes 
        |Square {$$ = $1;} 
        |{$$ = NULL; } 
        ; 
        



Circle: CIRCLE_START pursue CIRCLE_STOP								// calls pursue to form more shapes
	{	
		shapes *temp = (shapes*)malloc(sizeof(shapes));					// allocating memory to a new node
		temp->shape_type = 1;								// specifing shape
 		temp->next = NULL; temp->list =$2; $$=temp;					// assigning Circle to be temp transitively
	};


Square: SQUARE_START pursue SQUARE_STOP
	{	
                shapes *temp = (shapes*)malloc(sizeof(shapes));
		temp->shape_type = 2; temp->next = NULL;
 		temp->list =$2; $$=temp;
	};


%%

yyerror(char *s)
{
printf("%s\n",s);
exit(100);
}


void drawshape(shapes *n) //modified recursion loop 
{

   if (n==NULL) 
     {
	
     return; 
      }
   else
   {
    counter+=1; //checking for a run time exception of nesting 
    
    if(counter==nesting)
       {
          closegraph();
          yyerror("Runtime error");
        }
   if(n->shape_type==1) //circle draw
     drawcircle();

   else if(n->shape_type==2) // draw a square
     drawsquare();
    
   drawshape(n->list);  // looking more of its nested designs 

  }

}

void callshape(shapes *n)
{
   int s;
    while(n) //till the time more design occurs 
     {
            
            drawshape(n);
            s = reset(); // calling graphic library for checking accomodation 
            if(s==0)
	     {
                 break;
              }
            counter=0; // setting counter as 0 for next loop 
            n = n->next; // move to next
           
     }
   
  
       if(s==0)
           exit(100);
       
       else
          delay(10000);
}
