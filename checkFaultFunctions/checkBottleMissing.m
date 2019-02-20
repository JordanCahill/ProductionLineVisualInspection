function bottleMissing = checkBottleMissing(image)
% CHECKBOTTLEMISSING Extracts the middle section of the image and applies
% thresholding to obtain a binary image. The percentage of black pixels 
% is calculated and if lower than 10%, the image is marked as having a 
% missing bottle 

    % Convert to greyscale
    image = rgb2gray(image);
    
    % Extract the middle section of the image
    imageCenter = cropImage(image, 110, 1,  240, 280);
    
    % Convert to binary image, threshold obtained using imhist()
    imageBinary = imbinarize(imageCenter, double(150/255));
    
    % Calculate the percentage of black pixels (value=0) in the image
    blackPixels = sum(imageBinary(:)==0);
    totalPixels = numel(imageBinary(:));
    percentage = 100*(blackPixels/totalPixels);
    
    % Bottle missing if the % black pixels < 10%
    bottleMissing = percentage < 10;
end

