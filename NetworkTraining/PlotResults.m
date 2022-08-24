%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPML111
% Project Title: Growing Neural Gas Network in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function PlotResults(X, nodes, edges, fileID, flag)

    N = size(nodes,1);
    %edgesPoint1 = [];
    %edgesPoint2 = [];
    
    for i = 1: N
        if flag(i)==1
            plot(X(i,1),X(i,2),'.');
        end
    end
    
    hold on;
    for i=1:N-1
        %count = 0;
        for j=i:N
            
            if edges(i,j)==1 && flag(i) == 1 && flag(j) == 1 

                
                plot([nodes(i,1) nodes(j,1)],[nodes(i,2) nodes(j,2)],'r','LineWidth',2); % Plot([x],[y])
  
                %if count == 0
                    fprintf(fileID,'Connection(%d,%d) = 1\n',i,j);
                    fprintf(fileID,'Connection(%d,%d) = 1\n',j,i);
                %    disp([i,j])
                %    count = count +1;
                %end

                %edgesPoint1(j,:) = [nodes(i,1) nodes(i,2)]; % Point1(x,y)
                %edgesPoint2(j,:) = [nodes(j,1) nodes(j,2)]; % Point2(x,y)
            end
        end
    end
    
    for i=1:N
        if flag(i) == 1 
            plot(nodes(i,1),nodes(i,2),'ko','MarkerFaceColor','y','MarkerSize',3);
        end
    end

    %edgesTable = table(edgesPoint1,edgesPoint2);
    %writetable(edgesTable,'edgesRoom4.txt');

    %nodesTable = table(nodes(:,1),nodes(:,2)); % all points in column1 (x), all points in column2 (y)
    %writetable (nodesTable,'nodesRoom4.txt');

    %hold off;
    %axis equal;
    %grid on;
    
    
    
        
    
end