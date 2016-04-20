#include <graphics.h>
#include <math.h>

int shift_x = 0, shift_y=0, change=0; 
int rect_x = 10, rect_y=10, rect_w=200, rect_h=200;
int radius, r_sq; 
int len, center_x, center_y;
int status = 1; //default i.e. allowed

void drawsquare()
{
	rectangle(rect_x,rect_y,rect_w,rect_h);
	status = 1;  //allowed
   
}

void set_color(int b)
{
 if(b==1)
 {
  setbkcolor(RED);
  setcolor(BLACK);
   }

  else if(b==2)
    {
      setbkcolor(GREEN);
      setcolor(BLACK);
     }

  else if(b==3)
     {
       setbkcolor(BLUE);
       setcolor(WHITE);
     }
}
void drawcircle()
{
	if(status ==1) 
  {
		
	radius = (rect_h - rect_y)/2;
	center_x = (rect_x + rect_w)/2;
	center_y = (rect_y + rect_h)/2;
	circle( center_x , center_y , radius);
	
	r_sq = 2*(radius * radius);
	len =  sqrt(r_sq);

	rect_x = center_x - (len)/2;
	rect_y = center_y - (len)/2;
	rect_h = center_y + (len)/2;
	rect_w = center_x + (len)/2;
	
	
    status=0; // block
   }
}

void graphinit()
{
	int gd = DETECT,gm;
    initgraph(&gd,&gm,NULL);
}	

void l_draw()
{
  rectangle(4,4, 632, 472);
}

int reset()
{
     if(change<6)
	 {
         change++;
        shift_x+=210;

          if(change==3)
          {
             shift_x = 10;
          }

          if(change>=3)
           {
            
	      shift_y = 240;
           }
	
        
	rect_x = 10 + shift_x;
	rect_y = 10 + shift_y;
	rect_h = 200 + shift_y;
	rect_w = 200 + shift_x;
	//printf("rect_x = %d , rect_y = %d , rect_w = %d , rect_h = %d \n", rect_x, rect_y,rect_w,rect_h);
	status =1; //drawing operation to default
	
        return 1;
       
     }

     else
     {
	  closegraph();	 
	  printf("\n\n\n\nSorry that thing went out \n");
          int g = getchar();
          putchar(g);
	  return 0;
     }
}
