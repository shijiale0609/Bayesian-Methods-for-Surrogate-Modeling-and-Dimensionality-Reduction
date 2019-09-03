%Jiale Shi
%HW3P1A of Machine Learning 

clc
clear
close all

load P1

%% least squares soln
modelLS = linregFit(Xtrain, y, 'lambda', 0);

modelLS

%% prediction based on least squares soln
yhatLS = linregPredict(modelLS, Xtest);


%modellh = linregFit(Xtrain, y, 'lambda', 0, 'likelihood' ,'huber');
%modellh

%% Laplace loss
modelLP = linregRobustLaplaceFitLinprog(Xtrain, y);
modelLP
yhatLaplace = linregPredict(modelLP, Xtest)+modelLP.w0;

%% Student loss 
modelStudent = linregRobustStudentFit(Xtrain, y, dof, sigma2);%, dof, sigma2
modelStudent
yhatStudent = linregPredict(modelStudent, Xtest)+modelStudent.w0;

modelStudent.dof

%% Huber loss
% deltas = [1];
% for i=1:length(deltas)
%     delta = deltas(i);
%     modelHuber = linregRobustHuberFit(Xtrain, y, delta);
%     yhatHuber{i} = linregPredict(modelHuber, Xtest); %#ok
% end

doPlot(Xtrain,y,{yhatLS},'least squares')

% Laplace and student on same plot
legendStr ={'least squares', 'laplace', ...
     sprintf('student, %s=%3.1f', '\nu', modelStudent.dof) %, ...
%     sprintf('Huber, %s=%3.1f', '\delta', deltas(1))
    };
doPlot(Xtrain, y,  {yhatLS, yhatLaplace, yhatStudent%,...
     %yhatHuber{1}
     }, ...
    legendStr)
printPmtkFigure('linregRobustAll')


function doPlot(x, y, yhat, legendStr)
if ~iscell(yhat), yhat = {yhat}; end
K = length(yhat);
xs = 0:0.1:1;
styles = {'k-.', 'b--', 'r-', 'g:'};
figure; hold on;
plot(x,y,'ko','linewidth',2)
h = [];
for i=1:K
  h(i) = plot(xs, yhat{i}, styles{i}, 'linewidth', 3, 'markersize', 10);
end
legend('','least squares', 'laplace', ...
     sprintf('student, %s=%3.4f', '\nu', 0.6296),'Location','northwest')
%axis_pct
set(gca,'ylim',[-6 4])
end



% x = Xtrain'
% y = Ytrain'
% xtest = Xtest'
% figure; hold on;
% 
% W_ML = poly_fitting(x,y,1)
% result = get_curve(x,W_ML);
% 
%  
% plot(x,y,'bo','LineWidth',1.25,'MarkerSize',8)
% legend('fitting curve','random data pts for fitting')
% 
% figure;hold on;
% ytest = xtest*W_ML(2)+W_ML(1)
% plot(xtest,ytest,'bo','LineWidth',6,'MarkerSize',8)
% plot(xtest,ytest,'r-','LineWidth',1,'MarkerSize',8)
% title('Predict the responses corresponding to the test inputs')