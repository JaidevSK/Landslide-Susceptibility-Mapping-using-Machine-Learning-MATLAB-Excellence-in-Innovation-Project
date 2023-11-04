clc;
close all;
clear all;

% Put the links to the files
slope_file = "Dataset\slope.jpg";
aspect_file = "Dataset\aspect.jpg";
pCurvature_file = "Dataset\pCurvature.jpg";
elevation_file = "Dataset\elevation.jpg";
spi_file = "Dataset\spi.jpg";
twi_file = "Dataset\twi.jpg";
faultd_file = "Dataset\dFault.jpg";
riverd_file = "Dataset\dRivers.jpg";
roadd_file = "Dataset\dRoads.jpg";
rain_file = "Dataset\rain.jpg";
ndvi_file = "Dataset\ndvi.jpg";
soil_file = "Dataset\soil.jpg";
history_file = "Dataset\dataset1result.jpg";
N1 = 2500; %The number of training samples

%% Loading the data for the landslide susceptibility parameters in .jpg format and then cropping the region of interest
slope=imread(slope_file);
[BW_slope,maskedImage_slope] = segmentImage(slope);
figure()
imshow(maskedImage_slope)
title("Slope")
imwrite(maskedImage_slope,"Dataset in Region of Interest/slope.jpg")

aspect=imread(aspect_file);
[BW_aspect,maskedImage_aspect] = segmentImage(aspect);
figure()
imshow(maskedImage_aspect)
title("Aspect")
imwrite(maskedImage_aspect,"Dataset in Region of Interest/aspect.jpg")


pCurvature=imread(pCurvature_file);
[BW_pCurvature,maskedImage_pCurvature] = segmentImage(pCurvature);
figure()
imshow(maskedImage_pCurvature)
title("Plan Curvature")
imwrite(maskedImage_pCurvature,"Dataset in Region of Interest/plancurve.jpg")



elevation=imread(elevation_file);
[BW_elevation,maskedImage_elevation] = segmentImage(elevation);
figure()
imshow(maskedImage_elevation)
title("Elevation")
imwrite(maskedImage_elevation,"Dataset in Region of Interest/elevation.jpg")


spi=imread(spi_file);
[BW_spi,maskedImage_spi] = segmentImage(spi);
figure()
imshow(maskedImage_spi)
title("SPI")
imwrite(maskedImage_spi,"Dataset in Region of Interest/spi.jpg")


twi=imread(twi_file);
[BW_twi,maskedImage_twi] = segmentImage(twi);
figure()
imshow(maskedImage_twi)
title("TWI")
imwrite(maskedImage_twi,"Dataset in Region of Interest/twi.jpg")

faultd=imread(faultd_file);
[BW_faultd,maskedImage_faultd] = segmentImage(faultd);
figure()
imshow(maskedImage_faultd)
title("Distance from Fault")
imwrite(maskedImage_faultd,"Dataset in Region of Interest/distfault.jpg")

riverd=imread(riverd_file);
[BW_riverd,maskedImage_riverd] = segmentImage(riverd);
figure()
imshow(maskedImage_riverd)
title("Distance from River")
imwrite(maskedImage_riverd,"Dataset in Region of Interest/distriver.jpg")

roadd=imread(roadd_file);
[BW_roadd,maskedImage_roadd] = segmentImage(roadd);
figure()
imshow(maskedImage_roadd)
title("Distance from Road")
imwrite(maskedImage_roadd,"Dataset in Region of Interest/distroad.jpg")

rain=imread(rain_file);
[BW_rain,maskedImage_rain] = segmentImage(rain);
figure()
imshow(maskedImage_rain)
title("Rainfall")
imwrite(maskedImage_rain,"Dataset in Region of Interest/rainfall.jpg")

ndvi=imread(ndvi_file);
[BW_ndvi,maskedImage_ndvi] = segmentImage(ndvi);
figure()
imshow(maskedImage_ndvi)
title("NDVI")
imwrite(maskedImage_ndvi,"Dataset in Region of Interest/ndvi.jpg")

soil=imread(soil_file);
[BW_soil,maskedImage_soil] = segmentImage(soil);
figure()
imshow(maskedImage_soil)
title("Soil")
imwrite(maskedImage_soil,"Dataset in Region of Interest/soil.jpg")

result=imread(history_file);
[BW_result,maskedImage_result] = segmentImage(result);
figure()
imshow(maskedImage_result)
title("History of Landslides")
imwrite(maskedImage_result,"Dataset in Region of Interest/landslidehistory.jpg")

% Find the indices of the datapoints that belong to the region of interest
ROIindices = find(BW_result == 1);
%% Select N1 random points from the roi
randomIndices = ROIindices(randperm(length(ROIindices), N1));

% Convert the linear indices to subscripts
[row, col] = ind2sub(size(maskedImage_result), randomIndices);

% Store the indices as arrays
rowArray = row';
colArray = col';

