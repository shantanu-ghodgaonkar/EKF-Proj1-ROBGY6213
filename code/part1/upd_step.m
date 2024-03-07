function [uCurr,covar_curr] = upd_step(z_t,covarEst,uEst)
%z_t is the measurement
%covarEst and uEst are the predicted covariance and mean respectively
%uCurr and covar_curr are the updated mean and covariance respectively

% MY IMPLEMENTATION START -------------------------------------------------

uCurr = uEst;
covar_curr = 0;

% MY IMPLEMENTATION END ---------------------------------------------------


end