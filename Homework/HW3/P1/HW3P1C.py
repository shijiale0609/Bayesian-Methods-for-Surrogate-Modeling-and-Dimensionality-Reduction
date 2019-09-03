#!/usr/bin/env python
# coding: utf-8

# In[2]:


# Jiale Shi
# HW3P1C huber loss function
import numpy as np
import matplotlib.pyplot as plt
from sklearn.datasets import make_regression
from sklearn.linear_model import HuberRegressor, Ridge
import scipy.io

# input data P1.mat
data = scipy.io.loadmat('P1')
X = data["Xtrain"]
y = np.array(data['y'].T)[0]


# In[16]:


plt.plot(X, y, 'black', marker = "o", linewidth =0,ms=4,label="Train Data")

# Fit the huber regressor over a series of epsilon values.
colors = ['r-', 'b-', 'y-', 'm-']

x = data["Xtest"]

#least squares, the results is from P1A
plt.plot(x,4.00409382*x+(-1.75948008),c='black',marker='^',label="least squares")

#Laplace, the results is from P1B
plt.plot(x,3.9259*x-0.4859,c='yellow',marker='s',label="Laplace")

#Students' T, the results is from P1B
plt.plot(x,2.8321*x-1.0691,c='brown',marker='>',label="Student's T")

epsilon_values = [1, 5]
for k, epsilon in enumerate(epsilon_values):
    huber = HuberRegressor(fit_intercept=True, alpha=0.0, max_iter=100,
                           epsilon=epsilon)
    huber.fit(X, y)
    coef_ = huber.coef_ * x + huber.intercept_
    print (huber.coef_,huber.intercept_)
    plt.plot(x, coef_, colors[k], label="huber loss, %s" % epsilon)

# Fit a ridge regressor to compare it to huber regressor.
ridge = Ridge(fit_intercept=True, alpha=0.0, random_state=0, normalize=True)
ridge.fit(X, y)
coef_ridge = ridge.coef_
coef_ = ridge.coef_ * x + ridge.intercept_
#plt.plot(x, coef_, 'g-', label="ridge regression")

plt.title("Comparison of HuberRegressor with huber loss 1 and huber loss 5")
plt.xlabel("X")
plt.ylabel("y")
plt.legend(loc=0)
plt.show()


# In[ ]:




