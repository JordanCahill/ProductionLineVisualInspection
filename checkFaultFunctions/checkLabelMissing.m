function labelMissing = checkLabelMissing(image)
% CHECKLABELMISSING Extracts the section of the image surrounding the label
% applies thresholding to obtain a binary image. The percentage of black 
% pixels is calculated and if >50%, the image is marked as having
% a missing label

    % Convert to greyscale
    image = rgb2gray(image);
    
    % Extract the relevant section of the image
    labelImage = cropImage(image, 115, 175,  240, 280);

    % Convert to binary image, threshold obtained using imhist()
    labelBinary = imbinarize(labelImage, double(55/255));
    
    % Calculate the percentage of black pixels (=0) in the image
    blackPixels = sum(labelBinary(:)==0);
    totalPixels = numel(labelBinary(:));
    percentage = 100*(blackPixels/totalPixels);
    
    % Label missing if % black pixels >50%
    labelMissing = percentage > 50;
end

