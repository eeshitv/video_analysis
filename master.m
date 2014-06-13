
clear all;

res=0.13; % this is determined by the microscopes, it is 0.2125 if you have 0.2125 microns per pixel, 0.1417 for spn
threshold=0.8;

%%Loading the data
load('/Users/eesh/Desktop/video_analysis_data/rok_inhibitor_injection/Image5_011113/Measurements/Membranes--vertices--Vertex-x.mat');
datax=data;
cell_number=size(datax,3); % This just assigns 109 to the cel_number for the given file
load('/Users/eesh/Desktop/video_analysis_data/rok_inhibitor_injection/Image5_011113/Measurements/Membranes--vertices--Vertex-y.mat'); %this loads the y 
datay=data;

load('/Users/eesh/Desktop/video_analysis_data/rok_inhibitor_injection/Image5_011113/Measurements/Membranes--basic_2d--Area.mat'); %this loads the y 
area=data;



cell_number=size(datay,3); % This just assigns 109 to the cel_number for the given file
time_number=size(datay,1);



for time=1:time_number,
area=[];
%%sprintf is awesome!
image_path=strcat('/Users/eesh/Desktop/video_analysis_data/rok_inhibitor_injection/Image5_011113/Myosin/Image5_011113_t',sprintf('%03d',time),'_z008_c001.tif')  ;  
A=imread(image_path); 
A_hold=A;
%imshow(A);
%hold on
A=double(A);

score=0;

for cell_index=1:cell_number, %this mega for loop calculates the COM for all the cells which are taken from the edge output
  
    %%if for NAN check
  if(~isnan(datax{time,1,cell_index})) 
          
     tx = datax{time,1,cell_index}'./res;

    ty = datay{time,1,cell_index}'./res;

     vert_cell=size(tx,2);
   t_poly=zeros(vert_cell,2);

   for i=1:vert_cell,
       t_poly(i ,1)=tx(i);
       t_poly(i ,2)=ty(i);
   end

   t_poly;
   
       
   run('/Users/eesh/Desktop/video_analysis/centerofmass_cell');
   
   run('/Users/eesh/Desktop/video_analysis/radial_distribution.m');

  E(time).cell=cell;
     
    %%PROBABILITY USING IMHIST
    %%CUTTING INTO POLYGONS
    BW=roipoly(A,tx,ty);
    BW=double(BW);
   % SE = strel('octagon',3);
    %BW = imerode(BW,SE);    %eroding the edges
    
    ANS=BW.*A;
    
    [rmx,t]=max(cell(cell_index).mean);
    %[rmn,t]=min(cell_rok(cell_index).mean);
    
    cell(cell_index).mean = cell(cell_index).mean/(rmx) ; 
    cell(cell_index).mean = (2/cell(cell_index).mean(1,1))*cell(cell_index).mean ;

     y=cell(cell_index).mean(:,:)';
        x=[1:1:size(cell(cell_index).mean,1)];
        p=polyfit(x,y,10);
    
        f = polyval(p,x);

       %%horizontal line intersection part
y1=2*ones(1,size(f,2));
y2=y;
idx = find(y1 - y2 < eps, 1,'last'); %// Index of coordinate in array
px = x(idx);
py = y1(idx);
%

f=f(:,1:px);
trap=trapz(f);% - 2*(px-1);
    

    
    area= [ area ; trap ];
   
  %%if for nan check ends here  
  end
  
end

E(time).area=area;

end

%%
%load('roki_image5');
if 1

test=[];

for t=1:time_number,
   
    test=[test ; E(t).area(2)];
    
end

scatter([1:1:size(test)],test)
xlabel('TIME');
ylabel('Area');
hx_1 = graph2d.constantline(22, 'Color',[1 0 0]);
changedependvar(hx_1,'x');

end