## Introduction 
Demonstrating how image processing can be used for an automated visual inspection application using a set of images from a coca-cola production line as an example scenario.

The program makes the following assumptions:

* Near-constant factory lighting conditions
* Consistent bottle positioning
* Only faults in the centre bottle are required to be detected
* A missing centre bottle is not considered a fault, it is simply ignored
* The folder to be processed is a direct child of '.\Pictures\' (Example folders have been included for testing purposes)

#### Faults:
The list of faults that are to be detected are:

* Bottle Cap Missing
* Bottle Deformed
* Bottle Overfilled
* Bottle Underfilled
* Label Missing
* Label Not Printed
* Label Not Straight

Note: A bottle is not considered overfilled if the bottle is deformed as the overfilling is most likely due to the deformity. It will still be flagged as faulty regardless.

---

## Results

Results are based on the included 'All' folder consisting of 141 images, including bottles with single faults, multiple faults, and no faults.

Folder | Number of Images | Correctly Identified | Accuracy
------------ | ------------- | ------------ | -------------
All | 141 | 136 | 96.45%