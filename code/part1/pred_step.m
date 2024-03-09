function [covarEst,uEst] = pred_step(uPrev,covarPrev,angVel,acc,dt)
%covarPrev and uPrev are the previous mean and covariance respectively
%angVel is the angular velocity
%acc is the acceleration
%dt is the sampling time

% MY IMPLEMENTATION START -------------------------------------------------
xPos = uPrev(1,1);
yPos = uPrev(2,1);
zPos = uPrev(3,1);
xOrient = uPrev(4,1);
yOrient = uPrev(5,1);
zOrient = uPrev(6,1);
xVel = uPrev(7,1);
yVel = uPrev(8,1);
zVel = uPrev(9,1);
xBg = uPrev(10,1);
yBg = uPrev(11,1);
zBg = uPrev(12,1);
xBa = uPrev(13,1);
yBa = uPrev(14,1);
zBa = uPrev(15,1);
xOmgU = angVel(1,1);
yOmgU = angVel(2,1);
zOmgU = angVel(3,1);
xVelU = acc(1,1);
yVelU = acc(2,1);
zVelU = acc(3,1);



%
%
% B=[0,0,0,0,0,0;0,0,0,0,0,0;0,0,0,0,0,0;-(cos(yOrient)*cos(zOrient))/sin(yOrient),-(cos(yOrient)*sin(zOrient))/sin(yOrient),1,0,0,0;-sin(zOrient),cos(zOrient),0,0,0,0;cos(zOrient)/sin(yOrient),sin(zOrient)/sin(yOrient),0,0,0,0;0,0,0,cos(yOrient)*cos(zOrient),cos(zOrient)*sin(xOrient)*sin(yOrient)-cos(xOrient)*sin(zOrient),sin(xOrient)*sin(zOrient)+cos(xOrient)*cos(zOrient)*sin(yOrient);0,0,0,cos(yOrient)*sin(zOrient),cos(xOrient)*cos(zOrient)+sin(xOrient)*sin(yOrient)*sin(zOrient),cos(xOrient)*sin(yOrient)*sin(zOrient)-cos(zOrient)*sin(xOrient);0,0,0,-sin(yOrient),cos(yOrient)*sin(xOrient),cos(xOrient)*cos(yOrient);0,0,0,0,0,0;0,0,0,0,0,0;0,0,0,0,0,0;0,0,0,0,0,0;0,0,0,0,0,0;0,0,0,0,0,0];

x1 = [xPos;yPos;zPos];
x2 = [xOrient;yOrient;zOrient];
x3 = [xVel;yVel;zVel];
x4 = [xBg;yBg;zBg];
x5 = [xBa;yBa;zBa];
x = vertcat(x1,x2,x3,x4,x5);

sxo = sin(xOrient);
syo = sin(yOrient);
szo = sin(zOrient);
cxo = cos(xOrient);
cyo = cos(yOrient);
czo = cos(zOrient);


G_inv = [-(cyo*czo)/syo, -(cyo*szo)/syo, 1;-szo,czo, 0;czo/syo,szo/syo, 0];
R = [cyo*czo, czo*sxo*syo - cxo*szo, sxo*szo + cxo*czo*syo;
    cyo*szo, cxo*czo + sxo*syo*szo, cxo*syo*szo - czo*sxo;
    -syo, cyo*sxo, cxo*cyo];

f1 = x3;
f2 = G_inv * (angVel - x4);
f3 = 9.8 + R *(acc - x5); % 9.8 is only for Z axis
f4 = zeros(3,1); % CHANGE THIS
f5 = zeros(3,1); % CHANGE THIS

f = vertcat(f1,f2,f3,f4,f5);
uEst = uPrev + (dt*f);

A=[0,0,0,0,0,0,1,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,1,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,1,0,0,0,0,0,0;0,0,0,0,-czo*(xBg-xOmgU)-szo*(yBg-yOmgU)-(cyo^2*czo*(xBg-xOmgU))/syo^2-(cyo^2*szo*(yBg-yOmgU))/syo^2,(cyo*czo*(yBg-yOmgU))/syo-(cyo*szo*(xBg-xOmgU))/syo,0,0,0,(cyo*czo)/syo,(cyo*szo)/syo,-1,0,0,0;0,0,0,0,0,czo*(xBg-xOmgU)+szo*(yBg-yOmgU),0,0,0,szo,-czo,0,0,0,0;0,0,0,0,(cyo*czo*(xBg-xOmgU))/syo^2+(cyo*szo*(yBg-yOmgU))/syo^2,(szo*(xBg-xOmgU))/syo-(czo*(yBg-yOmgU))/syo,0,0,0,-czo/syo,-szo/syo,0,0,0,0;0,0,0,-(sxo*szo+cxo*czo*syo)*(yBa-yVelU)-(cxo*szo-czo*sxo*syo)*(zBa-zVelU),czo*syo*(xBa-xVelU)-cxo*cyo*czo*(zBa-zVelU)-cyo*czo*sxo*(yBa-yVelU),(cxo*czo+sxo*syo*szo)*(yBa-yVelU)-(czo*sxo-cxo*syo*szo)*(zBa-zVelU)+cyo*szo*(xBa-xVelU),0,0,0,0,0,0,-cyo*czo,cxo*szo-czo*sxo*syo,-sxo*szo-cxo*czo*syo;0,0,0,(czo*sxo-cxo*syo*szo)*(yBa-yVelU)+(cxo*czo+sxo*syo*szo)*(zBa-zVelU),syo*szo*(xBa-xVelU)-cxo*cyo*szo*(zBa-zVelU)-cyo*sxo*szo*(yBa-yVelU),(cxo*szo-czo*sxo*syo)*(yBa-yVelU)-(sxo*szo+cxo*czo*syo)*(zBa-zVelU)-cyo*czo*(xBa-xVelU),0,0,0,0,0,0,-cyo*szo,-cxo*czo-sxo*syo*szo,czo*sxo-cxo*syo*szo;0,0,0,cyo*sxo*(zBa-zVelU)-cxo*cyo*(yBa-yVelU),cyo*(xBa-xVelU)+cxo*syo*(zBa-zVelU)+sxo*syo*(yBa-yVelU),0,0,0,0,0,0,0,syo,-cyo*sxo,-cxo*cyo;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
F = eye + dt*A;
U=[0,0,0,0,0,0;0,0,0,0,0,0;0,0,0,0,0,0;(cyo*czo)/syo,(cyo*szo)/syo,-1,0,0,0;szo,-czo,0,0,0,0;-czo/syo,-szo/syo,0,0,0,0;0,0,0,-cyo*czo,cxo*szo-czo*sxo*syo,-sxo*szo-cxo*czo*syo;0,0,0,-cyo*szo,-cxo*czo-sxo*syo*szo,czo*sxo-cxo*syo*szo;0,0,0,syo,-cyo*sxo,-cxo*cyo;0,0,0,0,0,0;0,0,0,0,0,0;0,0,0,0,0,0;0,0,0,0,0,0;0,0,0,0,0,0;0,0,0,0,0,0];
Q = dt*(eye(6,6) * 0.01);
covarEst = (F * covarPrev * F') + (U * Q * U');

% MY IMPLEMENTATION END ---------------------------------------------------

end

