# Prerequisites
You will need to download the following programs in order to use Yolo mark, if you do not already have them:

#### OpenCV (Download as a ZIP)

https://github.com/opencv/opencv

#### CMake

https://cmake.org/download/

#### Microsoft Visual Studio (2017 version 15.9.15 garaunteed to work)

https://visualstudio.microsoft.com/vs/older-downloads/

### Installation (For Windows 10 64-bit)

1. Extract the opencv-master.zip to your C: or any drive you like, and you can rename the outfolder so the directory is like this `C:/OpenCV4/opencv-master`

2. Open the CMake GUI

3. For the "Where is the source code:" field, click **Browse Source...** and add the directory of the OpenCV folder from above. In this example it is `C:/OpenCV4/opencv-master`.

4. For the "Where to build the binaries:" field, create a folder inside the OpenCV folder called "opencv" and click **Browse Build...** to add it. In this example, it is `C:/OpenCV4/opencv4`

5. Click **Configure**
   - For "Specify the generator for this project", make sure to select your version of Visual Studio. In this example, we are using **Visual Studio 15 2017**
   - Under "Optional platform for generator", select **x64**. If you leave it blank, it defaults to Win32 and you will only be able to build Debug/Release in Visual Studio in Win32 and may get `LNK1112 module machine type 'x64' conflicts with target machine type 'x86` build error.
   - "Optional toolset to use" can  be left blank.
   - "Use default native compilers" can be checked.

6. After configuration is complete you will see a message "Configuring done" in the main GUI window. Find the field name "BUILD_opencv_world" in the main window and tick the box to include it.

7. Click **Generate**
   - You will see a message "Generating done" in the main GUI window when it is complete.
   
8. Click **Open Project**
   - Visual Studio will open. You will need to find **CMakeTargets** folder in the Solution Explorer to the right. Make sure the Local Windows Debugger is set to **Debug** and **x64** and select the **ALL_BUILD** C++ project, right-click and select **BUILD**.  
   - After, set the Local Windows Debugger to **Release** and keep it set to **x64**. Select the **ALL_BUILD** C++ project again, right-click and select **BUILD**.
   - Keep the Local Windows Debugger on **Release** and set to **x64**. But this time, select the **INSTALL** C++ project, right-click and select **BUILD**.
   - Change the Local Windows Debugger to **Debug** and set to **x64**. Select the **INSTALL** C++ project, right-click and select **BUILD**.
     - This will generate all the library, includes, x64, and bin/lib directories all in one space.
     
9. In Windows search, type "env" to access the Environment Variables.
   - In System Properties, under the Advanced tab, click **Environment Variables**
   - Below the **System variables** list, click **New** and enter these values for the two fields:
     - Variable name: `OPENCV_DIR`.
     - Variable value: `C:\OpenCV4\opencv4\install\x64\vc15`
   - Click OK
   - Still in the System variables window, select **Path** and click **Edit**. Add these two directories to the path:
     - %OPENCV_DIR%\bin
     - %OPENCV_DIR%\lib
   - Click OK and you can exit out of the System Properties now.
     
9. Test That Install Works
   - Creating an Empty C++ Project (Name it anything you want)
   - Right-click on the Source Files folder in the Solution Explorer to the right and add a New Item -> C++ File (.cpp) (Any name is fine)
   - Copy and paste the code below into the Source.cpp you just added:
     ```
     #include "opencv2/core.hpp"
     #include "opencv2/highgui.hpp"

        using namespace std;
        using namespace cv;

        int main(int argv, char* argc)
        {
	     Mat A;
	     A = Mat::zeros(100, 100, CV_8U);
	     namedWindow("x", WINDOW_AUTOSIZE);
	     imshow("x", A);
	     waitKey(0);
	     return 0;
        } ```
 
   - Click on **View** -> **Other Windows** -> **Property Manager**.
   - A left sidebar will appear with Debug | Win32, Debug | x64, Release | Win32, and Release | x64 options.
   - 



# Yolo_mark
**Windows** & **Linux** GUI for marking bounded boxes of objects in images for training Yolo v3 and v2

* To compile on **Windows** open `yolo_mark.sln` in MSVS2013/2015, compile it **x64 & Release** and run the file: `x64/Release/yolo_mark.cmd`. Change paths in `yolo_mark.sln` to the OpenCV 2.x/3.x installed on your computer:

    * (right click on project) -> properties -> C/C++ -> General -> Additional Include Directories: `C:\opencv_3.0\opencv\build\include;`
        
    * (right click on project) -> properties -> Linker -> General -> Additional Library Directories: `C:\opencv_3.0\opencv\build\x64\vc14\lib;`

