function [covarEst,uEst] = pred_step(uPrev,covarPrev,angVel,acc,dt)
%covarPrev and uPrev are the previous mean and covariance respectively
%angVel is the angular velocity
%acc is the acceleration
%dt is the sampling time

% MY IMPLEMENTATION START -------------------------------------------------
% initialise POSITION symbolic variables using previous state
xPos = uPrev(1,1);
yPos = uPrev(2,1);
zPos = uPrev(3,1);
% initialise ORIENTATION symbolic variables using previous state
xOrient = uPrev(4,1); % ROLL
yOrient = uPrev(5,1); % PITCH
zOrient = uPrev(6,1); % YAW
% initialise VELOCITY symbolic variables using previous state
xVel = uPrev(7,1);
yVel = uPrev(8,1);
zVel = uPrev(9,1);
% initialise GYROSCOPE BIAS symbolic variables using previous state
xBg = uPrev(10,1);
yBg = uPrev(11,1);
zBg = uPrev(12,1);
% initialise ACCELEROMETER BIAS symbolic variables using previous state
xBa = uPrev(13,1);
yBa = uPrev(14,1);
zBa = uPrev(15,1);
% initialise ANGULAR VELOCITY symbolic variables using control inputs
xOmgU = angVel(1,1);
yOmgU = angVel(2,1);
zOmgU = angVel(3,1);
% initialise LINEAR ACCELERATION symbolic variables using control inputs
xAccU = acc(1,1);
yAccU = acc(2,1);
zAccU = acc(3,1);
% initialise GYROSCOPE NOISE symbolic variables to 0
xNg = 0;
yNg = 0;
zNg = 0;
% initialise ACCELEROMETER NOISE symbolic variables to 0
xNa = 0;
yNa = 0;
zNa = 0;

% Create the required components of the state matrix, for later substitution into
% f(x,u,n)
% x1 = [xPos;yPos;zPos];
% x2 = [xOrient;yOrient;zOrient];
x3 = [xVel;yVel;zVel];
x4 = [xBg;yBg;zBg];
x5 = [xBa;yBa;zBa];
% x = vertcat(x1,x2,x3,x4,x5);

% Precompute required sines and cosines to reduce computation time
sxo = sin(xOrient);
syo = sin(yOrient);
szo = sin(zOrient);
cxo = cos(xOrient);
cyo = cos(yOrient);
czo = cos(zOrient);

% Calculate inverse of Euler Rate Parameterisation (ZYX) for f(x,u,n)
G_inv=[(czo*syo)/cyo,(syo*szo)/cyo,1;-szo,czo,0;czo/cyo,szo/cyo,0];

% Calculate Rotation matrix (ZYX) for f(x,u,n)
R=[cyo*czo,czo*sxo*syo-cxo*szo,sxo*szo+cxo*czo*syo;
    cyo*szo,cxo*czo+sxo*syo*szo,cxo*syo*szo-czo*sxo;
    -syo,cyo*sxo,cxo*cyo];

% Create each row of f(x,u,n) with nbg, nba, ng and na as 0
f1 = x3;
f2 = G_inv * (angVel - x4);
f3 = [0;0;-9.8] + R *(acc - x5); % 9.8 is only for Z axis
f4 = zeros(3,1);
f5 = zeros(3,1);

% Concatenate all elements of f(x,u,n)
f = vertcat(f1,f2,f3,f4,f5);

% Compute the predicted state
uEst = uPrev + (dt*f);

