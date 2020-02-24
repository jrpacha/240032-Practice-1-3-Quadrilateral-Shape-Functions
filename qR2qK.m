function qR2qK(vertexsK)
% qR2qK
%
% INPUT
% vertexsK: 4x2 matrix. Each row holds a vertexs' coordinates of the 
%           quadrilateral QK, i.e. if the vertexs of the  Qk are 
%           v1 =[x1,y1], v2 = [x2,y2], and v3 = [x3,y3]; v4 = [x4,y4];
%           then vertexsK = [x1, y1; x2, y2; x3, y3; x4, y4].
%
% ACTIONS
% The user must select a point, pR, on the graphic window. If it is inside
% the reference quadrilateral, QR = [0,0;1,0;1,1;0,1], this point
% and its image, pK, on the quadrilateral defined by vertexsK, QK, are
% drawn. In this case, the vertical and horizontal lines on QR crossing at 
% pR, and the corresponding lines on QK ---that cross at pK---are shown as 
% well. Holding down the mouse button the user can drag the point pR 
% through the graphic window and therefore its image pK moves accordingly. 
% Either pR is marked outside QR at the onset or it is displaced out by 
% the user, the markers change from a circle to a square and the lines 
% crossing at the points dissapear and are replaced by a line joining pR 
% with pK. When the user stops pressing the mouse button, the motion stops 
% and the figure keeps frozen. If later on, the mouse is pressed again, 
% the former points (and lines) dissapear and the new ones show up.
%
% References:
% I've stolen the method for tracking the mouse from professor Rafael 
% Ramírez; so all the credits must go to him! 

vertexsR = [0,0;
            1,0;
            1,1;
            0,1
           ];   %vertexs of the reference quadrilateral, QR

v1 = vertexsK(1,:);
v2 = vertexsK(2,:);
v3 = vertexsK(3,:);
v4 = vertexsK(4,:);

fig = figure;
ax = axes(fig);

%Plot the reference quadrilateral QR and the quadrilateral QK
vplotR=[vertexsR;vertexsR(1,:)];
vplotK=[vertexsK;vertexsK(1,:)];
plot(vplotR(:,1),vplotR(:,2),'-','color','red');
hold on
axis equal
plot(vplotK(:,1),vplotK(:,2),'-','color','blue');
XL=xlim;  %we copy the limits of the current frame to keep it fixed
YL=ylim;
hold off

set(fig,'WindowButtonDownFcn',@startDraw)
uiwait(fig)

    function startDraw(src,~)
        cp = get(ax,'CurrentPoint');
        lambda = cp(1,1);
        mu = cp(1,2);
        pR = [lambda,mu];
        Draw;
        drawnow
        set(src,'WindowButtonMotionFcn',@moveLines) %dragging
        set(src,'WindowButtonUpFcn',@endDraw)       %mouse button released
        function moveLines(~,~)
            cp = get(ax,'CurrentPoint');
            lambda = cp(1,1);
            mu = cp(1,2);
            pR = [lambda,mu];
            Draw;
            drawnow
        end
        function endDraw(src,~)            
            set(src,'WindowButtonMotionFcn',[])
            set(src,'WindowButtonUpFcn',[])
            uiresume(fig)
        end
        function Draw
            %get the barycentric coordinates
            alpha1 = (1-lambda)*(1-mu); 
            alpha2 = lambda*(1-mu);
            alpha3 = lambda*mu;
            alpha4 = mu*(1-lambda);
            
            alphas = [alpha1,alpha2,alpha3,alpha4];
            pK = alphas*vertexsK; %compute pK, the image of the point PR
            
            q1 = (1-lambda)*v1 + lambda*v2;
            q2 = lambda*v3 + (1-lambda)*v4;
            p1 = (1-mu)*v1+mu*v4;
            p2 = (1-mu)*v2+mu*v3;
            
            lineRV = [lambda,0;
                lambda,1
                   ];
            lineRH = [0,mu;
                1,mu;
                ];
            
            lineKV = [q1;q2];
            lineKH = [p1;p2];
        
            if min(alphas) < -1.0e-10
                marker = 's';
                linepRpK = [pR;pK];
                plot(linepRpK(:,1),linepRpK(:,2),'g-')
                hold on
            else
                marker = 'o';
                plot(lineRV(:,1),lineRV(:,2),'-m');
                hold on
                plot(lineRH(:,1),lineRH(:,2),'-c');
                plot(lineKV(:,1),lineKV(:,2),'-m');
                plot(lineKH(:,1),lineKH(:,2),'-c');
            end
            
            plot(vplotR(:,1),vplotR(:,2),'-','color','blue')
            axis equal
            axis([XL,YL])
            plot(vplotK(:,1),vplotK(:,2),'-','color','red') 
            plot(pR(1,1),pR(1,2),'o','Marker',marker,...
                'MarkerFaceColor','blue','MarkerEdgeColor',...
                'black','lineWidth',1)
            plot(pK(1,1),pK(1,2),'o','Marker',marker,...
                'MarkerFaceColor','red','MarkerEdgeColor',...
                'black','lineWidth',1)
            hold off
        end
    end
end