* To compile on **Linux** type in console 3 commands:
    ```
    cmake .
    make
    ./linux_mark.sh
    ```

Supported both: OpenCV 2.x and OpenCV 3.x

--------

1. To test, simply run 
  * **on Windows:** `x64/Release/yolo_mark.cmd`
  * **on Linux:** `./linux_mark.sh`

2. To use for labeling your custom images:

 * delete all files from directory `x64/Release/data/img`
 * put your `.jpg`-images to this directory `x64/Release/data/img`
 * change numer of classes (objects for detection) in file `x64/Release/data/obj.data`: https://github.com/AlexeyAB/Yolo_mark/blob/master/x64/Release/data/obj.data#L1
 * put names of objects, one for each line in file `x64/Release/data/obj.names`: https://github.com/AlexeyAB/Yolo_mark/blob/master/x64/Release/data/obj.names
 * run file: `x64\Release\yolo_mark.cmd`

3. To training for your custom objects, you should change 2 lines in file `x64/Release/yolo-obj.cfg`:

 * set number of classes (objects): https://github.com/AlexeyAB/Yolo_mark/blob/master/x64/Release/yolo-obj.cfg#L230
 * set `filter`-value 
   * For Yolov2 `(classes + 5)*5`: https://github.com/AlexeyAB/Yolo_mark/blob/master/x64/Release/yolo-obj.cfg#L224
   * For Yolov3 `(classes + 5)*3`

 3.1 Download pre-trained weights for the convolutional layers (76 MB): http://pjreddie.com/media/files/darknet19_448.conv.23 
 
 3.2 Put files: `yolo-obj.cfg`, `data/train.txt`, `data/obj.names`, `data/obj.data`, `darknet19_448.conv.23` and directory `data/img` near with executable `darknet`-file, and start training: `darknet detector train data/obj.data yolo-obj.cfg darknet19_448.conv.23`

For a detailed description, see: https://github.com/AlexeyAB/darknet#how-to-train-to-detect-your-custom-objects

----

#### How to get frames from videofile:

To get frames from videofile (save each N frame, in example N=10), you can use this command:
* on Windows: `yolo_mark.exe data/img cap_video test.mp4 10`
* on Linux: `./yolo_mark x64/Release/data/img cap_video test.mp4 10`

Directory `data/img` should be created before this. Also on Windows, the file `opencv_ffmpeg340_64.dll` from `opencv\build\bin` should be placed near with `yolo_mark.exe`.

As a result, many frames will be collected in the directory `data/img`. Then you can label them manually using such command: 
* on Windows: `yolo_mark.exe data/img data/train.txt data/obj.names`
* on Linux: `./yolo_mark x64/Release/data/img x64/Release/data/train.txt x64/Release/data/obj.names`

----

#### Here are:

* /x64/Release/
  * `yolo_mark.cmd` - example hot to use yolo mark: `yolo_mark.exe data/img data/train.txt data/obj.names`
  * `train_obj.cmd` - example how to train yolo for your custom objects (put this file near with darknet.exe): `darknet.exe detector train data/obj.data yolo-obj.cfg darknet19_448.conv.23`
  * `yolo-obj.cfg` - example of yoloV3-neural-network for 2 object
* /x64/Release/data/
  * `obj.names` - example of list with object names
  * `obj.data` - example with configuration for training Yolo v3
  * `train.txt` - example with list of image filenames for training Yolo v3
  
* /x64/Release/data/img/`air4.txt` - example with coordinates of objects on image `air4.jpg` with aircrafts (class=0)

![Image of Yolo_mark](https://habrastorage.org/files/229/f06/277/229f06277fcc49279342b7edfabbb47a.jpg)

### Instruction manual

#### Mouse control

Button | Description | 
--- | --- |
Left | Draw box
Right | Move box

#### Keyboard Shortcuts

Shortcut | Description | 
--- | --- |
<kbd>→</kbd> | Next image |
<kbd>←</kbd> | Previous image |
<kbd>r</kbd> | Delete selected box (mouse hovered) |
<kbd>c</kbd> | Clear all marks on the current image |
<kbd>p</kbd> | Copy previous mark |
<kbd>o</kbd> | Track objects |
<kbd>ESC</kbd> | Close application |
<kbd>n</kbd> | One object per image |
<kbd>0-9</kbd> | Object id |
<kbd>m</kbd> | Show coords |
<kbd>w</kbd> | Line width |
<kbd>k</kbd> | Hide object name |
<kbd>h</kbd> | Help |

