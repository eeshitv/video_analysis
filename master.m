
clear all;

res=0.13; % this is determined by the microscopes, it is 0.2125 if you have 0.2125 microns per pixel, 0.1417 for spn


%%Loading the data
load('/Users/eesh/Desktop/video_analysis_data/roki_injection/Image5_011113/Measurements/Membranes--vertices--Vertex-x.mat');
datax=data;
cell_number=size(datax,3); %    W11 This just assigns 109 to the cel_number for the given file
load('/Users/eesh/Desktop/video_analysis_data/roki_injection/Image5_011113/Measurements/Membranes--vertices--Vertex-y.mat'); %this loads the y 
datay=data;



cell_number=size(datay,3); % This just assigns 109 to the cel_number for the given file
time_number=size(datay,1);



for time=1:time_number,
%%sprintf is awesome!
image_path=strcat('/Users/eesh/Desktop/video_analysis_data/roki_injection/Image5_011113/Myosin/Image5_011113_t',sprintf('%03d',time),'_z008_c001.tif')  ;  
A=imread(image_path); 
A_hold=A;
A=double(A);



for cell_index=1:cell_number, 
  
    %%if for NAN check
  if(~isnan(datax{time,2,cell_index})) 
          
     tx = datax{time,2,cell_index}'./res;

    ty = datay{time,2,cell_index}'./res;

     vert_cell=size(tx,2);
   t_poly=zeros(vert_cell,2);

   for i=1:vert_cell,
       t_poly(i ,1)=tx(i);
       t_poly(i ,2)=ty(i);
   end

   t_poly;
   
       

   BW=roipoly(A_hold,tx,ty);
    BW=double(BW);
    SE = strel('octagon',3);
    BW = imerode(BW,SE);    %eroding the edges
    
    E(time).cell(cell_index).ANS=BW.*A;
    
    %%converting from absolute values to values between zero and one
    g = mat2gray(E(time).cell(cell_index).ANS);
    E(time).cell(cell_index).g=g;
    %
    
%%storing histogram into for each cell at each point in time before thresholding    
E(time).cell(cell_index).histogram_normalized=imhist(g);

E(time).cell(cell_index).histogram=imhist(E(time).cell(cell_index).ANS);

%





%%%%%%%%%%%%%%%%%%%THRESHOLD LOOP%%%%%%%%%%%%%%%%%%%%%%%%%
   threshold_fn=[];
   for threshold=0.05:0.05:1,

       into_bw = im2bw(g, threshold);
       [L,num] = bwlabel(into_bw);
        
    %%20 is multiplied only because we need to have the indices as
    %%integers(but the size of the array which is 20 does not change
    E(time).cell(cell_index).structure(uint8(20*threshold)).num=num;    
    %%finding the area of each of these structures
    
    for w=1:num
        E(time).cell(cell_index).structure(uint8(20*threshold)).area(w) = bwarea(L==w);
    end
  
  
   end
%%%%%%%%%%%%%%%%%%%THRESHOLD LOOP%%%%%%%%%%%%%%%%%%%%%%%%%
 
   




   
   
  %%if for nan check ends here  
  end
  
E(time).cell(cell_index).threshold_fn = threshold_fn;
  
end


end

%%
%load('roki_image5_area_centroid_fullcell_fullimagenormalize_areafullmultiply');
if 0

imhist(uint8(E(60).cell(1).ANS))
ylim([1 1000])
scatter(0:0.05:1,E(1).cell(1).threshold_fn)
xlabel('threshold');
ylabel('num');

%hx_1 = graph2d.constantline(30, 'Color',[1 0 0]);
%changedependvar(hx_1,'x');

end

%% you must save E using save -v7.3 blahblah
