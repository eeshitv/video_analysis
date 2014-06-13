          
     tx = datax{time,1,cell_index}'./res;

    ty = datay{time,1,cell_index}'./res;

     vert_cell=size(tx,2);
   t_poly=zeros(vert_cell,2);

   for i=1:vert_cell,
       t_poly(i ,1)=tx(i);
       t_poly(i ,2)=ty(i);
   end

   t_poly;

intersect=intersectLinePolygon(line, t_poly);
       
  %%THe plotting of lines takes a long time and is unnecessary now so i am
  %%commenting this part of the code
    %if(rok),
    %       h = fill([cell(cell_index).COM_X intersect(1,1)],[cell(cell_index).COM_Y intersect(1,2)],'r');
    %       set(h,'FaceColor','None');
    %       h = fill([cell(cell_index).COM_X intersect(2,1)],[cell(cell_index).COM_Y intersect(2,2)],'r');
    %       set(h,'FaceColor','None');
    % end
     %NOW TO SAVE THE INTENSITIES IN A MATRIX  
     if(quadrant)
x=[cell(cell_index).COM_X intersect(1,1)];
y=[cell(cell_index).COM_Y intersect(1,2)];
     end
     
     if(~quadrant)
x=[cell(cell_index).COM_X intersect(2,1)];
y=[cell(cell_index).COM_Y intersect(2,2)];
     end
     
[cx,cy,C_temp]=improfile(A,x,y,'bilinear');

[c,i_line]=max(C_temp(:,:)); %%use the new customized maxima function if you dont care about time
MAX=[MAX; cx(i_line) , cy(i_line)];


