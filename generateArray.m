% Get the size of the image
function[rgbArray] = generateArray(image, rowArray, colArray)
[rows, cols, ~] = size(image);
% Initialize the array to store RGB values
rgbArray = zeros(length(rowArray), 3);

% Iterate over the specified pixel locations
for i = 1:length(rowArray)
    % Check if the pixel location is within the image boundaries
    if rowArray(i) <= rows && colArray(i) <= cols
        % Get the RGB values at the specified pixel location
        rgbArray(i, :) = image(rowArray(i), colArray(i), :);
    else
        % Handle out-of-bounds pixel locations
        fprintf('Pixel location (%d, %d) is out of bounds.\n', rowArray(i), colArray(i));
    end
end
