function [image_compile,final_dilate,centers_final,radii_final,tracker] = image_process(folder_name,fudge_factor,low_dim,high_dim,sens)

%%%This function intakes a phase contrast image of biofilms growing in
%%%microdroplets and determines the porportion of the area of the droplet
%%%that is being taken up by the biofilm. specific the folder_name that the
%%%images are under, and this function will take all the files and analyze
%%%them together. fudge_factor is for taking the threshold of how sensitive
%%%the detection algorithm will detect cells and particles. Typically it is
%%%set at 1. low_dim and high_dim are the limits of detection for detecting
%%%the droplet sizes between radii of low_dim and high_dim. Sens is the
%%%sensitivity of circles being detected as droplets. The output are the
%%%compiled phase contrast image (image_compile), the detection of what
%%%lines and biofilms are detected (final_dilate), the centers and radii of
%%%the individual droplets that were detected, and the areas of the
%%%droplets being occupied by a biofilm as a array (tracker).

%%read in filenames
files = dir([folder_name,'/','*.tif']);
files_cell = struct2cell(files);
filesname = string(files_cell(1,:));

%%stitch folder together
for n=1:6

    imageread = imread([folder_name,'/',convertStringsToChars(filesname(n))])*3;
    if n==1
%         image_compile((1:1100),(1+(n-1)*1344:1344+(n-1)*1344))=imageread;
        image_compile1 = imageread;
    elseif n>1 && n<=3
        image_compile1 = [image_compile1 imageread];
    elseif n==4
        image_compile2 = imageread;
    elseif n>4
        image_compile2 = [image_compile2 imageread];
%image_compile((1101:2200),(1+(n-1)*1344:1344+(n-1)*1344))=imageread; 
    end
end

image_compile = [image_compile1; image_compile2];

%%%%%For additional manual on cell detection tried incorporating https://www.mathworks.com/help/images/detecting-a-cell-using-image-segmentation.html

%detect edges of filamentous bacteria
[~,threshold] = edge(image_compile,'canny');
%standard fudge_factor = 1;
final_edge = edge(image_compile,'canny',threshold*fudge_factor);

se90 = strel('line',4,90);
se0 = strel('line',4,0);
final_dilate = imdilate(final_edge,[se90 se0]);

%%standard values are low_dim=80,high_dim=100,sens=0.88
[centers_final,radii_final] = imfindcircles(image_compile,[low_dim high_dim],'Sensitivity',sens);
num_circles_final = length(centers_final);

% remove imcomplete circles that are on the boundaries
radius = 80;

for i = 1:num_circles_final
        if (centers_final(i,1) < (radius)) || ((centers_final(i,1) > (1344-radius)) && (centers_final(i,1) < (1344+radius))) || ((centers_final(i,1) > (2688-radius)) && (centers_final(i,1) < (2688+radius))) || (centers_final(i,1) > (4032-radius))
            centers_final(i,:) = [NaN,NaN];
            radii_final(i) = NaN;
        end
end

for i = 1:num_circles_final
        if (centers_final(i,2) < (radius)) || ((centers_final(i,2) > (1100-radius)) && (centers_final(i,2) < (1100+radius))) || (centers_final(i,2) > (2200-radius))
            centers_final(i,:) = [NaN,NaN];
            radii_final(i) = NaN;
        end
end

tracker = zeros(num_circles_final,1);

%go through each droplet and calculate and track brightness value
for n=1:num_circles_final
    center = centers_final(n,:);
    radius = radii_final(n)-25;
    
    [xgrid, ygrid] = meshgrid(1:size(image_compile,2), 1:size(image_compile,1));
    mask = ((xgrid-center(1,1)).^2 + (ygrid-center(1,2)).^2) <= radius.^2;
    intensity_droplet = final_dilate(mask);
    
    intensity=sum(intensity_droplet);
    norm_intensity = intensity/(radii_final(n)^2*pi);
    tracker(n) = norm_intensity;
end