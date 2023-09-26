clearvars
close all

vertexs = [
    0, 0; 
    5,-1; 
    4, 5; 
    1, 4
    ];

vertexsPlot = [vertexs; vertexs(1,:)];

elem = [1,2,3,4];

vertexsR = [
    0, 0;
    1, 0;
    1, 1;
    0, 1;
    ]

vertexsRPlot = [vertexsR; vertexsR(1,:)];

p = [3, 4];
%p = [6,2];

a = vertexs(1,:)-p;
b = vertexs(2,:)-vertexs(1,:);
c = vertexs(4,:)-vertexs(1,:);
d = vertexs(1,:)-vertexs(2,:)+vertexs(3,:)-vertexs(4,:);

a = a'; b = b'; c = c'; d = d';

z = [0.5,0.5];

f = @(x,y) a + x*b + y*c + x*y*d; 
df = @(x,y) [b+y*d, c+x*d];

z = [0.1;0.1];

format short e  
%% Iter 1
x = z(1); y = z(2);
dz = -df(x,y)\f(x,y);
z = z + dz;
fprintf("Iterat-1: ")
[z,dz]

%% Iter 2
x = z(1); y = z(2);
dz = -df(x,y)\f(x,y)
z = z + dz;
fprintf("Iterat-2: ")
[z,dz]
%% Iter 3
x = z(1); y = z(2);
dz = -df(x,y)\f(x,y)
z = z + dz;
fprintf("Iterat-3: ")
[z,dz]
%% Iter 4
x = z(1); y = z(2);
dz = -df(x,y)\f(x,y)
z = z + dz;
fprintf("Iterat-4: ")
[z,dz]
%% Iter 5
x = z(1); y = z(2);
dz = -df(x,y)\f(x,y)
z = z + dz;
fprintf("Iterat-5: ")
[z,dz]
%% Iter 6
x = z(1); y = z(2);
dz = -df(x,y)\f(x,y)
z = z + dz;
fprintf("Iterat-5: ")
[z,dz]

%% Barycententric coords
x = z(1); y=z(2);
alphas = [(1-x)*(1-y), x*(1-y), x*y, y*(1-x)]

% Plots
subplot(1,2,1)
%plotElementsOld(vertexsR, elem, 1)
plot(vertexsR(:,1), vertexsR(:,2),'o',...
    'MarkerFaceColor','blue',...
    'MarkerSize', 5)
axis('equal')
hold on
plot(vertexsRPlot(:,1), vertexsRPlot(:,2), '-',...
    'Color', 'blue')
plot(z(1,:),z(2,:),'o',...
    'MarkerFaceColor','blue',...
    'MarkerSize',6)
xlabel('$\lambda$','Interpreter','latex')
ylabel('$\mu$','Interpreter','latex')
hold off
subplot(1,2,2)
%plotElementsOld(vertexs, elem, 1)
plot(vertexs(:,1), vertexs(:,2),'o',...
    'MarkerFaceColor','red',...
    'MarkerSize', 5)
axis('equal')
hold on
plot(vertexsPlot(:,1), vertexsPlot(:,2), '-',...
    'Color','red')
plot(p(:,1),p(:,2),'o','MarkerFaceColor','red',...
    'MarkerSize',6)
xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')
hold off


