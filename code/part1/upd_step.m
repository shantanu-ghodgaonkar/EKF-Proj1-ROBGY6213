function [uCurr,covar_curr] = upd_step(z_t,covarEst,uEst)
%z_t is the measurement
%covarEst and uEst are the predicted covariance and mean respectively
%uCurr and covar_curr are the updated mean and covariance respectively

% MY IMPLEMENTATION START -------------------------------------------------
% Based on analysis, initialise the matrix C as shown below
C = horzcat(eye(6), zeros(6,9));
% Tuned value for R
R = eye(6) * 0.00001;
% Kalman Gain
K = (covarEst * C') / ((C * covarEst * C') + R);
% Updated Covariance matrix
covar_curr = covarEst - (K * C * covarEst);
% Updated State Matrix
uCurr = uEst + (K * (z_t - (C*uEst)));

% MY IMPLEMENTATION END ---------------------------------------------------


end