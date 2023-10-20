%%%This code will run the code necessary to process the images use for
%%%Figure 5 in the main text. R is used for the processing of the data to
%%%generate the figure.

%run separate droplet sections
%%0114, 0217, 0506 have pH4 growth images (but 0506pH4 is kinda bad quality). 0806 does not.
[C0114,C0114_dilate,C0114_centers,C0114_radii,C0114_tracker] = image_process('(#11-5) 20210114/T=24hr/CVF',1.5,80,110,0.88);
[N0114,N0114_dilate,N0114_centers,N0114_radii,N0114_tracker] = image_process('(#11-5) 20210114/T=24hr/NYC',1,80,110,0.88);
[C0217,C0217_dilate,C0217_centers,C0217_radii,C0217_tracker] = image_process('(#11-6) 20210217/T=24hr/CVF',1,80,110,0.88);
[N0217,N0217_dilate,N0217_centers,N0217_radii,N0217_tracker] = image_process('(#11-6) 20210217/T=24hr/NYC',1,80,110,0.88);
[C0506,C0506_dilate,C0506_centers,C0506_radii,C0506_tracker] = image_process('(#11-13) 20210506/T=24hr/CVF',1,80,110,0.88);
[N0506,N0506_dilate,N0506_centers,N0506_radii,N0506_tracker] = image_process('(#11-13) 20210506/T=24hr/NYC',1,80,110,0.88);
[C0806,C0806_dilate,C0806_centers,C0806_radii,C0806_tracker] = image_process('(#11-14) 20210806/T=24hr/CVF',1,80,110,0.88);
[N0806,N0806_dilate,N0806_centers,N0806_radii,N0806_tracker] = image_process('(#11-14) 20210806/T=24hr/NYC',1,80,110,0.88);
[C0114pH4,C0114pH4_dilate,C0114pH4_centers,C0114pH4_radii,C0114pH4_tracker] = image_process('(#11-5) 20210114/T=24hr/CVFpH4',1,80,110,0.88);
[C0217pH4,C0217pH4_dilate,C0217pH4_centers,C0217pH4_radii,C0217pH4_tracker] = image_process('(#11-6) 20210217/T=24hr/CVFpH4',1,80,110,0.88);

%%If you want to see the images processed from above
% figure()
% imshow(C0114)
% figure()
% imshow(C0114_dilate)
% h_final = viscircles(C0114_centers, C0114_radii-25)
% 
% figure()
% imshow(C0506)
% figure()
% imshow(C0506_dilate)
% h_final = viscircles(C0506_centers, C0506_radii-25)
% % 
% figure()
% imshow(C0217)
% figure()
% imshow(C0217_dilate)
% h_final = viscircles(C0217_centers, C0217_radii-25)
% 
% figure()
% imshow(C0217)
% figure()
% imshow(C0217_dilate)
% h_final = viscircles(C0217_centers, C0217_radii-25)

%%Manual data curation
%removing the one outlier from C0114 T=24 due to its weird morphology, I
%suspect it must've been like that from T=0
C0114_tracker = C0114_tracker(C0114_tracker<0.20);

%Subset real values from droplets that were removed due to being on the 
%peripheral of the image)
C0114_tracker = C0114_tracker(~isnan(C0114_tracker));
N0114_tracker = N0114_tracker(~isnan(N0114_tracker));
C0217_tracker = C0217_tracker(~isnan(C0217_tracker));
N0217_tracker = N0217_tracker(~isnan(N0217_tracker));
C0506_tracker = C0506_tracker(~isnan(C0506_tracker));
N0506_tracker = N0506_tracker(~isnan(N0506_tracker));
C0806_tracker = C0806_tracker(~isnan(C0806_tracker));
N0806_tracker = N0806_tracker(~isnan(N0806_tracker));
C0114pH4_tracker = C0114pH4_tracker(~isnan(C0114pH4_tracker));
C0217pH4_tracker = C0217pH4_tracker(~isnan(C0217pH4_tracker));

%If you need to subsample the data
subsample = min([length(C0114_tracker) 
length(N0114_tracker)
length(C0217_tracker)
length(N0217_tracker)
length(C0506_tracker)
length(N0506_tracker)
length(C0806_tracker)
length(N0806_tracker)
length(C0114pH4_tracker)
length(C0217pH4_tracker)]);

C0114_tracker_subsample = datasample(C0114_tracker,subsample,'Replace',false);
N0114_tracker_subsample = datasample(N0114_tracker,subsample,'Replace',false);
C0217_tracker_subsample = datasample(C0217_tracker,subsample,'Replace',false);
N0217_tracker_subsample = datasample(N0217_tracker,subsample,'Replace',false);
C0506_tracker_subsample = datasample(C0506_tracker,subsample,'Replace',false);
N0506_tracker_subsample = datasample(N0506_tracker,subsample,'Replace',false);
C0806_tracker_subsample = datasample(C0806_tracker,subsample,'Replace',false);
N0806_tracker_subsample = datasample(N0806_tracker,subsample,'Replace',false);
C0114pH4_tracker_subsample = datasample(C0114pH4_tracker,subsample,'Replace',false);
C0217pH4_tracker_subsample = datasample(C0217pH4_tracker,subsample,'Replace',false);

%%Export data to RStudio to do plots and statistical tests, in the Github,
%%this is exported as: "/figures/droplet.tracker.txt"
tracker = [C0114_tracker_subsample N0114_tracker_subsample C0217_tracker_subsample N0217_tracker_subsample C0506_tracker_subsample N0506_tracker_subsample C0806_tracker_subsample N0806_tracker_subsample C0114pH4_tracker_subsample C0217pH4_tracker_subsample];