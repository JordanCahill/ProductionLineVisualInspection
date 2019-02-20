function labelNotStraight = checkLabelNotStraight(image)
% CHECKLABELNOTSTRAIGHT Function divides the task into two cases to evaluate
% if the label is straight:
%    Case 1: As the bottle has already been checked for a missing label, meaning it IS 
%   present on this bottle. This means we can apply another threshold, and if the % 
%   of black pixels is >15%, the label is not straight
%    Case 2: The second case makes use of edge detection to check if the white band is
%   within specific limits. A bounding box is formed around the band, and the height 
%   and width of the bounding box are compared against specific pixel limits. If the 
%   bounding box isn't wide enough or is too long heightwise, the label is not straight.
   
    % Convert to greyscale
    image = rgb2gray(image);
    
    % Case 1: Thresholding    
    % Crop the image and apply threshold obtained using imhist()
    label = cropImage(image, 110, 180, 250, 230);
    labelBinary = imbinarize(label, double(50/256));

    % Calculate percentage of black pixels
    blackPixels = sum(labelBinary(:)==0);
    totalPixels = numel(labelBinary(:));
    percentage = 100*(blackPixels/totalPixels);
    
    % Evaluate result >13%
    thresholdResult = (percentage >= 13);


    % Case 2: Edge Detection
    % Crop the image to the top of the label where the white band should be
    topOfLabel = cropImage(image, 110, 170, 250, 195);

    % Apply the edge detection algorithm
    labelEdges = edge(topOfLabel, 'Canny');

    % Find connected components and get the bounding box properties for each
    cc = bwconncomp(labelEdges);
    properties = regionprops(cc, 'BoundingBox'); 
    maxWidth = 0; maxHeight = 0;
   
    % Iterate through each bounding box
    for i = 1 : length(properties)
        
        boundingBox = properties(i).BoundingBox;
        
        % Calculate the max width of all bounding boxes in region
        if boundingBox(3) > maxWidth
            maxWidth = boundingBox(3);
        end
        
        
        % Calculate the max height of all bounding boxes in region
        if boundingBox(4) > maxHeight
            maxHeight = boundingBox(4);
        end
    end
    
    edgeResult = maxWidth <= 100 || maxHeight >=14;
    
    % Evaluate both results
    labelNotStraight = thresholdResult && edgeResult;
end