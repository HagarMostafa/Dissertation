clear all
clc
close all

% running parameters
connectionsFileName =  'cAll.txt';
nodesFileName = 'wAll.txt';

startPointIdx = 300;
goalPointIdx = 1430;


plotting = true;
debugging = true;
switchPlotAxis = true;

maxIterations = 1000;

%reward parameter
rewardGain = 50.64;       %50.64;
rewardDumping = 320;      %230;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Reading the network connection and nodes
connections = load(connectionsFileName);
nodes = load(nodesFileName);

numOfNodes = size(connections,1);
fprintf('there are %d nodes in the network \n',numOfNodes)




if(plotting)
    fprintf('plotting the nodes and connections \n')
    figure(1)
    plotNodes(nodes,switchPlotAxis)
    plotConnections(nodes,connections,switchPlotAxis)
end

%getting the position of the goal and the starting location

%Goal=[nodes(goalPointIdx,1) nodes(goalPointIdx,2)];
%Start=[nodes(startPointIdx,1) nodes(startPointIdx,2)];

Start=[-326 1581];
Goal=[170 3608];

fprintf("starting point is ( %0.3f , %0.3f )\n",Start(1),Start(2))
fprintf("goal point is ( %0.3f , %0.3f )\n",Goal(1),Goal(2))

icontt=1;

vinit=zeros(1,numOfNodes)';
xinit=zeros(1,numOfNodes)';




% creating distribution around the start to get the start point idx
for i=1:numOfNodes
    distFromStart=dist(nodes(i,:),Start');
    expDistributionFromStart(i)=(5.64)*exp(-(distFromStart)/100);
end
[ignoreVal , startPointIdx ]=max(expDistributionFromStart);


% creating distribution around the goal to get the goal point idx
for i=1:numOfNodes
    aaag=dist(nodes(i,:),Goal');
    expDistributionFromGoal(i)=(5.64)*exp(-(aaag)/100);
end
[mmmaxig , goalPointIdx]=max(expDistributionFromGoal);

fprintf("starting point in map is ( %0.3f , %0.3f )\n",nodes(startPointIdx,1),nodes(startPointIdx,2))
fprintf("goal point in map is ( %0.3f , %0.3f )\n",nodes(goalPointIdx,1),nodes(goalPointIdx,2))


if(plotting)
    fprintf('plotting the target and start positions \n')
    plotGoalAndTarget(nodes,goalPointIdx,startPointIdx,switchPlotAxis)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:numOfNodes
        aa=dist(nodes(i,:),Goal');
        R(i)=(rewardGain)*exp(-(aa)/rewardDumping);
        if(nodes(i,2) < 4000)
            if((abs(nodes(i,1) - nodes(goalPointIdx,1))>90) && (abs(nodes(i,1) - nodes(startPointIdx,1))> 90))
                R(i) = 0;
            end
        end
end



Path1 = findPath(R,nodes,connections,numOfNodes,startPointIdx,goalPointIdx,maxIterations);

% Drawing the path 
for i=1:size(Path1,2)
plot(nodes(Path1(i),2),nodes(Path1(i),1),'marker','.','markersize',25,'markeredgecolor','b') ;
hold on
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


zer=VFDPlotAdaps(nodes,connections,R);
    
    
    
    