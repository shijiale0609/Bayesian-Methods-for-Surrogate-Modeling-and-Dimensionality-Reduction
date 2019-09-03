%Jiale Shi
%HW4P5D of Machine Learning 

clc
clear
close all

load('~/ML/2019S/HW3/data/P1/P1.mat')

%% Student loss 
modelStudent = linregRobustStudentFit(Xtrain, y, dof, sigma2);%, dof, sigma2
modelStudent
yhatStudent = linregPredict(modelStudent, Xtest)+modelStudent.w0;


%% Student loss without parameters dof and sigma2
modelStudent_nonparameter = linregRobustStudentFit(Xtrain, y);%, dof, sigma2
modelStudent_nonparameter
yhatStudent_nonparameter = linregPredict(modelStudent_nonparameter, Xtest)+modelStudent_nonparameter.w0;



legendStr ={sprintf('student with paramters'),sprintf('student without parameters')};
doPlot(Xtrain, y,  { yhatStudent,yhatStudent_nonparameter}, ...
    legendStr)

function doPlot(x, y, yhat, legendStr)
if ~iscell(yhat), yhat = {yhat}; end
K = length(yhat);
xs = 0:0.1:1;
styles = {'b--', 'r-', 'g:'};
figure; hold on;
plot(x,y,'ko','linewidth',2)
h = [];
for i=1:K
  h(i) = plot(xs, yhat{i}, styles{i}, 'linewidth', 3, 'markersize', 10);
end
legend('',sprintf('student with paramters'),sprintf('student without parameters'),'Location','northwest')
set(gca,'ylim',[-6 4])
end



