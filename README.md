# Yolo_mark
Windows GUI for marking bounded boxes of objects in images for training Yolo v2

Here are:

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