% Separately calculate A = jacobian(f, x) and store here for computation
A=[0,0,0,0,0,0,1,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,1,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,1,0,0,0,0,0,0;
    0,0,0,0,-czo*(xNg+xBg-xOmgU)-szo*(yNg+yBg-yOmgU)-(czo*syo^2*(xNg+xBg-xOmgU))/cyo^2-(syo^2*szo*(yNg+yBg-yOmgU))/cyo^2,(syo*szo*(xNg+xBg-xOmgU))/cyo-(czo*syo*(yNg+yBg-yOmgU))/cyo,0,0,0,-(czo*syo)/cyo,-(syo*szo)/cyo,-1,0,0,0;
    0,0,0,0,0,czo*(xNg+xBg-xOmgU)+szo*(yNg+yBg-yOmgU),0,0,0,szo,-czo,0,0,0,0;
    0,0,0,0,-(czo*syo*(xNg+xBg-xOmgU))/cyo^2-(syo*szo*(yNg+yBg-yOmgU))/cyo^2,(szo*(xNg+xBg-xOmgU))/cyo-(czo*(yNg+yBg-yOmgU))/cyo,0,0,0,-czo/cyo,-szo/cyo,0,0,0,0;
    0,0,0,-(sxo*szo+cxo*czo*syo)*(yNa+yBa-yAccU)-(cxo*szo-czo*sxo*syo)*(zNa+zBa-zAccU),czo*syo*(xNa+xBa-xAccU)-cxo*cyo*czo*(zNa+zBa-zAccU)-cyo*czo*sxo*(yNa+yBa-yAccU),(cxo*czo+sxo*syo*szo)*(yNa+yBa-yAccU)-(czo*sxo-cxo*syo*szo)*(zNa+zBa-zAccU)+cyo*szo*(xNa+xBa-xAccU),0,0,0,0,0,0,-cyo*czo,cxo*szo-czo*sxo*syo,-sxo*szo-cxo*czo*syo;
    0,0,0,(czo*sxo-cxo*syo*szo)*(yNa+yBa-yAccU)+(cxo*czo+sxo*syo*szo)*(zNa+zBa-zAccU),syo*szo*(xNa+xBa-xAccU)-cxo*cyo*szo*(zNa+zBa-zAccU)-cyo*sxo*szo*(yNa+yBa-yAccU),(cxo*szo-czo*sxo*syo)*(yNa+yBa-yAccU)-(sxo*szo+cxo*czo*syo)*(zNa+zBa-zAccU)-cyo*czo*(xNa+xBa-xAccU),0,0,0,0,0,0,-cyo*szo,-cxo*czo-sxo*syo*szo,czo*sxo-cxo*syo*szo;
    0,0,0,cyo*sxo*(zNa+zBa-zAccU)-cxo*cyo*(yNa+yBa-yAccU),cyo*(xNa+xBa-xAccU)+cxo*syo*(zNa+zBa-zAccU)+sxo*syo*(yNa+yBa-yAccU),0,0,0,0,0,0,0,syo,-cyo*sxo,-cxo*cyo;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

% Compute F = I + dt * A
F = eye(15) + dt*A;

% Separately calculate U = jacobian(f, n) and store here for computation
% where n = [ng;na;nbg;nba]
U=[0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0;
    -(czo*syo)/cyo,-(syo*szo)/cyo,-1,0,0,0,0,0,0,0,0,0;
    szo,-czo,0,0,0,0,0,0,0,0,0,0;
    -czo/cyo,-szo/cyo,0,0,0,0,0,0,0,0,0,0;
    0,0,0,-cyo*czo,cxo*szo-czo*sxo*syo,-sxo*szo-cxo*czo*syo,0,0,0,0,0,0;
    0,0,0,-cyo*szo,-cxo*czo-sxo*syo*szo,czo*sxo-cxo*syo*szo,0,0,0,0,0,0;
    0,0,0,syo,-cyo*sxo,-cxo*cyo,0,0,0,0,0,0;
    0,0,0,0,0,0,1,0,0,0,0,0;
    0,0,0,0,0,0,0,1,0,0,0,0;
    0,0,0,0,0,0,0,0,1,0,0,0;
    0,0,0,0,0,0,0,0,0,1,0,0;
    0,0,0,0,0,0,0,0,0,0,1,0;
    0,0,0,0,0,0,0,0,0,0,0,1];

% Set Q as 0.01
Q = 0.01;

% Calculate Qd
Qd = dt*(eye(12) * Q);

% Calcualte predicted covariance
covarEst = (F * covarPrev * F') + (U * Qd * U');

% MY IMPLEMENTATION END ---------------------------------------------------
end

