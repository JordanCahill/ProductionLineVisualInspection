function [hypothesis, correct] = evaluateDecision(message, truth)
% EVALUATE DECISION Compares the decision made by the script with the
% ground truth by comparing the output message of a specific bottle to the
% corresponding tuple in the ground truth cell
%     message: Output message of the current prediction
%     truth: Tuple taken from the ground truth cell
%     hypothesis: Result hypothesis where:
%           - True Negative: No fault in image && No fault detected
%           - False Negative: Fault in image && No fault detected
%           - True Positive: Fault in image && fault detected
%           - False Positive: (No fault in image && fault detected) OR (wrong
%             fault detected)
%     correct: 1 if detected result corresponds to ground truth, else 0

total = 0;
numCorrect = 0;

for i = 2 : length(truth)
    total = total + truth{i};
end

if strfind(message, 'No bottle')
    if truth{3} == 1
        numCorrect=numCorrect+1;
        hypothesis = 'True Negative';
    else
        hypothesis = 'False Negative';
    end

elseif strfind(message, 'No faults detected')
    if truth{2} == 1
        numCorrect=numCorrect+1;
        hypothesis = 'True Negative';
    else
        hypothesis = 'False Negative';
    end
end

if strfind(message, 'underfilled')
    if truth{5} == 1
        numCorrect=numCorrect+1;
        hypothesis = 'True Positive';
    else
        hypothesis = 'False Positive';
    end
end

if strfind(message, 'Bottlecap missing')
    if truth{6} == 1
        numCorrect=numCorrect+1;
        hypothesis = 'True Positive';
    else
        hypothesis = 'False Positive';
    end
end

if strfind(message, 'Label missing')
    if truth{7} == 1
        numCorrect=numCorrect+1;
        hypothesis = 'True Positive';
    else
        hypothesis = 'False Positive';
    end
end

if strfind(message, 'Label not printed')
    if truth{8} == 1
        numCorrect=numCorrect+1;
        hypothesis = 'True Positive';
    else
        hypothesis = 'False Positive';
    end
end

if strfind(message, 'Label not straight')
    if truth{9} == 1
        numCorrect=numCorrect+1;
        hypothesis = 'True Positive';
    else
        hypothesis = 'False Positive';
    end
end

if strfind(message, 'deformed')
    if truth{10} == 1
        numCorrect=numCorrect+1;
        hypothesis = 'True Positive';
    else
        hypothesis = 'False Positive';
    end
    
elseif strfind(message, 'overfilled')
    if truth{4} == 1
        numCorrect=numCorrect+1;
        hypothesis = 'True Positive';
    else
        hypothesis = 'False Positive';
    end
end

if numCorrect == total
    correct = 1;
else
    correct = 0;
end