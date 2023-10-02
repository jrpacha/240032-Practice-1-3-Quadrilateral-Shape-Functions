clearvars 
close all

p = [39.0, 7.0];

eval('meshTwoHolesQuad');

numNodes = size(nodes,1);
numElem = size(elem,1);

temp = (1:numNodes)'; %node 1 at temperature 1,
                      %node 2 at temperature 2,
                      %node 3 at temperature 3, ...
                      %node numNodes at temperature numNodes
                      %(just an example)

plotElementsOld(nodes, elem, 0);
hold on

for e = 1:numElem
    nod1 = elem(e,1); nod2 = elem(e,2); nod3 = elem(e,3); nod4 = elem(e,4);
    v1 = nodes(nod1,:); v2 = nodes(nod2,:); v3 = nodes(nod3,:); v4 = nodes(nod4,:);
    vertexs = [v1; v2; v3; v4];
    [alphas, isInside] = baryCoordQuad(vertexs, p);
    if isInside > 0
        interpTemp = alphas(1) * temp(nod1) + ...
            alphas(2) * temp(nod2) + ...
            alphas(3) * temp(nod3) + ...
            alphas(4) * temp(nod4);
         fprintf('Point:    p = (%.2f,%.2f)\n',p)
         fprintf('Element:  e = %d\n', e)
         fprintf('Nodes:    %d, %d, %d, %d\n', nod1, nod2, nod3, nod4)
         fprintf('Vertexs:\n%14s%10s\n','X','Y')
         fprintf('%17.4f%10.4f\n',vertexs')
         fprintf('\nInterpolated temperature et point p, T = %.4f%cC\n', ...
             interpTemp,char(176))
         plot(p(1),p(2),'o',...
             'Marker','o',...
             'MarkerFaceColor','red',...
             'MarkerSize',5)
         plot(vertexs(:,1),vertexs(:,2),'o',...
             'Marker','o',...
             'MarkerFaceColor','blue',...
             'MarkerSize',3.5)
         hold off
         break
    end
end

