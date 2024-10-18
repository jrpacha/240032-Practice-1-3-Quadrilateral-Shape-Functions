clearvars
close all

p = [39.0,7.0];

eval('meshTwoHolesQuad')

numNodes = size(nodes,1);
numElem = size(elem,1);

for e = 1:numElem
    n1 = elem(e,1);
    n2 = elem(e,2);
    n3 = elem(e,3);  
    n4 = elem(e,4);   %Nodes of element e
    v1 = nodes(n1,:);
    v2 = nodes(n2,:);
    v3 = nodes(n3,:); 
    v4 = nodes(n4,:); %Vertexs of element e
    vertexs = [v1;v2;v3;v4];
    [alphas, isInside]=baryCoordQuad(vertexs, p);
    if isInside >= 1
        % Interpolate the temperature at point p
        elemPointP = e;
        nodesElemPointP = [n1,n2,n3,n4];
        vertexsPointP = vertexs;
        break;
    end
end

fprintf('Element: %d\n',elemPointP);
fprintf('Vertices:\n\t%4s%17s\n','x','y');
fprintf('%16.5e%18.5e\n',vertexsPointP');

%plotElements(nodes, elem, numbering);
numbering = 0;
plotElementsOld(nodes, elem, numbering);
hold on
plot(p(1,1),p(1,2),'o','Marker','o','MarkerFaceColor','red',...
    'MarkerSize',8);
plot(vertexsPointP(:,1),vertexsPointP(:,2),'o','MarkerFaceColor','green',...
    'MarkerSize',6)
hold off

%Isoparametric function
r = [0.25, 0.5]; %point on the standard quadrilateral

%Shape functions on the standard quadrilateral R
Psi1 = @(x,y) (1-x).*(1-y);
Psi2 = @(x,y) x.*(1-y);
Psi3 = @(x,y) x.*y;
Psi4 = @(x,y) (1-x).*y;

%Standard quadrilateral
vertexsR = [0, 0; 1, 0; 1, 1; 0, 1];
vertexsRPlot = [vertexsR; vertexsR(1,:)];

%Quadrilateral Q
vertexsQ = [0,0; 5,-1; 4, 5; 1, 4];
vertexsQPlot = [vertexsQ; vertexsQ(1,:)];

figure()
plot(vertexsRPlot(:,1), vertexsRPlot(:,2),'-r')
hold on
axis equal
plot(r(1,1),r(1,2),'o','Marker','o','MarkerFaceColor','blue');
hold off

alphas = [Psi1(r(1,1),r(1,2)),...
    Psi2(r(1,1),r(1,2)),...
    Psi3(r(1,1),r(1,2)),...
    Psi4(r(1,1),r(1,2))];

p = alphas*vertexsQ; %Point on the quadrilateral Q

figure()
plot(vertexsQPlot(:,1), vertexsQPlot(:,2),'-b')
axis equal
hold on
plot(p(1,1),p(1,2),'o','Marker','o','MarkerFaceColor','red');
hold off