function [uCurr,covar_curr] = upd_step(z_t,covarEst,uEst)
%z_t is the measurement
%covarEst and uEst are the predicted covariance and mean respectively
%uCurr and covar_curr are the updated mean and covariance respectively

% MY IMPLEMENTATION START -------------------------------------------------
C = horzcat(eye(6), zeros(6,9));
R = eye(6) * 0.01;
% R = zeros(6);
% K = (covarEst * C') *  inv((C * covarEst * C') + R);
K = (covarEst * C') / ((C * covarEst * C') + R);
covar_curr = covarEst - (K * C * covarEst);
uCurr = uEst + (K * (z_t - (C*uEst)));

% MY IMPLEMENTATION END ---------------------------------------------------


end