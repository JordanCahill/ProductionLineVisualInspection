function labelNotPrinted = checkLabelNotPrinted(image)
% CHECKLABELNOTPRINTED Extracts the section of the image surrounding the 
% label and applies thresholding to obtain a binary image. The percentage of black 
% pixels is calculated and if >50%, the image is marked as the label not
% having printed correctly

    % Convert to greyscale
    image = rgb2gray(image);
    
    % Extract the relevant section of the image
    labelImage = cropImage(image, 115, 175,  240, 280);

    % Convert to binary image, threshold obtained using imhist()
    labelBinary = imbinarize(labelImage, double(150/255));
    
    % Calculate the percentage of black pixels (=0) in the image
    blackPixels = sum(labelBinary(:)==0);
    totalPixels = numel(labelBinary(:));
    percentage = 100*(blackPixels/totalPixels);
    
    % Label not printed if % black pixels <50%
    labelNotPrinted = percentage < 50;
end
