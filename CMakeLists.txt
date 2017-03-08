cmake_minimum_required(VERSION 2.8)
project( yolo_mark )
find_package( OpenCV REQUIRED )


add_custom_command( OUTPUT main.o
				COMMAND g++ -m64 -O3 -fpermissive -w -Wall -std=c++11 -c main.cpp 
				DEPENDS main.cpp )


add_executable( yolo_mark main.o )

target_link_libraries( yolo_mark ${OpenCV_LIBS} -L/usr/lib64 -ldl)
