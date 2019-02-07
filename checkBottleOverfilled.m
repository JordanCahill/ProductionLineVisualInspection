function bottleOverfilled = checkBottleOverfilled(image)
% CHECKBOTTLEOVERFILLED Extracts the section of the image just below 
% the ideal liquid level and applies thresholding to obtain a binary image. 
% The percentage of black pixels is calculated and if >45%, the 
% image is marked as overfilled

    % Convert to greyscale
    image = rgb2gray(image);
    
    % Extract the relevant section of the image
    labelImage = cropImage(image, 145, 110,  215, 142);
    
    % Convert to binary image, threshold obtained using imhist()
    imageBinary = imbinarize(labelImage, double(160/255));
    
    % Calculate the percentage of black pixels (=0) in the image
    blackPixels = sum(imageBinary(:)==0);
    totalPixels = numel(imageBinary(:));
    percentage = 100*(blackPixels/totalPixels);
    
    % Overfilled if % black pixels >45%
    bottleOverfilled = percentage > 45;
end

