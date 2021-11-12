clc
close all
clear all
%% Part A
%% READ THE IMAGE
Image = im2double(imread('Image.tif'));

%% FINDING ADAPTHHISTIQUE 

Image = adapthisteq(Image);% to increse the contrast
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

% 1) Complement the Image
BW = ~BW;% to make the Nuclei visible(Logically give value 1 to Nuclei)
%2) Fill the holes first
BW = imfill(BW,'holes');% Some of the pixels are still off(Logical Value 0 ) inside the object, 
%SO make that pixels on(Logical 1) through matlab function imfill
figure(2)
subplot(2,3,1)
imshow(BW)
title('Morphological Filling  Opertaion')
axis square
% 3) Morphological Opening Operation
se = strel('disk',4);% Making a circular window with the radius 5.
Io = imopen(BW,se);%  remove all the pixels which are not onn in the circular radius 5
subplot(2,3,2)
imshow(Io)
title('Morphological Opening Operation')
axis square
% 4) Morphological Operation to remove small objects
Io = bwareaopen(Io, 100);% removes all Pixels which have  fewer than 100 pixels
subplot(2,3,3)
imshow(Io)
title('Morphological operation to remove small objects')
axis square
% 5) Distance transform Operations
C = -bwdist(~Io);% Image complement is done to get accurate BW mask logical operations
%  6) Doing watershad
D = watershed(C);
% 7) Placing the all zero value from waterheded Image to Original Image
Io(D == 0) = 0;
subplot(2,3,4)
Mask_Image = Image.*Io;% to see the detetced Nuclei
imshow(Mask_Image)
title('Detected Nuclei Image')
axis square
% 8) Morphological erosion Operation
se = strel('disk',5);
SD = imerode(Io,se);% erode the image to detect the signle Nuclei in a single point
% 9) Morphological Ultimate erosion Operation
G = bwulterode(SD);
% 10) mOrphological Dilation operation to make that point larger
ASD = imdilate(G,strel('disk',2));
subplot(2,3,5)
imshow(ASD)
title('Detected Nuclei')
axis square
H = imoverlay(Image,ASD);% Overlay the Image
subplot(2,3,6)
imshow(H)
title('Overlayed Image of Nuclei detection')
axis square
% Finding the number of Nuclei
[labeledImage, numberOfBlobs] = bwlabel(ASD);% finding the number of Nuclei.


%% Part B
 
n = input('Enter Nuclei Distance Threshold Value : ');% User input for thresholding how much far Nuclei  
distance = bwdist(ASD);% finding distance transform matrix
distance = double(distance);% make the double precision
 
new_distance = distance < n;% threshold the value below user input threshold
figure(3)
imshow(new_distance)% plot the figure
title('Thresholded Nuclei Detection')
[labeledImage1, numberOfBlobs1] = bwlabel(new_distance);% finding ghe nuclei.



