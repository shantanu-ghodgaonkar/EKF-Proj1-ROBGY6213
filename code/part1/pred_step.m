 function [covarEst,uEst] = pred_step(uPrev,covarPrev,angVel,acc,dt)
%covarPrev and uPrev are the previous mean and covariance respectively
%angVel is the angular velocity
%acc is the acceleration
%dt is the sampling time

% MY IMPLEMENTATION START -------------------------------------------------
syms theta phi; % psi;
psi = sym("psi");
f = eul2rotm([theta; phi; psi], "ZYX")

B = vertcat(blkdiag(diag([(dt^2), (dt^2), (dt^2)]), diag([dt, dt, dt]), diag([dt, dt, dt])), zeros(6,9));

uEst = uPrev + (B * [acc;angVel;acc]);

covarEst = 0;

% MY IMPLEMENTATION END ---------------------------------------------------

end

