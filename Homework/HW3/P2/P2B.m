%Jiale Shi
%HW3P2B of Machine Learning 



clc
clear
close all

load P2


Wls = inv(X'*X)*X'*y
W = [1.5;2.0]
eta = 0.0002
trainx = X(:,2)
ypredls = trainx*Wls(2,1)+Wls(1,1)
figure;
%plot(trainx,y,'ko','linewidth',2);hold on;
%plot(trainx,ypredls,'r-','linewidth',2);hold on;

for m = 1:60
for i =[1,2,3,4]
    x1 = X(5*i-4,:)'
    x2 = X(5*i-3,:)'
    x3 = X(5*i-2,:)'
    x4 = X(5*i-1,:)'
    x5 = X(5*i,:)'
    W = W + eta*(y(i)-W'*x1)*x1+ eta*(y(i)-W'*x2)*x2+ eta*(y(i)-W'*x3)*x3+ eta*(y(i)-W'*x4)*x4+ eta*(y(i)-W'*x5)*x5
    
    ypred = trainx*W(2,1)+W(1,1)
    %plot(trainx,ypred,'k-','linewidth',2);hold on;
    plot([i+m*4-4],[norm(W)],'k+','linewidth',2);hold on;
end
end

ylabel("|w|")
xlabel("t")

Wls
W