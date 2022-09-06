---
name: Image Classfication&#58; Cats & Dogs
tools: [Python, CNN, Deep Learning]
image: /img/projects/cats_vs_dogs/Header_Cats-vs-Dogs-951x512.webp
description: This project a begginer implementation of a binary classification using Convolutional Neural Networks to distinguish between cats and dogs images.<br>Credits&#58; Model by Harrison Kinsley.
---

# Data
---
**Data Source**: [https://www.kaggle.com/c/dogs-vs-cats/data](https://www.kaggle.com/c/dogs-vs-cats/data)

The training archive contains 25,000 images of dogs and cats. Train your algorithm on these files and predict the labels for test1.zip (1 = dog, 0 = cat).

## Data preview
#### Train Data
![Training data](/img/projects/cats_vs_dogs/train.png)
#### Test Data
![Teset data](/img/projects/cats_vs_dogs/test1.png)

## Preprocessing
```python
import cv2              
import numpy as np      
import os 
from random import shuffle
from tqdm import tqdm
TRAIN_DIR = 'train'
TEST_DIR = 'test1'
IMG_SIZE = 100
LR = 0.001
MODEL_NAME = 'dogsvscats-{}-{}.model'.format(LR, '4conv-basic')
```
* Conversion to one-hot array [cat,dog]:
    - ‘Dog’ <=> [0,1] 
    - ‘Cat’ <=> [1,0]

```python
def label_img(img):
    word_label = img.split('.')[0]
    if word_label == 'cat': return [1,0]
    elif word_label == 'dog': return [0,1]
```
* Function that converts the data for us into array data of the image and its label.
<br>When we’ve gone through all of the images, we shuffle them, then save them.

```python
def create_train_data():
    training_data = []
    for img in tqdm(os.listdir(TRAIN_DIR)):
        label = label_img(img)
        path = os.path.join(TRAIN_DIR,img)
        img = cv2.imread(path,-1) #1 for color, 0 for grayscale, -1 for unchanged
        img = cv2.resize(img, (IMG_SIZE,IMG_SIZE))
        training_data.append([np.array(img),np.array(label)])
        
    shuffle(training_data)
    np.save('train_data.npy', training_data)
    return training_data

def create_test_data():
    testing_data = []
    for img in tqdm(os.listdir(TEST_DIR)):
        
        path = os.path.join(TEST_DIR,img)
        img_num = img.split('.')[0]
        img = cv2.imread(path ,-1)
        img = cv2.resize(img, (IMG_SIZE,IMG_SIZE))
        testing_data.append([np.array(img), img_num])
        
    shuffle(testing_data)
    np.save('test_data.npy', testing_data)
    return testing_data
```
* Create train and test(not for the model but for the verification of the model) data.

```python 
train_data = create_train_data()
test_data = create_test_data()
```
* Split train and test data :
    - train data 80% of data
    - test data 20% of data

```python
train_data = np.load('train_data.npy')
train = train_data[:20000]
test = train_data[20000:]
```
* Let's check the data shape.

```python
train.shape,test.shape
```

```
Out[]: ((20000, 2), (5000, 2))
```
* Define input and output for train and test data

```python
train_x = np.array([i[0] for i in train]).reshape(-1,IMG_SIZE,IMG_SIZE,3)
train_y = [i[1] for i in train]
test_x = np.array([i[0] for i in test]).reshape(-1,IMG_SIZE,IMG_SIZE,3)
test_y = [i[1] for i in test]
```
# Define CNN model

```python 
import tensorflow as tf
import tflearn
from tflearn.layers.conv import conv_2d, max_pool_2d
from tflearn.layers.core import input_data, dropout, fully_connected
from tflearn.layers.estimator import regression
tf.reset_default_graph()
convnet = input_data(shape=[None, IMG_SIZE, IMG_SIZE, 3], name='input')
convnet = conv_2d(convnet, 32, 5, activation='relu')
convnet = max_pool_2d(convnet, 5)
convnet = conv_2d(convnet, 64, 5, activation='relu')
convnet = max_pool_2d(convnet, 5)
convnet = conv_2d(convnet, 128, 5, activation='relu')
convnet = max_pool_2d(convnet, 5)
convnet = conv_2d(convnet, 64, 5, activation='relu')
convnet = max_pool_2d(convnet, 5)
convnet = conv_2d(convnet, 32, 5, activation='relu')
convnet = max_pool_2d(convnet, 5)
convnet = fully_connected(convnet, 1024, activation='relu')
convnet = dropout(convnet, 0.8)
convnet = fully_connected(convnet, 2, activation='softmax')
convnet = regression(convnet, optimizer='adam', learning_rate=LR, loss='categorical_crossentropy', name='targets')
model = tflearn.DNN(convnet, tensorboard_dir='log')
```
* Save the logs for tensorboard

```python
if os.path.exists('log/{}.meta'.format(MODEL_NAME)):
    model.load(MODEL_NAME)
    print('model loaded!')
```

# Fit the model

```python
model.fit({'input': train_x}, {'targets': train_y}, n_epoch=10, validation_set=({'input': test_x}, {'targets': test_y}), 
    snapshot_step=500, show_metric=True, run_id=MODEL_NAME)
```

```
Training Step: 3129  | total loss: 0.19341 | time: 226.028s
| Adam | epoch: 010 | loss: 0.19341 - acc: 0.9212 -- iter: 19968/20000
Training Step: 3130  | total loss: 0.20136 | time: 245.376s
| Adam | epoch: 010 | loss: 0.20136 - acc: 0.9181 | val_loss: 0.46174 - val_acc: 0.8362 -- iter: 20000/20000
--
```

* Save the model

```python
model.save(MODEL_NAME)
```

# Test the model on unlabeled test data
* Load unlabeled data

```python
test_data = np.load('test_data.npy')
```

```python 
import matplotlib.pyplot as plt
fig=plt.figure()
for num,data in enumerate(test_data[:10]):
    # cat: [1,0]
    # dog: [0,1]    
    img_num = data[1]
    img_data = data[0]
    
    y = fig.add_subplot(3,5,num+1)
    orig = img_data
    data = img_data.reshape(IMG_SIZE,IMG_SIZE,3)
    model_out = model.predict([data])[0]
    
    if np.argmax(model_out) == 1: str_label='Dog'
    else: str_label='Cat'
                
    y.imshow(orig)
    plt.title(str_label)
    y.axes.get_xaxis().set_visible(False)
    y.axes.get_yaxis().set_visible(False)
plt.show()
fig.savefig('test.png', format='png', dpi=300)
```

![Test the model](/img/projects/cats_vs_dogs/test.png)

# Tensorboard
* Run this command line in terminal under the project directory

```shell
tensorboard --logdir log
```

## Train Accuracy
![Accuracy](/img/projects/cats_vs_dogs/Accuracy.png)

## Validation Accuracy
![Validation](/img/projects/cats_vs_dogs/Validation.png)

## Adam Loss
![Adam Loss](/img/projects/cats_vs_dogs/Adam_Loss_Raw.png)

---