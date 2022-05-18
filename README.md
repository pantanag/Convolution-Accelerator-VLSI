# Convolution Accelerator VLSI
Optional Project for the course VLSI in the 8th semester of University. The purpose behind it was to build a project in system verilog that applies a convolution of a specific filter to an image. Currently only positive (all the numbers of the filter) filters are supported. There are two versions, one without pipeline and one with. 
Every version corresponds to one folder which has the following directories/files:
* Correct Images: Folder containing the expected results (made with matlab)
* Filtered Images: The results made by the current project
* Images: Folder containg the images we used for the results
* Testbenches: To make sure the modules work
* work: Folder library made by ModelSim software
* sv Files: Modules of the project, made in System Verilog
