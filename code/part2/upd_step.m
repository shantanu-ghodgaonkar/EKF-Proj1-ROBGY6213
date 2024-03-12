function [uCurr,covar_curr] = upd_step(z_t,covarEst,uEst)
%z_t is the measurement
%covarEst and uEst are the predicted covariance and mean respectively
%uCurr and covar_curr are the updated mean and covariance respectively
% Based on analysis, initialise the matrix C as shown below
C = horzcat(zeros(3),eye(3), zeros(3,9));
% Tuned value for R
R = eye(3) * 10;
% Kalman Gain
K = (covarEst * C') / ((C * covarEst * C') + R);
% Updated Covariance matrix
covar_curr = covarEst - (K * C * covarEst);
% Updated State Matrix
uCurr = uEst + (K * (z_t - (C*uEst)));

end