% obtaining the data from the given random indices for the following
% parameters and storing them as arrays
rainArr = generateArray(maskedImage_rain, rowArray, colArray);
twiArr = generateArray(maskedImage_twi, rowArray, colArray);
soilArr = generateArray(maskedImage_soil, rowArray, colArray);
ndviArr = generateArray(maskedImage_ndvi, rowArray, colArray);
slopeArr = generateArray(maskedImage_slope, rowArray, colArray);
roaddArr = generateArray(maskedImage_roadd, rowArray, colArray);
ls_historyArr = generateArray(maskedImage_result, rowArray, colArray);
aspectArr = generateArray(maskedImage_aspect, rowArray, colArray);
elevationArr = generateArray(maskedImage_elevation, rowArray, colArray);
spiArr = generateArray(maskedImage_spi, rowArray, colArray);
pCurvatureArr = generateArray(maskedImage_pCurvature, rowArray, colArray);
riverdArr = generateArray(maskedImage_riverd, rowArray, colArray);
faultdArr = generateArray(maskedImage_faultd, rowArray, colArray);

% Concatenate the arrays
concatenatedArray1 = horzcat(rainArr,twiArr,soilArr,ndviArr,slopeArr,roaddArr,aspectArr,elevationArr,spiArr,pCurvatureArr,riverdArr,faultdArr);
concatenatedArray2 = ls_historyArr;




%% Saving the data as .csv files for future use
writematrix(concatenatedArray1,'csv Dataset/trainDATA1.csv');
writematrix(concatenatedArray2,'csv Dataset/trainLABELS1.csv');

%% Loading the data from csv file as x(input values) and t(target)
x = readmatrix('csv Dataset/trainDATA1.csv');
t = readmatrix('csv Dataset/trainLABELS1.csv');

% Create the neural network
net = cascadeforwardnet(24);

% Set the training parameters
net.trainParam.epochs = 40;
net.trainParam.lr = 0.01;
net.trainParam.max_fail = 6;
net.trainParam.mc = 0.1;


%% Train the neural network
net = train(net, rot90(x), rot90(t));
view(net)

% Predict the results
outputs = net(rot90(x));

% Display the performance of the neural network
performance = perform(net, rot90(t), outputs);
disp(['Performance: ', num2str(performance)]);

% Plot the predicted results against the targets
plot(rot90(t));
hold on;
plot(outputs);
legend('Targets', 'Outputs');
xlabel('Sample');
ylabel('Value');
title('Predicted Results');

% Save the trained neural network
save('results/trained_network.mat', 'net');


%% Finding all the indies that belong to our Region of Interest

ROIindices = find(BW_result == 1);

% Convert the linear indices to subscripts
[row, col] = ind2sub(size(maskedImage_result), ROIindices);

% Store the indices as arrays
rowArray = row';
colArray = col';

%% Obtaining the parameter values at those indices
rainArr = generateArray(maskedImage_rain, rowArray, colArray);
twiArr = generateArray(maskedImage_twi, rowArray, colArray);
soilArr = generateArray(maskedImage_soil, rowArray, colArray);
ndviArr = generateArray(maskedImage_ndvi, rowArray, colArray);
slopeArr = generateArray(maskedImage_slope, rowArray, colArray);
roaddArr = generateArray(maskedImage_roadd, rowArray, colArray);
aspectArr = generateArray(maskedImage_aspect, rowArray, colArray);
elevationArr = generateArray(maskedImage_elevation, rowArray, colArray);
spiArr = generateArray(maskedImage_spi, rowArray, colArray);
pCurvatureArr = generateArray(maskedImage_pCurvature, rowArray, colArray);
riverdArr = generateArray(maskedImage_riverd, rowArray, colArray);
faultdArr = generateArray(maskedImage_faultd, rowArray, colArray);

% Concatenate the arrays
concatenatedArray1 = horzcat(rainArr,twiArr,soilArr,ndviArr,slopeArr,roaddArr,aspectArr,elevationArr,spiArr,pCurvatureArr,riverdArr,faultdArr);

% Storing the concatenated array containing the parameter values at all the
% datapoints in the Region of Interest as .csv for future use
writematrix(concatenatedArray1,'csv Dataset/finalDATA.csv');

%% Reading the values out of final data and making the predictions
x = readmatrix('csv Dataset/finalDATA.csv');
outputs_for_image = net(rot90(x));

%% Creating an empty image with the required size for storing the predictions
[r, c, ~] = size(maskedImage_result);
empty_image = zeros(size(maskedImage_result));

% Storing the predictions of the points of the Region of Interest at their
% specific locations
[a, b] = size(concatenatedArray1(:,1));
maximg = max(max(outputs_for_image));

for i=1:a
    % alu = reshape(centers(roundof(outputs_for_image(:, i)),:), [1,1,3]);
    empty_image(rowArray(i), colArray(i),:) = outputs_for_image(:, i);
end
figure()
imshow(empty_image/255)
title("Landslide Mapping")
imwrite(empty_image,"results/landslide mapping.jpg")
