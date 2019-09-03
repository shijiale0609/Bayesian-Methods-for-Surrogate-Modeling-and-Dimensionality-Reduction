% 
% MAE7140 Bayesian Scientific Computing
% 
% Homework #1-6: Bayesian model comparison
%
% The original code is written by Zoubin Ghahramani
%
% Goal: Plot the bayesian polynomial regression with n number of points up
% to max degree of polynomial. 
%
% Remark: This code follows the description given in the p114 of lecture
% notes. 
%
%loadData('data_problem7') 
 
% clear all memory and close all windows
% clc
% clear all
% close all
 
% set the defaul tparameter
%N = 20;       % the number of data points
M = 5;       % the max degree of polynomial
plotlog = 0; % plotting flag for log-scale

%x %= 10*rand(N, 1)         % generate input points
%noise %= 3*randn(N, 1);    % generate gaussian noise
%y %= (x-4).^2 + noise;     % actual truth function
 
xx = [-2:0.1:12]';        % uniform grid for plotting
num_xx = length(xx);
 
figure(1)
set(gcf,'Position',[8   220   560   420]);
clf;
 
% set parameters
gamma = 0.001/N;   % controls prior variance of Gaussian distribution on polynomial coefficients
beta = 0.00001;  % shape parameter for Gamma distribution on noise (precision)
alpha = 0.1;     % scale parameter for Gamma distribution on noise precision 
   
lnE = 0;
lne = [];
 
for i = 0:M
  % compute
  X = ones(N,1);
  XX = ones(num_xx,1);
  for j = 1:i
    X = [X x.^j];
    XX = [XX xx.^j];
  end
 
  % inference
  EXX = X'*X/N;
  EYY = y'*y/N;
  EYX = y'*X/N;
  d = i+1;
  IBB = inv(EXX+ (gamma/N)*eye(d));
  err = (EYY - EYX*IBB*EYX');
  fprintf('param=%g err=%g \n',d,err);
   
  % compute the marginal likelihood
  lnE = -(0.5*N)*log(2*pi) + alpha*log(beta) -gammaln(alpha) + (0.5*d)*log(gamma/N) - 0.5*log(det(EXX + (gamma/N)*eye(d)))+gammaln(N*0.5+alpha) ...
      -(N/2+alpha)*log(beta + (N*0.5)*err); 
  lne = [lne lnE];
   
  % generate samples from the posterior distribution
  if d > 0
      alp = alpha + N/2;
      bet = beta+0.5*N*EYY - 0.5*N*EYX*inv(EXX + (gamma/N)*eye(d))*EYX'; 
      subplot(2, ceil((M+1)/2),(i + 1));
      for j = 1:20
          rho = gamrnd(alp, 1/bet);
          IB = IBB/(rho*N);
          SIB = sqrtm(IB);
          A = rho*N*EYX';
          w = IB*A+SIB*randn(d,1);
          yhat = XX*w;
          hold on
          plot(xx, yhat, 'g-', 'LineWidth', 1);
      end      
  end
end
 
for i=0:M
    p1 = subplot(2, ceil((M+1)/2),(i+1));
    X = ones(N, 1);
    XX = ones(num_xx, 1);
    for j = 1:i
        X = [X x.^j];
        XX = [XX xx.^j];
    end
    bet = X\y;
    yhat = XX*bet;
    plot(xx, yhat, 'b-', 'LineWidth', 2);
    s = ['M = ' num2str(i)];
    ss = title(s);
    set(ss, 'FontSize', 18);
 
    hold on
    set(p1, 'FontSize', 15);
    a1 = plot(x,y,'ro','MarkerFaceColor','r');
    axis([-2 12 -20 50]);
end
 
% plot the evidence
figure(2);
set(gcf,'Position',[581   220   417   399]);
PP = exp(lne);
PP = PP / sum(PP);
 
bar(0:M, PP)
axis([-0.5 M+0.5 0 1]);
 
set(gca, 'FontSize', 16);
aa = xlabel('M'); set(aa, 'FontSize', 20);
aa = ylabel('P(D|M)'); set(aa, 'FontSize', 20);
 
% plot the log evidence
if plotlog
    figure(3);
    plot(lne, '.-');
    aa = xlabel('M'); set(aa, 'FontSize', 20);
    aa = ylabel('log P(D|M)'); set(aa, 'FontSize', 20);
end