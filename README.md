# Landslide-Susceptibility-Mapping-using-Machine-Learning-MATLAB-Excellence-in-Innovation
This repository is for the MATLAB Excellence in Innovation Project on Landslide Susceptibility Mapping using Machine Learning

## Aim
The aim of this project is to develop MATLAB-based method for generating the Landslide Susceptibility Mapping of an area using the distribution maps of other geographical factors and cascade neural networks. 

## Introduction and Brief Overview
The data of the distribution of various geographical parameters such as slope, aspect, plan curvature, spi, twi, elevation, distance from fault, distance from rivers, distance from roads, rainfall, ndvi, soil type was used in this model as inputs. The target was map of the history of landslides occurring in that area. The cascade feed forward neural network was trained based on this and the model was used for generation of the landslide susceptibility map of the area.

## Detailed Methodology
### Data Collection
- The first step in the project was of obtaining the data. The data of the distribution of geographical parameters was downloaded as maps from [Bhukosh](https://bhukosh.gsi.gov.in/Bhukosh/Public) in the raster format. The parameters uder consideration include slope, aspect, plan curvature, spi, twi, elevation, distance from fault, distance from rivers, distance from roads, rainfall, ndvi, soil type apart from the data of the history of landslides occurring in that area. These files were obtained in the .jpg format (raster file format). 

![Dataset](https://github.com/JaidevSK/Landslide-Susceptibility-Mapping-using-Machine-Learning-MATLAB-Excellence-in-Innovation-Project/blob/main/Dataset.webp?raw=true)


![Dataset Historical](https://github.com/JaidevSK/Landslide-Susceptibility-Mapping-using-Machine-Learning-MATLAB-Excellence-in-Innovation-Project/blob/main/dataset1_historical.webp?raw=true)

### Data Preprocessing

- The next step was to identify the region of interest in the map. **This was done by a very innovative technique.** I used the image processing toolbox for this purpose. The image segmenter application was used for segmenting the Region of Interest using the Draw ROI option. Once this was done, the function was exported as *segmentimage1.m*.

- Once we had this function, the *masked images* corresponding to our Region of Interest **ROI** were obtained for all the images. This was a very clever way of restricting our analysis only to our own region of interest in the map and we can successfully ignore the regions that we are not considering.

- The next task was to obtain the data points. For this, first of all, the indices of the raster file belonging to our Region of Interest were obtained by finding the non-zero indices in the BW mask obtained from the segmentation function. Then, a number of indices were chosen from these obtained indices randomly as the training data points.

- At these indices as obtained for the purpose of training, the array of values of the parameters at those data points were combined and stored as a matrix. This matrix was also later stored as .csv file for preserving the obtained data for further use. In the similar way, the data on historical landslides was also stored as .csv file to serve as target for the purpose of training the model.

### Model Architecture and Training

- A cascade forward neural network was used for this project. The model has 36 input parameters (each corresponding to the R, G, and B values of the obtained data points of the 12 input parameters). The model had 78 hidden units and the output had 3 parameters, each corresponding to the R, G and B values of the pixel under consideration. The colour encoding scheme of the landslide susceptibility is the same as that of the map of the historical landslides.

![Model](https://github.com/JaidevSK/Landslide-Susceptibility-Mapping-using-Machine-Learning-MATLAB-Excellence-in-Innovation-Project/blob/main/Model%20Architecture.png?raw=true)

- The model was trained with the training parameters as follows:

Training Param  | Value
--------------- | ---------------
No. of Epochs   | 40
Learning Rate   | 0.01
MaxValidChecks  | 6
Momentum        | 0.1

The weight of the trained model was saved later as a .mat file.

### Prediction and Susceptibility Mapping
The indices corresponding to the region of interest as obtained earlier were used to obtain the data of all the input parameters for all the data points in our Region of Interest. Then the model was was used to predict the landslide susceptibility at those points. Then the obtained values at these points were plotted to obtain the landslide susceptibility of all the region under consideration. This was the result.

![Result](https://github.com/JaidevSK/Landslide-Susceptibility-Mapping-using-Machine-Learning-MATLAB-Excellence-in-Innovation-Project/blob/main/landslide%20mapping.jpg?raw=true)
## How to use this Code

## Novelty of this Method

## Credits and References

## License

[MIT](https://choosealicense.com/licenses/mit/)
