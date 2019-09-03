%Jiale Shi
%HW3P3 of Machine Learning 

clc
clear
close all

load P3
figure;
for i = 1:length(T)
    if T(i) > 0
        plot(x1(i),x2(i),'ro','linewidth',2);hold on;
    else
        plot(x1(i),x2(i),'bo','linewidth',2);hold on;
    end
end

W = inv(X'*X)*X'*T;
W
linex1 = -5:0.1:10;
linex2 = (0.1878*linex1)/0.1655 + ;
plot(linex1,linex2,'g-','linewidth',2);hold on;
xlabel("x1"); 
ylabel("x2");
