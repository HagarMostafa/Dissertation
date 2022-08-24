function [RouteSolution] = findPath(R,nodes,connections,numOfNodes,startPointIdx,goalPointIdx,maxIterations,plotting,flags)
pathNodesCount = 1;
RouteSolution =[];

vinit=zeros(1,numOfNodes)';
currentPoint = startPointIdx;

for it=1:maxIterations
    mvp=wijvjmax(vinit,connections,numOfNodes)  ;           %needed to compute future rewards
    temp=0.6*(-vinit+R'+mvp') ;                             %Value field update 
    vinit=vinit+temp;   

    RouteSolution(pathNodesCount)=currentPoint ;
    R(currentPoint) = 0;
    if(plotting) && flags(currentPoint) == 1
        plot(nodes(currentPoint,2),nodes(currentPoint,1),'marker','.','markersize',25,'markeredgecolor','b') ;
        hold on
    end

    
    
    
    fprintf(" plot point at( %0.4f , %0.4f) idx = %d  \n",nodes(currentPoint,1),nodes(currentPoint,2),currentPoint)
    
    nextPoint=NearNeigh(vinit,connections,currentPoint,numOfNodes);  %From the max active state, find neighbour that holds maximum value
    
    if(nextPoint == 0)
        fprintf('stoped because of an error \n')
        break
    end
    
    if(connections(nextPoint,currentPoint) == 0)
        fprintf('error in the code not connected \n')
    end
    
    currentPoint=nextPoint;

    if(dist(nodes(currentPoint,:),nodes(goalPointIdx,:)')<10)
        fprintf("quiting reached the goal ")
        break
    end
    pathNodesCount=pathNodesCount+1;
end
%zer=VFDPlotAdaps(nodes,connections,vinit);
end