function [uCurr,covar_curr] = upd_step(z_t,covarEst,uEst)
%z_t is the measurement
%covarEst and uEst are the predicted covariance and mean respectively
%uCurr and covar_curr are the updated mean and covariance respectively
C = horzcat(eye(3), zeros(3,12));
W = horzcat(eye(3), zeros(3,12));
R = eye(3) * 0.1;
K = (covarEst * C') \ ((C * covarEst * C') + (W * R * W'));
covar_curr = covarEst - (K * C * covarEst);
uCurr = uEst + K * (z_t - gxv);

end