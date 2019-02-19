function bottleDeformed = checkBottleDeformed(image)
% CHECKBOTTLEDEFORMED Uses connected components to find the largest 
% bounding box in the image i.e. the bottle's body, and asserts if the
% bounding boxes area, width and height fall under specific limits

    % Extract red channel and apply contrast adjustment
    imgR = image(:, :, 1);
    %imgR = imadjust(imgR);
    
    % Crop image to label area
    labelImageR = cropImage(imgR, 100, 190, 260, 280);
    
    % Convert to binary image, threshold obtained using imhist()
    labelBinary = imbinarize(labelImageR, double(200/256));

    % Find connected components and get the bounding box properties for each
    cc = bwconncomp(labelBinary, 4);
    properties = regionprops(cc, 'BoundingBox');
    
    maxArea = 0; BoxWidth = 0; BoxHeight = 0;
   
    % Iterate through each bounding box 
    for i = 1 : length(properties)
        BB = properties(i).BoundingBox;
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

