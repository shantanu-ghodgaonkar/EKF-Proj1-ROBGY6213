tic
clc;
clear;
syms xPos yPos zPos xOrient yOrient zOrient xVel yVel zVel xBg yBg zBg xBa yBa zBa xOmgU yOmgU zOmgU xVelU yVelU zVelU ngx ngy ngz nax nay naz;

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


G = simplify(horzcat( z_hat, Rz*y_hat, Rz*Ry*z_hat ));
R = simplify(Rz * Ry * Rx);
G_inv = simplify(inv(G));


x1 = [xPos;yPos;zPos];
x2 = [xOrient;yOrient;zOrient];
x3 = [xVel;yVel;zVel];
x4 = [xBg;yBg;zBg];
x5 = [xBa;yBa;zBa];

% x = [x1;x2;x3;x4;x5];
x = vertcat(x1,x2,x3,x4,x5);

ng = [ngx;ngy;ngz];
na = [nax;nay;naz];

n = vertcat(ng,na);

angVel = [xOmgU;yOmgU;zOmgU];
acc = [xVelU;yVelU;zVelU];
u = vertcat(angVel, acc);

f1 = x3;
f2 = G_inv*(angVel - x4 - ng);
f3 = 9.80665 + (R * (acc - x5 - na));
f4 = diff(x4);
f5 = diff(x5);

fxun = vertcat(f1,f2,f3,f4,f5);

A = jacobian(fxun,x);
B = jacobian(fxun,u);
U = jacobian(fxun,n);
toc