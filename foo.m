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
plotElements(nodes, elem, numbering);
hold on
plot(p(1,1),p(1,2),'o','Marker','o','MarkerFaceColor','red',...
    'MarkerSize',10);
plot(vertexsPointP(:,1),vertexsPointP(:,2),'o','MarkerFaceColor','green',...
    'MarkerSize',7)
hold off
    
    
    

