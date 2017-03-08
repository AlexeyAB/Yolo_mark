# Yolo_mark
**Windows** & **Linux** GUI for marking bounded boxes of objects in images for training Yolo v2

* To compile on **Windows** open in MSVS2013/2015 `yolo_mark.sln`, compile it and run the file: `x64/Release/yolo_mark.cmd` (if your  version other than OpenCV 2.4.9 - change version number in 3 lines by [this link] (https://github.com/AlexeyAB/Yolo_mark/blob/746e590b106080dbb3d205dd453b2fcea5e880a3/main.cpp#L1) )

* To compile on **Linux** type in console 3 commands:
    ```
    cmake .
    make
    ./linux_mark.sh
    ```

--------

1. To test, simply run 
  * on Windows: `x64/Release/yolo_mark.cmd`
  * on Linux `./linux_mark.sh`

2. To use for labeling your custom images:

 * delete all files from directory `x64/Release/data/img`
 * put your `.jpg`-images to this directory `x64/Release/data/img`
 * change numer of classes (objects for detection) in file `x64/Release/data/obj.data`: https://github.com/AlexeyAB/Yolo_mark/blob/master/x64/Release/data/obj.data#L1
 * put names of objects, one for each line in file `x64/Release/data/obj.names`: https://github.com/AlexeyAB/Yolo_mark/blob/master/x64/Release/data/obj.names
 * run file: `x64\Release\yolo_mark.cmd`

3. To training for your custom objects, you should change 2 lines in file `x64/Release/yolo-obj.cfg`:

 * set number of classes (objects): https://github.com/AlexeyAB/Yolo_mark/blob/master/x64/Release/yolo-obj.cfg#L230
 * set `filter`-value equal to `(classes + 5)*5`: https://github.com/AlexeyAB/Yolo_mark/blob/master/x64/Release/yolo-obj.cfg#L224


 3.1 Download pre-trained weights for the convolutional layers (76 MB): http://pjreddie.com/media/files/darknet19_448.conv.23 
 
 3.2 Put files: `yolo-obj.cfg`, `data/train.txt`, `data/obj.names`, `data/obj.data`, `darknet19_448.conv.23` and directory `data/img` near with executable `darknet`-file, and start training: `darknet detector train data/obj.data yolo-obj.cfg darknet19_448.conv.23`

For a detailed description, see: https://github.com/AlexeyAB/darknet#how-to-train-to-detect-your-custom-objects

####Here are:

* /x64/Release/
  * `yolo_mark.cmd` - example hot to use yolo mark: `yolo_mark.exe data/img data/train.txt data/obj.names`
  * `train_obj.cmd` - example how to train yolo for your custom objects (put this file near with darknet.exe): `darknet.exe detector train data/obj.data yolo-obj.cfg darknet19_448.conv.23`
  * `yolo-obj.cfg` - example of yoloV2-neural-network for 2 object
* /x64/Release/data/
  * `obj.names` - example of list with object names
  * `obj.data` - example with configuration for training Yolo v2
  * `train.txt` - example with list of image filenames for training Yolo v2
  
* /x64/Release/data/img/`air4.txt` - example with coordinates of objects on image `air4.jpg` with aircrafts (class=0)

![Image of Yolo_mark](https://habrastorage.org/files/229/f06/277/229f06277fcc49279342b7edfabbb47a.jpg)

