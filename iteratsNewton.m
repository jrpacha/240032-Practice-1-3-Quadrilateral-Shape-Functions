clearvars
close all
%clc

format long e
format compact

p=[3 2];
v1=[0 0];
v2=[5 -1];
v3=[4 5];
v4=[1 4];

% define the previous notation
a=(v1-p);
b=v2-v1;
c=v4-v1;
d=v1-v2-v4+v3;

a=a'; b=b'; c=c'; d=d';

F=@(z) a + b*z(1) + c*z(2) + d*z(1).*z(2);
DF = @(z) [b+d*z(2), c+d*z(1)];


% % Starting point
z0 = [0.1;0.1];
z = z0
% % Iterat-1
% deltaZ = -DF(z)\F(z)
% z = z + deltaZ
% 
% % Iterat-2
% deltaZ = -DF(z)\F(z)
% z = z + deltaZ
% 
% % Iterat-3
% deltaZ = -DF(z)\F(z)
% z = z + deltaZ
% 
% % Iterat-4
% deltaZ = -DF(z)\F(z)
% z = z + deltaZ
% 
% % Iterat-5
% deltaZ = -DF(z)\F(z)
% z = z + deltaZ
% 
% % Iterat-6
% deltaZ = -DF(z)\F(z)
% z = z + deltaZ
% 
tol = 1.0e-14;
deltaZ = ones(2,1);
iter = 0;
while (norm(deltaZ) > tol && iter < 20)
    deltaZ = -DF(z)\F(z);
    z = z + deltaZ;
    iter = iter + 1;
    %fprintf('iterat: %d\n',iter)
    %fprintf('|deltaZ| = %22.14e\n',norm(deltaZ))
    fprintf('iterat: %d, lambda = %22.14e, mu = %22.14e, |deltaZ| = %22.14e\n',...
        iter,z(1),z(2),norm(deltaZ));
end



