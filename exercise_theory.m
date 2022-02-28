clearvars
close all

v1=[0,0];
v2=[5,-1];
v3=[4,5];
v4=[1,4];

p=[3,2];
%p=[6,3];

a=v1-p;
b=v2-v1;
c=v4-v1;
d=v1-v2+v3-v4;

tol=1.0e-15;
q=[0.1;0.1]; %Initial approximation
normdq=1.0;

numIterMax=10; 
iter=0;
fprintf('iter: %3d, q = (%.14e, %.14e)\n',iter,q);

while(normdq > tol && iter < numIterMax)
    f = -(a + b*q(1) + c*q(2) + d*q(1)*q(2))';
    dq = [b(1)+d(1)*q(2), c(1)+d(1)*q(1);
     b(2)+d(2)*q(2), c(2)+d(2)*q(1)]\f;
    normdq=norm(dq);
    q = q+dq;
    iter = iter+1;
    fprintf('iter: %3d, q = (%.14e, %.14e), |dq| = %.5e\n',iter,q,norm(dq));
end

if (iter == numIterMax)
    fprintf('No convergence in %d iterations\n',numIterMax);
else
    alphas=[(1-q(1))*(1-q(2)),q(1)*(1-q(2)),q(1)*q(2),q(2)*(1-q(1))];
    fprintf('\nBarycantric coordinates of point P: alphas = (%f, %f %f %f):\n',...
        alphas)
end
        
%Plot quadrilaterals
vKplot=[v1;v2;v3;v4;v1];
vRplot=[0,0;1,0;1,1;0,1;0,0];
lineR = [q';p];
plot(vRplot(:,1),vRplot(:,2),'-b')
axis equal
hold on
plot(vKplot(:,1),vKplot(:,2),'-r')
plot(lineR(:,1),lineR(:,2),'-o','markerFaceColor','green')
hold off

        



 
    
     


