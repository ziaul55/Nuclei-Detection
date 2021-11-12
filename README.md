# Nuclei-Detection

Step 1: Read the Image and convert it into double precision.
Step 2: The MATLAB function adapthisteq is used to enhance the contrast between nuclei and background. (To make nuclei more darker and background brighter)
Step 3: Plot the contrast enhanced image.
Step 4: The MATLAB function graythresh is used to find the global threshold of the image. That will eliminate most of the background. This function is working based on Otsu’s thresholding algorithm. And then binaries the image with the MATLAB function imbinarize using the threshold value.
Step 5: From this step, the morphological operation will start. Complement the threshold Image, so we can highlight the nuclei. To highlight some of the portion of the nuclei we need to use the matlab function imfill to fill all the holes inside the nuclei.
Step 6: Following morphological operations, we used imopen MATLAB function. That will do erosion following by dilation and remove all the small unnecessary object from the background and finally clean the boundaries.
Step 7: We eliminate small object in the image that are not the nuclei by using bwareaopen matlab function. Here we have used the function such that it will eliminate all the area which are containing at list 100 pixels.
Step 8: We used watershading to detect region of the nuclei. For this bwdist matlab function (finding the distance transform binary image) is used followed by the watershad function. Then from the distance transform binary Image, whatever value in this matrix has zero which helps to discriminate the edge between 2 overlapping nuclei and segment the overlapped nuclei.
Step 9: We considered erosion to make that nuclei smaller with the matlab function bwulterode(to detect this nuclei at 1 point) and dilation (to make that point bigger so it can be easily visible). This step helps to count the individual nuclei.
Step 11: For task 2, we need to find the nuclei which are further than n pixels away from the nearest nuclei. For this first we consider user input to set the distance threshold. And find the pixel distance with the direct matlab function bwdist on the mask. In this context, the user will set the threshold distance, (all the threshold distance value might be zero as consideration). Then using bwlabel matlab function we can find the number of nuclei which are away from threshold distance. 
