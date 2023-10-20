%%%This code will run the code necessary to process the images use for
%%%Figure S5 in the supplementary text.

%run separate droplet sections
[T0,T0_dilate,T0_centers,T0_radii,T0_tracker] = image_process('(#11-15) 20210825/T=0',1.5,80,110,0.88);
[T4,T4_dilate,T4_centers,T4_radii,T4_tracker] = image_process('(#11-15) 20210825/T=4',1,80,110,0.88);
[T8,T8_dilate,T8_centers,T8_radii,T8_tracker] = image_process('(#11-15) 20210825/T=8',1,80,110,0.88);
[T14,T14_dilate,T14_centers,T14_radii,T14_tracker] = image_process('(#11-15) 20210825/T=14',1,80,110,0.88);
[T28,T28_dilate,T28_centers,T28_radii,T28_tracker] = image_process('(#11-15) 20210825/T=28',1,80,110,0.88);

%If you want to see the processed images
% figure()
% imshow(T0)
% figure()
% imshow(T0_dilate)
% h_final = viscircles(T0_centers, T0_radii-25)
% 
% figure()
% imshow(T28)
% figure()
% imshow(T28_dilate)
% h_final = viscircles(T28_centers, T28_radii-25)
% 
% figure()
% imshow(T8)
% figure()
% imshow(T8_dilate)
% h_final = viscircles(T8_centers, T8_radii-25)
% 
% figure()
% imshow(T14)
% figure()
% imshow(T14_dilate)
% h_final = viscircles(T14_centers, T14_radii-25)
% 
% figure()
% imshow(T4)
% figure()
% imshow(T4_dilate)
% h_final = viscircles(T4_centers, T4_radii-25)

T0_tracker = T0_tracker(~isnan(T0_tracker));
T4_tracker = T4_tracker(~isnan(T4_tracker));
T8_tracker = T8_tracker(~isnan(T8_tracker));
T14_tracker = T14_tracker(~isnan(T14_tracker));
T28_tracker = T28_tracker(~isnan(T28_tracker));

mean_T0 = mean(T0_tracker);
std_T0 = std(T0_tracker);
mean_T4 = mean(T4_tracker);
std_T4 = std(T4_tracker);
mean_T8 = mean(T8_tracker);
std_T8 = std(T8_tracker);
mean_T14 = mean(T14_tracker);
std_T14 = std(T14_tracker);
mean_T28 = mean(T28_tracker);
std_T28 = std(T28_tracker);

%If you need to subsample the data

subsample = min([length(T0_tracker) 
length(T4_tracker)
length(T8_tracker)
length(T14_tracker)
length(T28_tracker)]);

C0114_tracker_subsample = datasample(T0_tracker,subsample,'Replace',false);
N0114_tracker_subsample = datasample(T4_tracker,subsample,'Replace',false);
C0217_tracker_subsample = datasample(T8_tracker,subsample,'Replace',false);
N0217_tracker_subsample = datasample(T14_tracker,subsample,'Replace',false);
C0506_tracker_subsample = datasample(T28_tracker,subsample,'Replace',false);