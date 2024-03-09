tic
clc;
clear;
syms xPos yPos zPos xOrient yOrient zOrient xVel yVel zVel xBg yBg zBg xBa yBa zBa xOmgU yOmgU zOmgU xVelU yVelU zVelU ngx ngy ngz nax nay naz;
syms xPosM yPosM zPosM xOrientM yOrientM zOrientM;
x1 = [xPos;yPos;zPos];
x2 = [xOrient;yOrient;zOrient];
x3 = [xVel;yVel;zVel];
x4 = [xBg;yBg;zBg];
x5 = [xBa;yBa;zBa];

% x = [x1;x2;x3;x4;x5];
x = vertcat(x1,x2,x3,x4,x5);
z = vertcat(x1,x2);
g = [xPos;yPos;zPos;xOrient;yOrient;zOrient];

C = horzcat(eye(6), zeros(6,9));
toc