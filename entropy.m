
clear all;

res=0.13; % this is determined by the microscopes, it is 0.2125 if you have 0.2125 microns per pixel, 0.1417 for spn


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
entropy=[];
%%sprintf is awesome!
image_path=strcat('/Users/eesh/Desktop/video_analysis_data/rok_inhibitor_injection/Image5_011113/Myosin/Image5_011113_t',sprintf('%03d',time),'_z008_c001.tif')  ;  
A=imread(image_path); 
A_hold=A;
%imshow(A);
A=double(A);



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
   
    
  
     
    %%PROBABILITY USING IMHIST
    %%CUTTING INTO POLYGONS
    BW=roipoly(A,tx,ty);
    BW=double(BW);
   % SE = strel('octagon',3);
    %BW = imerode(BW,SE);    %eroding the edges
    
    ANS=BW.*A;
    ANS=uint8(ANS);
    probability=double(imhist(ANS)/(size(A,1)*size(A,2)));
    %%this , as log(0) is -infinity, we ignore those values
    ln=log(probability);
    ln(~isfinite(ln))=0;
    
    entropy= [ entropy ; (( -ln)' * (probability))/(sum(sum(ANS,1),2)) ];
   
  %%if for nan check ends here  
  end
  
end

E(time).entropy=entropy;

end

%%
%load('roki_image5');

test=[];

for t=1:time_number,
   
    test=[test ; E(t).entropy(1)];
    
end

scatter([1:1:size(test)],test)
xlabel('TIME');
ylabel('ENTROPY');
hx_1 = graph2d.constantline(22, 'Color',[1 0 0]);
changedependvar(hx_1,'x');