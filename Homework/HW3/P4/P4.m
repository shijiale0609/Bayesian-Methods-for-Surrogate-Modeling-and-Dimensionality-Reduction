%Jiale Shi
%HW3P4 of Machine Learning 

% -------------------------------------------------------------------------
%
% Copyright: MPDC Laboratory, Cornell University, 2011  
% http://mpdc.mae.cornell.edu/ (Prof. N. Zabaras)
%
% This code implements logistic regression algorithm for 
% classification, and it reproduces Figure 4.5b from Bishop's book. 
% % -------------------------------------------------------------------------
% 
clear all;
close all;
clc;

% read data
data = load('HW3P4');
%data=load('data_3c');

n = size(data,1);
X = ones(n,3);
X(:,2:3) = data(:,1:2);
t = zeros(n,3);

% Plot the data
dataset1 = []; dataset2 = []; dataset3 = [];
for i=1:n
    if( data(i,3) == 0)
        dataset1 = [dataset1; data(i,1),data(i,2)];        
    elseif( data(i,3) == 1)
        dataset2 = [dataset2; data(i,1),data(i,2)];        
    else
        dataset3 = [dataset3; data(i,1),data(i,2)];        
    end
    t(i,data(i,3)+1) = 1;
end

% Use logistic regression model 
% for the details of the algorithm, please refer to 4.3.2

stop_criterion = 1e-5;
move = 1e-2;

old_w = zeros(3,3);
new_w = ones(3,3);

% Use iterative method to find the best weight

while ( norm( new_w - old_w)/norm(new_w) > stop_criterion )
    norm( new_w - old_w)/norm(new_w);
    old_w = new_w;
    direction = zeros(3,3);
    
    error = 0;
    for i=1:n
        phi_i = X(i,:)';    
    %   If you want to use sigmoidal function as the basis function, please use the below phi_i, 
    %   note that the corresponding weights are no longer coefficients for the
    %   decision function.   
%             phi_i = sigmoidal(X(i,:)); 

        a_i = old_w*phi_i;
        y_i(1) = exp(a_i(1)) / ( exp(a_i(1)) + exp(a_i(2))+ exp(a_i(3)) );
        y_i(2) = exp(a_i(2)) / ( exp(a_i(1)) + exp(a_i(2))+ exp(a_i(3)) );
        y_i(3) = exp(a_i(3)) / ( exp(a_i(1)) + exp(a_i(2))+ exp(a_i(3)) );
       
        
        direction(1,:) = direction(1,:) + (y_i(1) - t(i,1))*phi_i';
        direction(2,:) = direction(2,:) + (y_i(2) - t(i,2))*phi_i';
        direction(3,:) = direction(3,:) + (y_i(3) - t(i,3))*phi_i';    
        error =  error + abs(sum(y_i-t(i,:)));
    end
    new_w = old_w - move*direction;
end

x = -10:0.01:15;

% Compute the activation functions a_i, i=1,...,K (boundaries between 2
% classes, here classes 1 and 2, 2 and 3 and 3 and 1. Not all of these
% boundaries become decision boundaries. 

y_lr_1 = -(new_w(1,2)-new_w(2,2))/(new_w(1,3)-new_w(2,3))*x - (new_w(1,1)-new_w(2,1))/(new_w(1,3)-new_w(2,3)); 

y_lr_2 = -(new_w(2,2)-new_w(3,2))/(new_w(2,3)-new_w(3,3))*x - (new_w(2,1)-new_w(3,1))/(new_w(2,3)-new_w(3,3)); 

y_lr_3 = -(new_w(1,2)-new_w(3,2))/(new_w(1,3)-new_w(3,3))*x - (new_w(1,1)-new_w(3,1))/(new_w(1,3)-new_w(3,3)); 

figure (1)

plot(dataset1(:,1),dataset1(:,2),'rx'); hold on;
plot(dataset2(:,1),dataset2(:,2),'g+');
plot(dataset3(:,1),dataset3(:,2),'bo');

plot(x,y_lr_1,'r-'); 
plot(x,y_lr_2,'g-'); 
plot(x,y_lr_3,'b-'); 

% axis([-6 8 -10 10]); hold off;
axis([-8 12 -6 8]); hold off;

% Compute the class domains and decision boundaries based on posterior 
% probabilities

x = -10:0.1:12;
y = -10:0.1:12;
Z = zeros(length(x),length(y));

[X Y] = meshgrid(x,y);
for i=1:length(x)
    for j=1:length(y)
        x = [1;X(i,j);Y(i,j)];
        a = new_w*x;
        z1 = exp(a(1))/(exp(a(1))+exp(a(2))+exp(a(3)));
        z2 = exp(a(2))/(exp(a(1))+exp(a(2))+exp(a(3)));
        z3 = exp(a(3))/(exp(a(1))+exp(a(2))+exp(a(3)));
        
        maxvalue = max([z1, z2, z3]);
 
        % Rescale for plotting
        
        if maxvalue == z1
            Z(i,j) = 25;             % Mark as class 1
        elseif maxvalue ==  z2
            Z(i,j) = 10;             % Mark as class 2
        elseif maxvalue == z3
            Z(i,j)  = 20;            % Mark as class 3
        end
    end
end

figure (2)
contourf(X,Y,Z);colormap('gray');hold on;
plot(dataset1(:,1),dataset1(:,2),'rx'); hold on; % Print the input data points
plot(dataset2(:,1),dataset2(:,2),'g+');
plot(dataset3(:,1),dataset3(:,2),'bo');
% axis([-6 8 -10 10])
axis([-8 12 -6 8]);
