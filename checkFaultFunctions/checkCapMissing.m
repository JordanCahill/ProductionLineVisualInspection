function capMissing = checkCapMissing(image)
% CHECKCAPMISSING Extracts the top-middle section of the image and 
% applies thresholding to obtain a binary image. The percentage of black 
% pixels is calculated and if lower than 10%, the image is marked as having
% a missing bottlecap 

    % Convert to greyscale
    image = rgb2gray(image);
    
    % Extract the relevant section of the image
    capImage = cropImage(image, 150, 1,  230, 60);
    
    % Convert to binary image, threshold obtained using imhist()
    capBinary = imbinarize(capImage, double(130/255));
    
    % Calculate the percentage of black pixels (=0) in the image
    blackPixels = sum(capBinary(:)==0);
    totalPixels = numel(capBinary(:));
    percentage = 100*(blackPixels/totalPixels);
    
    % Cap missing if % black pixels < 10%
    capMissing = percentage < 10;
end

