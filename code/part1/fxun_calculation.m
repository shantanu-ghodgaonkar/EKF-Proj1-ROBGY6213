% This script has been written to compute the necessary jacobians for the
% Prediction Step of the Extended Kalaman Filter
tic
clc;
clear;

% Create Symbolic Variables for each of the elemnts of state x and 
% process model function f(x,u,n)
syms xPos yPos zPos xOrient yOrient zOrient xVel yVel zVel xBg yBg zBg xBa; 
syms yBa zBa xOmgU yOmgU zOmgU xVelU yVelU zVelU xNg yNg zNg xNa yNa zNa; 
syms nbgx nbgy nbgz nbax nbay nbaz;

% Store rotation about cartesian axes in symbolic form
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

% Create unit vectors representing the three cartesian axes
x_hat = [1;0;0];
y_hat = [0;1;0];
z_hat = [0;0;1];

% Compute parameterisation of ZYX Euler Rates by the below logic
G = simplify(horzcat( z_hat, Rz*y_hat, Rz*Ry*x_hat ));

% Compute the rotation matrix in symbolic form
R = simplify(Rz * Ry * Rx);

% Find G^-1 for f(x,u,n)
G_inv = simplify(inv(G));

% Define state vector using symbolic variables
x1 = [xPos;yPos;zPos];
x2 = [xOrient;yOrient;zOrient];
x3 = [xVel;yVel;zVel];
x4 = [xBg;yBg;zBg];
x5 = [xBa;yBa;zBa];

x = vertcat(x1,x2,x3,x4,x5);

% Create the control input vector using symbolic variables
angVel = [xOmgU;yOmgU;zOmgU];
acc = [xVelU;yVelU;zVelU];
u = vertcat(angVel, acc);

% Create the noise vector using symbolic variables
nbg = [nbgx;nbgy;nbgz];
nba = [nbax;nbay;nbaz];
ng = [xNg;yNg;zNg];
na = [xNa;yNa;zNa];
n = [ng;na;nbg;nba];

% Create the process model using the state variables and other precomputed
% vectors
f1 = x3;
f2 = G_inv*(angVel - x4 - ng);
f3 = [0;0;9.80665] + (R * (acc - x5 - na));
f4 = nbg;
f5 = nba;

fxun = vertcat(f1,f2,f3,f4,f5);

% find jacobian of f(x,u,n) with respect to x to get matrix A
A = jacobian(fxun,x);
% find jacobian of f(x,u,n) with respect to u to get matrix B
B = jacobian(fxun,u);
% find jacobian of f(x,u,n) with respect to n to get matrix U
U = jacobian(fxun,n);
toc