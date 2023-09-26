clearvars 
close all

% Part (A)
% Compute the 2D coordinates of the point P=(x,y) in the mesh defined 
% in the file meshTwoHolesQuad.m if it belongs to the element 294 and 
% its barycentric coordinates are [0.2,0.2,0.3,0.3].

eval('meshTwoHolesQuad')
e = 294;
alphas = [0.2,0.2,0.3,0.3];

nod1 = elem(e,1); nod2 = elem(e,2); nod3 = elem(e,3); nod4 = elem(e,4);
v1 = nodes(nod1,:); v2 = nodes(nod2,:); v3 = nodes(nod3,:); v4 = nodes(nod4,:); 

p = alphas(1) * v1 + alphas(2) * v2 + alphas(3) * v3 + alphas(4) * v4;

fprintf('\t\tPart (A)\nP = (%.8e, %.8e)\n',p)



p = alphas*nodes(elem(e,:),:);

fprintf('\t\tPart (A)\nP = (%.8e, %.8e)\n',p)

% Part (B)
% Interpolate the value of the temperature at the point P=(40.0,15.4) in 
% the mesh defined by the file meshTwoHolesQuad.m when we assign the value
% on the nodes equal to their global number (as in the practices).

p = [40.0,15.4];

numNodes = size(nodes, 1);
numElem = size(elem,1);

temp = (1:numNodes)';

%First, plot the mesh and the point
plotElementsOld(nodes, elem, 0)
hold on
plot(p(:,1), p(:,2), 'o', 'MarkerFaceColor', 'red', 'MarkerSize',6)
hold off

%Interpolation

for e = 1:numElem

    % nod1 = elem(e,1); nod2 = elem(e,2); nod3 = elem(e,3); nod4 = elem(e,4);
    % v1 = nodes(nod1,:); v2 = nodes(nod2,:); v3 = nodes(nod3,:); v4 = nodes(nod4,:);
    %vertexs = [v1; v2; v3; v4];

    nods = elem(e, :);
    vertexs = nodes(nods, :);    
    [alphas, isInside] = baryCoordQuad(vertexs,p);

    if (isInside > 0)

        % interpTemp = alphas(1) * temp(nod1) + ...
        %     alphas(2) * temp(nod2) + ...
        %     alphas(3) * temp(nod3) + ...
        %     alphas(4) * temp(nod4);

        interpTempP = alphas * temp(nods);
        fprintf('p belongs to element %d\n', e)
        fprintf('Nodes: %d, %d, %d %d\n', nod1, nod2, nod3, nod4)
        fprintf('Vertexs:\n')
        fprintf('\t%10.4f%10.4f\n',vertexs')
        fprintf('Interpolated temperature at point p = (%.2f, %.2f): %.2f%sC\n',...
                 p, interpTempP,char(176))
        break;
    end
end



