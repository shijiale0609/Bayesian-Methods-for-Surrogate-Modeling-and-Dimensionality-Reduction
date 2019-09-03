%Jiale Shi
%HW3P2A of Machine Learning 

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
for i =1:length(y)
    x = X(i,:)'   
    W = W + eta*(y(i)-W'*x)*x
    
    ypred = trainx*W(2,1)+W(1,1)
    %plot(trainx,ypred,'k-','linewidth',2);hold on;
    plot([i+m*20-20],[norm(W)],'k+','linewidth',2);hold on;
end
%plot(trainx,ypred,'k-','linewidth',2);hold on;
%plot([i+m*20-20],[norm(W)],'k+','linewidth',2);hold on;
end
%plot ||w|| vs i+20*m
ylabel("|w|")
xlabel("t")

Wls
W