# Skinskan
Sacramento Health AI Hackathon Project - Consumer Skin Cancer Recognition App

By Rithwik Sudharsan, Edison Li, Alex Fung, Mario Ishhe, and Huzaifa Ahmad

The model architecture is given in Keras .json format. The model weights are given in Keras .h5 format.

Code for the model training can be found in the .ipynb. 

We used the following for the model:
- 28x28 RGB image training data mostly for faster training time and less variation in imaging.
- Standard LeNet CNN 
- 4 Outputs: Melanoma (Malignant/Benign) and Keratosis (Malignant/Benign). 

These were chosen for purposes as outlined by this landmark Stanford research project, https://cs.stanford.edu/people/esteva/nature/. 

--> Keratosis is the most common type of skin lesion, and Melanoma is the most deadly type of skin lesion. Thus, these are the two most important to classify for information on identifying the lesion. 

The Stanford research paper had 55.4 ±  1.7% CNN accuracy (trained with Inception v3) and is meant for clinical use, trained on the dataset we used by also tens of thousands of Stanford Hospital data and other paid academic data for a total of ~130,000 training images. They cited that "two dermatologists attain 65.56% and 66.0% accuracy on a subset of the validation set." 

All the training data is from dermatoscope imaging. Thus, our project is meant for non-clinical use but for individuals who notice a lesion and would like a quick yet accurate diagnosis via dermatoscope attachment to smartphone either for personal use or for one-time use at local pharmacies such as a CVS. While the model can run on normal close-up smartphone images, lighting will be nonideal and the image may be blurry, providing less accurate results. There are other applications in smartphone app stores that focus on this more layman imaging.


The file labelled AIHACKATHON2019 has the iOS app.
##  To convert the Keras model into CoreML:
Run ToCoreML.ipynb and upload your Keras model.

## Running the app
**Note: The project was created using Xcode and requires Xcode, an apple developer profile and an iPhone to run.**


* Open the “AI Hackathon 2019.xcworkspace” file (the white file).

* You will then be prompted to the Xcode project. 

* Before we get started you’ll have sign in as a developer in the “Signing” section which can be found in the project settings.

* You’ll also have to change the bundle identifier to something different 

* Now connect your iPhone using a lightning cable to your Mac and run 

* Verify the app on your iPhone if asked (Apple and its privacy ;( )

* Upon running the app you will be greeted with two introductory screens. Swipe through and click “Get Started”

* Scan your skin and the application will print its predictions in the debug log

* The application returns an array of predictions for Actinic Keratosis positive, actinic Keratosis negative, melanoma positive,  melanoma negative, respectively.

**An iPhone should be used because the application requires a camera to run**

## Screenshots

  <img src= "https://github.com/ahmadhuzaifa/skinskan/blob/master/images/1.PNG">
  <img src= "https://github.com/ahmadhuzaifa/skinskan/blob/master/images/2.PNG">
  <img src= "https://github.com/ahmadhuzaifa/skinskan/blob/master/images/3.PNG">
  <img src= "https://github.com/ahmadhuzaifa/skinskan/blob/master/images/4.PNG">



