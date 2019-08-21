#!/bin/sh

echo "How to start marking bounding boxes to create training sets for Yolo"

./yolo_mark data/img data/train.txt data/obj.names
