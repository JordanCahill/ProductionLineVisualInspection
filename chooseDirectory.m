function imageDir = chooseDirectory()
% CHOOSEDIRECTORY Allows the user to choose the folder to process
%                 Note: Must be under '.\Pictures\*'

fprintf('Choose one of the following folders to process:\n(Type exactly as it appears, case insensitive)\n\n');

d = dir('.\Pictures\');
isub = [d(:).isdir]; %# returns logical vector
subfolders = {d(isub).name}';
subfolders(ismember(subfolders,{'.','..'})) = []; % Remove '.' and '..'

for i = 1:length(subfolders)
    disp(subfolders{i});
end

folder = input('\nName of Folder: ', 's');

imageDir = strcat('.\Pictures\', folder);  % Store directory of 'All' folder

if ~isdir(imageDir)  % Check folder exists
    warning('[Error reading images]: Folder does not exist: %s\n Did you type it correctly?\n', imageDir);
    imageDir = chooseDirectory();
end

fprintf('\n');

end

