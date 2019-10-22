import glob
import os

f = open("data/test.txt", "a+")
f2 = open("data/train.txt", "a+")

for files in glob.glob("data/test/*.jpg"):
    #print(files)
    f.write("%s\n" % files.strip().replace("test\\", "images/"))

for files in glob.glob("data/img/*.jpg"):
    #print(files)
    f2.write("%s\n" % files.strip().replace("\\", "/"))
