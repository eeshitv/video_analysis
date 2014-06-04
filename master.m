%%This script allows you to find the center of mass of a grayscale
%%image. You need to enter the path of the image in the first line of code.
%%The program will then ask you to select the part of the image whose
%%center of mass is to be found. 

%% The algorithm first finds the point of maximmum intensity for each cell and then normalizes the intensity of each of the pixel in the cell by dividing each pixel value with the value of the maximum intensity of a pixel in the cell(now each value lies between zero and one). Then it applies a filter that filters out the pixels with intensities less than a certain threshold(15%) and then it finds the weighted centre of mass(centre of intensity) of each of the cells. THis is the Rok Focus of the cells
clear all;



res=0.13; % this is determined by the microscopes, it is 0.2125 if you have 0.2125 microns per pixel, 0.1417 for spn


%%Loading the data
load('/Users/eesh/Desktop/video_analysis_data/rok_inhibitor_injection/Image5_011113/Measurements/Membranes--vertices--Vertex-x.mat');
datax=data;
cell_number=size(datax,3); % This just assigns 109 to the cel_number for the given file
load('/Users/eesh/Desktop/video_analysis_data/rok_inhibitor_injection/Image5_011113/Measurements/Membranes--vertices--Vertex-y.mat'); %this loads the y 
datay=data;
cell_number=size(datay,3); % This just assigns 109 to the cel_number for the given file
COM=zeros(cell_number,2);


%nox_vertices=zeros(1,cell_number);
%for i=1:cell_number,
%    nox_vertices(i) = size(data{1,1,i},1); %this is
%end
%nox_vertices;

A=imread('/Users/eesh/Desktop/video_analysis_data/rok_inhibitor_injection/Image5_011113/Myosin/Image5_011113_t042_z008_c001.tif'); 
A_hold=A;

imshow(A);
A=double(A);

hold on;


for cell_index=1:cell_number, %this mega for loop calculates the COM for all the cells which are taken from the edge output
    
  tx = datax{1,1,cell_index}'./res

    ty = datay{1,1,cell_index}'./res;

     vert_cell=size(tx,2);
   t_poly=zeros(vert_cell,2);

   for i=1:vert_cell,
       t_poly(i ,1)=tx(i);
       t_poly(i ,2)=ty(i);
   end

   t_poly;
  
    h = fill(tx,ty,'r');
    set(h,'FaceColor','None');
    hold on;

end


