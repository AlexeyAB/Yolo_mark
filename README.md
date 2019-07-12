# Yolo_mark

GUI for marking bounding boxes of objects in images for training Yolo

* To build the tool, you need a compiler, cmake and OpenCV. Then run:

```bash
cmake .
make
./run.sh (or run.cmd on Windows)
```

To use for labeling your custom images:

* delete all files from directory `data/img`
* put your `.jpg`-images to this directory `data/img`
* change numer of classes (objects for detection) in file `data/obj.data`: https://github.com/cenit/Yolo_mark/blob/master/data/obj.data#L1
* put names of objects, one for each line in file `data/obj.names`: https://github.com/cenit/Yolo_mark/blob/master/data/obj.names
* run file: `yolo_mark.cmd`

To train the net for your custom objects, you should change 2 lines in file `yolo-obj.cfg`:

* [set number of classes (objects)](https://github.com/cenit/Yolo_mark/blob/master/yolo-obj.cfg#L230)
* set `filter`-value
  * [For Yolo-v2 `(classes + 5)*5`](https://github.com/cenit/Yolo_mark/blob/master/yolo-obj.cfg#L224)
  * For Yolo-v3 `(classes + 5)*3`
* Download [pre-trained weights](http://pjreddie.com/media/files/darknet19_448.conv.23) for the convolutional layers
* Put files: `yolo-obj.cfg`, `data/train.txt`, `data/obj.names`, `data/obj.data`, `darknet19_448.conv.23` and directory `data/img` near with executable `darknet`-file, and start training: `darknet detector train data/obj.data yolo-obj.cfg darknet19_448.conv.23`

For a detailed description, see [darknet repo](https://github.com/AlexeyAB/darknet#how-to-train-to-detect-your-custom-objects)

## How to get frames from video files

To get frames from video files (save each N frame, in example N=10), you can use this command:

* on Windows: `yolo_mark.exe data/img cap_video test.mp4 10`
* on Linux: `./yolo_mark x64/Release/data/img cap_video test.mp4 10`

Directory `data/img` should be created before this. Also on Windows, the file `opencv_ffmpeg340_64.dll` from `opencv\build\bin` should be placed near with `yolo_mark.exe`.

As a result, many frames will be collected in the directory `data/img`. Then you can label them manually using such command

* on Windows: `yolo_mark.exe data/img data/train.txt data/obj.names`
* on Linux: `./yolo_mark x64/Release/data/img x64/Release/data/train.txt x64/Release/data/obj.names`

## Instruction manual

### Mouse control

Button | Description
--- | ---
Left | Draw box
Right | Move box

### Keyboard Shortcuts

Shortcut | Description
--- | ---
<kbd>→</kbd> | Next image
<kbd>←</kbd> | Previous image
<kbd>r</kbd> | Delete selected box (mouse hovered)
<kbd>c</kbd> | Clear all marks on the current image
<kbd>p</kbd> | Copy previous mark
<kbd>o</kbd> | Track objects
<kbd>ESC</kbd> | Close application
<kbd>n</kbd> | One object per image
<kbd>0-9</kbd> | Object id
<kbd>m</kbd> | Show coords
<kbd>w</kbd> | Line width
<kbd>k</kbd> | Hide object name
<kbd>h</kbd> | Help
