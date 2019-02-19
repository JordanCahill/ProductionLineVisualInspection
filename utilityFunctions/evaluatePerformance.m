function evaluatePerformance(correctDetections, incorrectDetections, numImages)
% EVALUATEPERFORMANCE Evaluates and prints the performance of the script to
% the console in the form of overall accuracy, correct vs incorrect
% hypotheses (True positive, false negative, etc..) and prints the names of
% the incorrectly processed images
%     correctDetections: number of correctly processed images
%     incorrectDetections: list of incorrectly processed images, and
%       whether it was a FN, FP or TN
%     numImages: the total number of images

TN=0; FN=0; FP=0;

% Count number of FN,FP,TN
for i = 1:length(incorrectDetections);
    if strfind(incorrectDetections{i}, 'False Positive')
        FP = FP + 1;
    elseif strfind(incorrectDetections{i}, 'False Negative')
        FN = FN + 1;
    elseif strfind(incorrectDetections{i}, 'True Negative')
        TN = TN + 1;
    end
end

fprintf('\nTrue Positives: %d', correctDetections);
fprintf('\nTrue Negatives: %d', TN);
fprintf('\nFalse Positives: %d', FP);
fprintf('\nFalse Negatives: %d\n', FN);

accuracy = (correctDetections/numImages)*100;

fprintf('\nTotal Accuracy: %.2f%%\n', accuracy);
fprintf('\nIncorrectly Processed images:\n');
disp(incorrectDetections);

end

