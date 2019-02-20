clearvars; close all; clc;

% Allow Matlab to access functions in subdirectories 
addpath(genpath(pwd));

imageDir = chooseFolder(); % Allow the user to choose which folder to process

[~,~,truth] = xlsread('groundTruth.csv');

allImages = dir(fullfile(imageDir,'*.jpg'));       % Get all image files in a struct

correctDetections = 0; incorrectDetections = {};
groundTruthIndex = 2;

for i = 1:length(allImages)   % Iterate through each image
    
    imageName = allImages(i).name;                  % Store the name of the current image
    message = strcat(imageName,': ');  
    image=imread(fullfile(imageDir, imageName));        % Read the pixelwise content of each image

    numFaults=0; % Track number of faults in image
    
    if checkBottleMissing(image) % Don't need to check faults if no image
        message = strcat(message,' No faults detected (No bottle)\n');  
    else
        
        % If bottle present, check individually for each fault
        
        if checkBottleUnderfilled(image)
            message = strcat(message,' Bottle underfilled, '); 
            numFaults=numFaults+1;
        end
        
        if checkBottleDeformed(image)
            message = strcat(message,' Bottle deformed, '); 
            numFaults=numFaults+1; 
       
        elseif checkBottleOverfilled(image) % Don't count overfill if bottle is deformed
            message = strcat(message,' Bottle overfilled, '); 
            numFaults=numFaults+1;
        end
        
        if checkLabelMissing(image)
            message = strcat(message,' Label missing, '); 
            numFaults=numFaults+1;
            
        elseif checkLabelNotPrinted(image) % No need to check if no label
            message = strcat(message,' Label not printed, '); 
            numFaults=numFaults+1;
            
        elseif checkLabelNotStraight(image) % No need to check if no label
            message = strcat(message,' Label not straight, '); 
            numFaults=numFaults+1;
        end
        
        if checkCapMissing(image)
            message = strcat(message,' Bottlecap missing, '); 
            numFaults=numFaults+1;
        end

        if numFaults == 0;
            message = strcat(message,' No faults detected\n');
        else  
            % Tidy up print messages
            message = message(1:end-1);
            message = strcat(message,'\n');
        end
    end
    
    if strcmpi(imageDir,'.\Pictures\All')
        % Call on evaluateDecision() to return the hypothesis result (FP, TN,
        % etc.) and a 1 if bottle was processed correctly, 0 if not. 
        % Also store the names of incorrectly processed images
        [hypothesis, predictionResult] = evaluateDecision(message, truth(groundTruthIndex,:));
        if predictionResult == 1
            correctDetections = correctDetections + 1;
        else
            incorrectDetections{end+1} = [imageName,': ', hypothesis];
        end
        groundTruthIndex = groundTruthIndex + 1;
    end
    
    fprintf(message);

end

if strcmpi(imageDir, '.\Pictures\All')
    numImages = length(allImages);
    evaluatePerformance(correctDetections, incorrectDetections, numImages);
end
