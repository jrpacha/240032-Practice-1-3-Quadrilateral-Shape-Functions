clearvars
close all

p = [4.1,1];

vertexsK = [
   2,0;
   4.75,-0.75;
   4.5,2;
   2.5,1.5]; %vertexs of the quadrilateral K

vertexsR = [0,0;
         1,0;
         1,1;
         0,1];
     
numFrames = 101;     
     
[alphas,isInside] = baryCoordQuad(vertexsK,p);
lambdaP = alphas(2) + alphas(3);
muP = alphas(3) + alphas(4);

lambda = linspace(0,lambdaP,101);
mu = linspace(0,muP,101);
numPoints = size(lambda,2);

plotK = [vertexsK;
    vertexsK(1,:)];

plotR = [vertexsR;
    vertexsR(1,:)];

v1 = vertexsK(1,:);
v2 = vertexsK(2,:);
v3 = vertexsK(3,:);
v4 = vertexsK(4,:);

v = VideoWriter('isoparametricMap.avi','Motion JPEG AVI');
v.Quality = 85;
open(v);

titleHead = {['$\bullet$ Pre-image of point $P = ($',num2str(p(1,1)),', ',...
    num2str(p(1,2)),'$)\in\Omega^{K}$ on $\Omega^{R}$: '],...
    ['$\hspace{\parindent}\hat{P} = (\bar{\lambda},\bar{\mu}) = ($',...
    num2str(lambdaP),', ',num2str(muP),'$)$'],...
    ['$\bullet$ Barycentric coordinates of $P:$'],...
    ['$\hspace{\parindent}\alpha = (\alpha_{1}, \alpha_{2}, ',...
     '\alpha_{3}, \alpha_{4}) = ($',...
     num2str(alphas(1)),', ',...
     num2str(alphas(2)),', ',...
     num2str(alphas(3)),', ',...
     num2str(alphas(4)),'$)$']};
sgtitle(titleHead,'interpreter','LaTeX','horizontalAlignment','left',...
    'fontSize',12);

for i = 1:numPoints
    subplot(1,2,1)
    
    %Square R
    plot(plotR(:,1),plotR(:,2),'-b');
    title('Reference square $\Omega^{R} = [0,1]\times [0,1]$',...
        'interpreter','LaTeX','fontSize',10)
    hold on
    axis equal
    axis([-0.4,1.3,-0.3,1.2])
  
    %Vertcal line RS
    plot([lambda(i);lambda(i)],[0;1],'-o','markerFaceColor','black',...
        'markerSize',6,'color','red','lineWidth',1.5) 
    text(lambda(i),-0.15,'$R$','interpreter','LaTeX','fontSize',12)
    text(lambda(i),1.1,'$S$','interpreter','LaTeX','fontSize',12)
    
    %Horizontal line MN
    plot([0;1],[mu(i);mu(i)],'-o','markerFaceColor','black',...
        'markerSize',6,'color','green','lineWidth',1.5)
    text(-0.2,mu(i),'$M$','interpreter','LaTeX','fontSize',12)
    text(1.1,mu(i),'$N$','interpreter','LaTeX','fontSize',12)
         
    if i == numPoints
        text(lambda(i)-0.2,mu(i)+0.1,'$\hat{P}$','interpreter','LaTeX',...
            'fontSize',12)
        plot(lambda(i),mu(i),'o','markerFaceColor','black','markerSize',6)
        xlabel(['$\bar{\lambda} = $',num2str(lambda(i))],...
            'interpreter','LaTeX','fontSize',10)
        ylabel(['$\bar{\mu} = $',num2str(mu(i))],'interpreter','LaTeX',...
        'fontSize',10)
    else
        xlabel(['$\lambda = $',num2str(lambda(i))],'interpreter','LaTeX',...
        'fontSize',10)
          ylabel(['$\mu = $',num2str(mu(i))],'interpreter','LaTeX',...
        'fontSize',10) 
    end
    %pause(0.01)
    
    drawnow
    hold off
    
    subplot(1,2,2)
    
    %Rectangle K
    plot(plotK(:,1),plotK(:,2),'-b');
    title('Quadrilateral $\Omega^{K}$','interpreter','LaTeX',...
        'fontSize',10)
    hold on
    axis equal
    axis([1.4 5.4,-1.1,2.5])
    xlabel('$x$','interpreter','LaTeX','fontSize',12)
    ylabel('$y$','interpreter','LaTeX','fontSize',12)
    %Line R'S'
    R = (1-lambda(i))*v1+lambda(i)*v2;
    S = lambda(i)*v3 + (1-lambda(i))*v4;
    lineRS = [R;S];
    plot(lineRS(:,1),lineRS(:,2),'-o','markerFaceColor','black',...
        'markerSize',6,'color','red','lineWidth',1.5)
    text(R(1),R(2)-0.3,'$R''$','interpreter','LaTeX','fontSize',12)
    text(S(1),S(2)+0.2,'$S''$','interpreter','LaTeX','fontSize',12)
    %Line R'P
    lineRP = [R;p];    
    plot(lineRP(:,1),lineRP(:,2),'-o','markerFaceColor','black',...
        'markerSize',6,'color','red')
    %Line M'N'
    M = (1-mu(i))*v1+mu(i)*v4;
    N = (1-mu(i))*v2+mu(i)*v3;
    lineMN = [M;N];
    plot(lineMN(:,1),lineMN(:,2),'-o','markerFaceColor','black',...
        'markerSize',6,'color','green','lineWidth',1.5)
    text(M(1)-0.6,M(2),'$M''$','interpreter','LaTeX','fontSize',12)
    text(N(1)+0.1,N(2),'$N''$','interpreter','LaTeX','fontSize',12)
    %Line M'p
    lineMP = [M;p];
    plot(lineMP(:,1),lineMP(:,2),'-o','markerFaceColor','black',...
        'markerSize',6,'color','green')
    %Point P
    text(p(1,1)+0.1,p(1,2)+0.2,'$P$','interpreter','LaTeX','fontSize',12)
    drawnow
    %pause(0.01)
    thisFrame = getframe(gcf);
    writeVideo(v,thisFrame);
    hold off
end

close(v)