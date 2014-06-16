
load('water_image_area');


for time=1:time_number,

    image_path=strcat('/Users/eesh/Desktop/video_analysis_data/water_injection/Image21_121813/Myosin/Image21_121813_t',sprintf('%03d',time),'_z008_c001.tif')  ;  
    A=imread(image_path); 
    imshow(A);
    hold on;
    
    for cell_index=1:cell_number,
        
         tx = datax{time,1,cell_index}'./res;

        ty = datay{time,1,cell_index}'./res;

         vert_cell=size(tx,2);
     t_poly=zeros(vert_cell,2);

     for i=1:vert_cell,
         t_poly(i ,1)=tx(i);
         t_poly(i ,2)=ty(i);
     end

      t_poly;
        
    plot(E(time).cell(cell_index).COM_X, E(time).cell(cell_index).COM_Y, 'rx');
    h = fill(tx,ty,'r');
    set(h,'FaceColor','None');
    text(E(time).cell(cell_index).COM_X, E(time).cell(cell_index).COM_Y,num2str(cell_index));
    hold on;    
        
    end
       filename=strcat('/Users/eesh/Desktop/eesh_summer_14/Documentation/Area_metric_June9toJune19/video_center/','centerofmass_water_image',num2str(time));   
    saveas(gca,filename,'fig');
    hold off

     
    close all
end

    