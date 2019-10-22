from glob import glob
import glob
import os
import numpy as np
import shutil

files =  glob.glob('data/img/*.jpg')
print (files)

for i in range(0,len(files)):
    print("index: %d is %s" % (i,files[i]))

no_of_images = len(files)
print(no_of_images)

shuffle = np.random.permutation(no_of_images) # creates random permutation of 602 images
print(shuffle)

list = [1,3,5,9,7, 9,10]
#print(shuffle[:180])
#print(shuffle[180:])

os.mkdir(os.path.join('data', 'test')) # creates empty VALID folder

#for files in glob.glob('data/images/*.jpg'):
    #print (files)

for i in shuffle[:240]:
    print(files[i])
    shutil.copy(files[i],'data/test')
    folder = files[i].split('/')[-1].split('.')[0]
    print(folder)
    image = files[i].split('/')[-1]
    print(image)
