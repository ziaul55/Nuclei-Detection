%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Md. Ziaul Hoque, CMVS, ITEE, University of Oulu, Fnland.         %                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
close all
clear all
%% Part A
%% READ THE IMAGE
Image = im2double(imread('Image.tif'));

%% FINDING ADAPTHHISTIQUE 
Image = adapthisteq(Image);
figure(1)
subplot(1,2,1)
imshow(Image)
title('Original Image')
axis square

%% FINDING THRESHOLD VALUE
T = graythresh(Image);
BW = imbinarize(Image,T);
subplot(1,2,2)
imshow(BW)
title('Threshold Image')
axis square

%% MORPHOLOGICAL OPERATIONS
BW = ~BW;
BW = imfill(BW,'holes');
figure(2)
subplot(2,3,1)
imshow(BW)
title('Morphological Filling  Opertaion')
axis square
se = strel('disk',4);
Io = imopen(BW,se);
subplot(2,3,2)
imshow(Io)
title('Morphological Opening Operation')
axis square

Io = bwareaopen(Io, 100);
subplot(2,3,3)
imshow(Io)
title('Morphological operation to remove small objects')
axis square
C = -bwdist(~Io);
D = watershed(C);
Io(D == 0) = 0;
subplot(2,3,4)
Mask_Image = Image.*Io;
imshow(Mask_Image)
title('Detected Nuclei Image')
axis square
se = strel('disk',5);
SD = imerode(Io,se);
G = bwulterode(SD);
ASD = imdilate(G,strel('disk',2));
subplot(2,3,5)
imshow(ASD)
title('Detected Nuclei')
axis square
H = imoverlay(Image,ASD);

%% FINDING THE NUMBER OF NUCLEI
subplot(2,3,6)
imshow(H)
title('Overlayed Image of Nuclei detection')
axis square
[labeledImage, numberOfBlobs] = bwlabel(ASD);
n = input('Enter Nuclei Distance Threshold Value : ');
distance = bwdist(ASD);
distance = double(distance);
new_distance = distance < n;
figure(3)
imshow(new_distance)
title('Thresholded Nuclei Detection')
[labeledImage1, numberOfBlobs1] = bwlabel(new_distance);



