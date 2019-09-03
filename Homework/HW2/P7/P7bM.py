import numpy as np
#import scipy as sy
import matplotlib.pyplot as plt
import scipy.io






#%%

t= np.linspace(0,10,40)
datatest = np.array(np.matrix(t).T)
#print (datatest)
Xt = np.matrix(np.hstack((pow(datatest,0),datatest)))
#print (Xt)
Im = np.eye(40)
Vari = k*(Im+Xt*VN*Xt.T)
def getvariance(V):
    t = np.array(V)
    errorbar = []
    for i in range(40):
        errorbar = np.append(errorbar, np.sqrt(t[i][i]))
    return errorbar



error_bar = getvariance(Vari)




error_bar




Yp = Xt*wN



Ypre = []
for i in range(0,len(Yp)):
    Ypre = np.append(Ypre,(Yp[i][0]))





Ypre


plt.plot(xt,(xt-4)*(xt-4),c='r',label = "exact function y = (x-4)*(x-4)")
plt.scatter(x,y,label="train data")
plt.errorbar(np.array(datatest.T)[0],Ypre,error_bar,label="M=1")
plt.xlabel("x")
plt.ylabel("y")
plt.legend()
plt.show()




mean = np.array(wN.T)[0]
cov = np.array(k*VN)
dof = 2*aN

print (mean)
print(cov)
print (dof)




# from https://www.youtube.com/watch?v=lybd2bEpsw4
import numpy as np
import scipy.linalg as spla

def multivariate_normal_sampler(mean,cov,n_samples=1):
    L = spla.cholesky(cov)
    Z = np.random.normal(size= (n_samples,cov.shape[0]))
    return Z.dot(L) + mean

def multivariate_student_t_sampler(mean,cov,dof,n_samples=1):
    m = mean.shape[0]
    u = np.random.gamma(dof/2.,2./dof,size = (n_samples,1))
    Y = multivariate_normal_sampler(np.zeros((m,)),cov,n_samples)
    return Y / np.tile(np.sqrt(u),[1,m])+mean



W = multivariate_student_t_sampler(mean,cov,dof,10)



W




W[0][1]




plt.scatter(x,y,label="train data")
for i in range(10):
    plt.plot(xt,W[i][0]+W[i][1]*xt)
plt.title("M=1")
plt.show()

