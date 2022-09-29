clearvars 
close all

f = @(x,y) 0.01*y.^2.*exp(-0.05*x).*sqrt(x.^2+y.^2);
p = [59.5,12.2];
numNodeHintA = 35;
numElemHintB = 37;

eval('meshTwoHolesQuad')
numElem = size(elem,1);

x = nodes(:,1); y = nodes(:,2);
temp = f(x,y);  %Compute the temperature at nodes


%%% Part (a)
for e = 1:numElem
    vertexs = nodes(elem(e,:),:);
    [alphas,isInside] = baryCoordQuad(vertexs,p);
    if (isInside > 0)
        numElemPuntP = e;
        interpTempP = alphas*temp(elem(e,:)); %Interpolated temperature 
                                              %at point p
        break;
    end
end

tempP = f(p(1,1),p(1,2));
absErr = abs(interpTempP-tempP);
relErr = absErr/tempP;
tempNodHintA = f(nodes(numNodeHintA,1),nodes(numNodeHintA,2));

%Fancy output: don't try this at the exams!!! Instead, write the 
%variable's name you want to display e.g., 
%interpTempP
%without the ';' trailing 
celsiusDeg = char(176);
fprintf('--------------------------------------------------\n')
fprintf('\t\tPart (a)\n\n')
fprintf('%7s%13s%15s\n',...
    'numQuad',['T(p)(',celsiusDeg,'C)'],'RelError')
fprintf('%7d%14.5e%15.5e\n',e,interpTempP,relErr)
fprintf('\nHint: For node %d the temperature value given\n',numNodeHintA)
fprintf('by the formula (2) is: %.5e%sC.\n',tempNodHintA,celsiusDeg)

%%% Part (b)
areaElem = zeros(numElem,1);
tempElem = zeros(numElem,1);
colOnes = ones(3,1);

for e = 1:numElem
    n1 = elem(e,1);
    n2 = elem(e,2);
    n3 = elem(e,3);
    n4 = elem(e,4);
    v1 = nodes(n1,:);
    v2 = nodes(n2,:);
    v3 = nodes(n3,:);
    v4 = nodes(n4,:);
    A1 = [colOnes,[v1;v2;v3]];
    A2 = [colOnes,[v1;v3;v4]];
    areaElem(e,1) = 0.5*(det(A1)+det(A2)); 
    tempElem(e,1) = 0.25*(temp(n1)+temp(n2)+temp(n3)+temp(n4));
end

areaMax = max(areaElem);
tempMax = max(tempElem);
averagedTemp = areaElem'*tempElem/sum(areaElem);
areaElemHintB = areaElem(numElemHintB);
tempElemHintB = tempElem(numElemHintB);

fprintf('\n\t\tPart (b)\n\n')
fprintf('%-9s%14.5e\n%9s%14.5e%sC\n%9s%14.5e%sC\n',...
    'max.area',areaMax,...
    'max.temp.',tempMax,celsiusDeg,...
    'av.temp.',averagedTemp,celsiusDeg)

fprintf('\nHint: For element %d the assigned area and temp.\n',...
    numElemHintB)
fprintf('are %.5e and %.5e%sC respectively\n',...
    areaElemHintB,tempElemHintB,celsiusDeg)
fprintf('--------------------------------------------------\n')