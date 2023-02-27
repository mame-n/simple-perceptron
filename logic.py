import random
import numpy as np
from common.functions import sigmoid, softmax

class Logic:
  def __init__(self):
    self.num_fruits = 10
#    self.weights = [random.uniform(-1.0, 1.0)]*5
    self.weights = [0.3606003870509211, 0.3606003870509211, 0.3606003870509211, 0.3606003870509211, 0.3606003870509211]
    self.location_fruits = []
    self.fruits = []
    self.speed = 0.01

    self.read_result()
    self.main()
    y = self.predict([100,100])
    print(y) # -1

  def read_result(self):
    tmp_x = []
    fp = open("result03/x座標のリスト.txt","r")
    for line_data in fp:
      tmp_x.append( float(line_data.rstrip('\n')) ) 
    fp.close

    tmp_y = []
    fp = open("result03/y座標のリスト.txt","r")
    for line_data in fp:
      tmp_y.append( float(line_data.rstrip('\n')) )
    fp.close

    for i in range(self.num_fruits):
      self.location_fruits.append( [tmp_x[i], tmp_y[i]] )

    fp = open("result03/フルーツのリスト(りんご_ 1、バナナ_-1).txt","r")
    for line_data in fp:
      self.fruits.append( int(line_data.rstrip('\n')) )

  def main(self):
    for i in range(100):
      self.teach()
      print( self.weights )

  def teach(self):
    for id_fruit in range(self.num_fruits):
      # 1st
      if self.weights[0] * self.location_fruits[id_fruit][0]/240.0 + self.weights[1] * self.location_fruits[id_fruit][1]/180.0 + self.weights[2] > 0:
        expect_fruit = 1 # :apple
      else:
        expect_fruit = -1 # :banana

      # 2nd
      if self.weights[3] * expect_fruit + self.weights[4] > 0:
        expect_fruit = 1
      else:
        expect_fruit = -1

      df = self.fruits[id_fruit] - expect_fruit

      self.weights[0] += self.speed * df * self.location_fruits[id_fruit][0]
      self.weights[1] += self.speed * df * self.location_fruits[id_fruit][1]
      self.weights[2] += self.speed * df

      self.weights[3] += self.speed * df * expect_fruit
      self.weights[4] += self.speed * df
    
    print( self.weights )
    
  def predict(self, xx):
    a1 = xx[0]/240.0 * self.weights[0] + xx[1]/180.0 * self.weights[1] + self.weights[2]
    print(a1)
    z1 = sigmoid(a1)
    a2 = z1 * self.weights[3] + self.weights[4]
    y = softmax(a2)

    return y

Logic()



