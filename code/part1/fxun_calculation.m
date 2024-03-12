tic
clc;
clear;
syms xPos yPos zPos xOrient yOrient zOrient xVel yVel zVel xBg yBg zBg xBa yBa zBa xOmgU yOmgU zOmgU xVelU yVelU zVelU xNg yNg zNg xNa yNa zNa;

Rx = [ 1, 0, 0;
    0, cos(xOrient), -sin(xOrient); 
    0, sin(xOrient), cos(xOrient); 
];
Ry = [ cos(yOrient), 0, sin(yOrient); 
    0, 1, 0; 
    -sin(yOrient), 0, cos(yOrient);
];
Rz = [ cos(zOrient), -sin(zOrient), 0;
    sin(zOrient), cos(zOrient), 0;
    0, 0, 1;
];

x_hat = [1;0;0];
y_hat = [0;1;0];
z_hat = [0;0;1];


G = simplify(horzcat( z_hat, Rz*y_hat, Rz*Ry*x_hat ));
R = simplify(Rz * Ry * Rx);
G_inv = simplify(inv(G));


x1 = [xPos;yPos;zPos];
x2 = [xOrient;yOrient;zOrient];
x3 = [xVel;yVel;zVel];
x4 = [xBg;yBg;zBg];
x5 = [xBa;yBa;zBa];

% x = [x1;x2;x3;x4;x5];
x = vertcat(x1,x2,x3,x4,x5);



% ng = zeros(3,1);
% na = zeros(3,1);
syms nbgx nbgy nbgz nbax nbay nbaz
% n = [nXPos;nYPos;nZPos;nXOrient;nYOrient;nZOrient;nXVel;nYVel;nZVel;ng;na];

angVel = [xOmgU;yOmgU;zOmgU];
acc = [xVelU;yVelU;zVelU];
u = vertcat(angVel, acc);
nbg = [nbgx;nbgy;nbgz];
nba = [nbax;nbay;nbaz];
ng = [xNg;yNg;zNg];
na = [xNa;yNa;zNa];
n = [ng;na;nbg;nba];

f1 = x3;
f2 = G_inv*(angVel - x4 - ng);
f3 = [0;0;9.80665] + (R * (acc - x5 - na));
f4 = nbg;
f5 = nba;

fxun = vertcat(f1,f2,f3,f4,f5);

A = jacobian(fxun,x);
B = jacobian(fxun,u);
U = jacobian(fxun,n);
toc