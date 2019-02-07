function bottleUnderfilled = checkBottleUnderfilled(image)
% CHECKBOTTLEUNDERFILLED Extracts the section of the image just above
% the ideal liquid level and applies thresholding to obtain a binary image. 
% The percentage of black pixels is calculated and if lower than 10%, the 
% image is marked as underfilled

    % Convert to greyscale
    image = rgb2gray(image);
    
    % Extract the relevant section of the image
    label = cropImage(image, 140, 110, 225, 160);
    
    % Convert to binary image, threshold obtained using imhist()
    labelBinary = imbinarize(label, double(170/255));
    
    % Calculate the percentage of black pixels (=0) in the image
    blackPixels = sum(labelBinary(:)==0);
    totalPixels = numel(labelBinary(:));
    percentage = 100*(blackPixels/totalPixels);
    
    % Underfilled if % black pixels <10%
    bottleUnderfilled = percentage < 10;
end


