 tx = datax{time,1,cell_index}'./res;

    ty = datay{time,1,cell_index}'./res;

     vert_cell=size(tx,2);
   t_poly=zeros(vert_cell,2);

   for i=1:vert_cell,
       t_poly(i ,1)=tx(i);
       t_poly(i ,2)=ty(i);
   end

   t_poly;
    
%now i just need to use the vertices(i already know how to access them, i
%just have to use roipoly with vertices and i am done.
%%


%%THe center of mass is stored in the variables COM_X and COM_Y and an
%%image is outputed by the program(the tiny red dot is the center of mass)

  %just enter the image file, make sure you enter the file is added to MATLAB's path
    
    BW=roipoly(A,tx,ty);
    BW=double(BW);
    SE = strel('octagon',3);
    BW = imerode(BW,SE);    %eroding the edges
    cell(cell_index).ANS=BW.*A;
    %imshow(ANS);
    g = mat2gray(cell(cell_index).ANS);
    ANS = im2bw(g, threshold);
cell(cell_index).ANS=uint8(cell(cell_index).ANS); %we can now use this to plot whatever cell we want!
%% This part of the code is for finding the x coordinate of the center of mass
%ANS is the variable with the image that has been cut using roipoly
    X_pixels=size(A,1);
    Y_pixels=size(A,2);
    xtotals = sum(ANS~=0,1);
%the for loop just adds 1s to the places where there are zeros so there is
%no division by zero 
    for i=1:Y_pixels,
        if(xtotals(i)==0) xtotals(i)=xtotals(i)+1;
        end
    end
    
    x_totals=xtotals;
    T=sum(ANS,1);
    X=T./x_totals;
    COM_X=0;
    SUM_X=sum(X);
    
    for j=1:Y_pixels,
        COM_X= j*X(j)+COM_X;
    end
    
    COM_X=COM_X/SUM_X;
    



%% This part of the code finds the y coordinate of the center of mass

    ytotals = sum(ANS~=0,2);
    for i=1:X_pixels,
        if(ytotals(i)==0) ytotals(i)=ytotals(i)+1;
        end
    end
    
    y_totals=ytotals;

    T=sum(ANS,2);

    Y=T./y_totals;
    COM_Y=0;
    SUM_Y=sum(Y);
    for j=1:X_pixels,
        COM_Y= j*Y(j)+COM_Y;
    end
    COM_Y=COM_Y/SUM_Y;

    
    %%TRYING THE CENTROID OF 15% MAXIMA, AFTER TESTING, I CONCLUDE THAT MY
    %%METHOD WORKS BETTER
    if 0
    QWERT=regionprops(BW, 'Centroid');
    COM_X=QWERT.Centroid(1);
    COM_Y=QWERT.Centroid(2);
    end
    %%
    cell(cell_index).COM_X=COM_X;
    cell(cell_index).COM_Y=COM_Y;

    if 0
        %%HERE I ATTEMPT TO FIND THE position of the maxima of intensity
        [maxValue, linearIndexesOfMaxes] = max(ANS(:));

        [rowsOfMaxes colsOfMaxes] = find(ANS == maxValue);
        COM_Y=rowsOfMaxes(1);
        COM_X=colsOfMaxes(1);
    end
%% the following code plots the center of mass onto the figure
%imshow(ANS);
%hold on;
%tx and ty are the vertices' x and y coordinates for the cell corresponding to this loops iteration in a vertex form)
