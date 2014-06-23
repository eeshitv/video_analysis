
load('roki_image5_area_centroid_fullcell_fullimagenormalize_areafullmultiply');

   
  for cell_index=1:cell_number,
        

test=[];
for time=1:time_number,

   
  
         
       test=[test ; E(t).area(cell_number)];
    
end

scatter([1:1:size(test)],test)
xlabel('TIME');
ylabel('Area');
hx_1 = graph2d.constantline(30, 'Color',[1 0 0]);
changedependvar(hx_1,'x');
  
        
  
       filename=strcat('/Users/eesh/Desktop/eesh_summer_14/Documentation/Area_metric_June9toJune19/video_center/','roki_area_plots_areamult_cell',num2str(cell_index));   
    saveas(gca,filename,'tif');
    hold off

     
    close all
end

    