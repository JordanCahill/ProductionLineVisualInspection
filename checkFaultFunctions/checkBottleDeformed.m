function bottleDeformed = checkBottleDeformed(image)
% CHECKBOTTLEDEFORMED Uses connected components to find the largest 
% bounding box in the image i.e. the bottle's body, and asserts if the
% bounding boxes area, width and height fall under specific limits
% If the bottle contains a label, the Red channel is extracted and
% binarized to obtain the components. If the label is missing, the
% grayscale image is binarized instead.

    % Crop image to label area
    croppedImg = cropImage(image, 100, 190, 260, 280);

    % Extract red channel
    imgRed = croppedImg(:, :, 1);
   
    % Convert to binary image, threshold obtained using imhist()
    labelBinRed = imbinarize(imgRed, double(200/256));
    
    % Calculate the percentage of black pixels (=0) in the image
    blackPixels = sum(labelBinRed(:)==0);
    totalPixels = numel(labelBinRed(:));
    percentage = 100*(blackPixels/totalPixels);
    
    % if the percentage of black pixels >80%, image has no label and is
    % converted to grayscale to be binarized
    if percentage > 80
        mask = rgb2gray(croppedImg);
        labelBinGS = imbinarize(mask, double(5/256));
        
        % Find connected components and get the bounding box properties for each
        cc = bwconncomp(labelBinGS, 4);
        
    else % otherwise, the red channel is used
        % Find connected components and get the bounding box properties for each
        cc = bwconncomp(labelBinRed, 4);
    end

    propertiesTotal = regionprops(cc, 'BoundingBox');
    
    maxArea = 0; BoxWidth = 0; BoxHeight = 0;
   
    % Iterate through each bounding box 
    for i = 1 : length(propertiesTotal)
        BB = propertiesTotal(i).BoundingBox;
        BBArea = BB(3)*BB(4);
        
        % Find the bounding box with the largest area and the corresponding
        % height and width
        if BBArea > maxArea
            maxArea = BBArea;
            BoxWidth = BB(3);
            BoxHeight = BB(4);
        end
    end
    
    % Check results against limits
    maxAreaResult = (maxArea >= 9800) && (maxArea <= 12000);
    maxBoxWidthResult = (BoxWidth >= 110) && (BoxWidth <= 130);
    maxBoxHeightResult = (BoxHeight >= 80) && (BoxHeight <= 100);
      
    % Check each result is true, if not, bottle is deformed
    bottleDeformed = ~(maxAreaResult && maxBoxWidthResult && maxBoxHeightResult);
    
end

