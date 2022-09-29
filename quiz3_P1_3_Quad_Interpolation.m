clearvars 
close all

% Part (A)
% Compute the 2D coordinates of the point P=(x,y) in the mesh defined 
% in the file meshTwoHolesQuad.m if it belongs to the element 294 and 
% its barycentric coordinates are [0.2,0.2,0.3,0.3].

eval('meshTwoHolesQuad')
e = 294;
alphas = [0.2,0.2,0.3,0.3];
p = alphas*nodes(elem(e,:),:);

fprintf('\t\tPart (A)\nP = (%.8e, %.8e)\n',p)

% Part (B)
% Interpolate the value of the temperature at the point P=(40.0,15.4) in 
% the mesh defined by the file meshTwoHolesQuad.m when we assign the value
% on the nodes equal to their global number (as in the practices).

p = [40.0,15.4];
numElem = size(elem,1);

for e = 1:numElem
    vertexs = nodes(elem(e,:),:);
    [alphas,isInside] = baryCoordQuad(vertexs,p);
    if (isInside > 0)
        break;
    end
end

interpTempP = elem(e,:)*alphas';
fprintf('\t\tPart (B)\n')
fprintf('Interpolated temperature at point P = (%f, %f): %.8e%sC\n',...
    p, interpTempP,char(176))