clc
clear


connectionsFileName =  'connections_combined.txt';
nodesFileName = 'points_combined.txt'; 
clustersIdxsFileName = 'clusters.txt'; 
clusterConnectionsFileName = 'clusterConnections.txt';
doorPointsFileName = 'doorPoints.txt';
flagsFileName = 'flags.txt';

connections = load(connectionsFileName);
nodes = load(nodesFileName);

clusterIdxs = load(clustersIdxsFileName);
clusterConnections = load(clusterConnectionsFileName);

doorPoints = load(doorPointsFileName);

%flags = load(flagsFileName);

flags = ones(length(nodes),1);

%room1
flags = checkObstacle(nodes, 8000, 5000, 1000, 500,flags);
flags = checkObstacle(nodes, 9000, 6000, 500, 700,flags);

%room2
flags = checkObstacle(nodes, 10000, 3000, 1000, 500,flags);
flags = checkObstacle(nodes, 8500, 3000, 1000, 500,flags);

%room3
flags = checkObstacle(nodes, 4000, 3000, 1000, 200,flags);
flags = checkObstacle(nodes, 3000, 2000, 800, 500,flags);

%room4
flags = checkObstacle(nodes, 4000, 7000, 1000, 400,flags);
flags = checkObstacle(nodes, 2000, 5000, 400, 400,flags);
flags = checkObstacle(nodes, 2000, 6000, 600, 500,flags);

startPointIdx = 100;
%goalPointIdx = 200;


plotting = true;
debugging = true;
switchPlotAxis = true;

maxIterations = 900;

%Cluster parameters
maxClusterReward = 1; 
maxClusterIterations = 10;


%reward parameter
rewardGain = 50.64;       %50.64;
rewardDumping = 320;      %230;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('finding goal point cluster and start point cluster \n')

% prompt1 = "What is the start point index? ";
% startPointIdx = input(prompt1);

% prompt2 = "What is the goal point index? ";
% goalPointIdx = input(prompt2);

prompt2 = "What is the destination room? ";
room = input(prompt2,'s');

switch room
    case 'room1'
        goalPointIdx = 70;
    case 'room2'
        goalPointIdx = 300;
    case 'room3'
        goalPointIdx = 400;
    case 'room4'
        goalPointIdx = 410;
    case 'corridor'
        goalPointIdx = 700;
    case 'reception'
        goalPointIdx = 800;
    otherwise
        disp('Place does not exist!')
end

startCluster = clusterIdxs(startPointIdx);
goalCluster = clusterIdxs(goalPointIdx);

fprintf('goal cluster is  : %d \n',goalCluster)
fprintf('start cluster is : %d \n',startCluster)


clusterReward = createClusterReward(clusterConnections,goalCluster,goalCluster,maxClusterReward,zeros(1,6));
clustersRoute = findClusterPath(clusterReward,clusterConnections,startCluster,goalCluster,maxClusterIterations);


Goal=[nodes(goalPointIdx,1) nodes(goalPointIdx,2)];
Start=[nodes(startPointIdx,1) nodes(startPointIdx,2)];


numOfNodes = size(nodes,1);
for i=1:numOfNodes
        aa=dist(nodes(i,:),Goal');
        globalReward(i)=(rewardGain)*exp(-(aa)/rewardDumping);
end


currentPointIdx = startPointIdx;
Path=[];
for clusterI=1:size(clustersRoute,2)
    subGoalIdx = getDoorPoint(globalReward,doorPoints,clustersRoute(clusterI),clusterIdxs(currentPointIdx));

    subGoal = nodes(subGoalIdx,:);
    for i=1:numOfNodes
        aa=dist(nodes(i,:),subGoal');
        R(i)=(rewardGain)*exp(-(aa)/rewardDumping);
    end
    newPath = findPath(R,nodes,connections,numOfNodes,currentPointIdx,subGoalIdx,maxIterations,false,flags);
    plotRewardGoalStartPath(connections,nodes,clusterIdxs,subGoalIdx,currentPointIdx,newPath,strcat(strcat("path",int2str(clusterI)),".png"),flags)

    Path = cat(2,Path,newPath);

    currentPointIdx = subGoalIdx;

end

newPath = findPath(globalReward,nodes,connections,numOfNodes,currentPointIdx,goalPointIdx,maxIterations,false,flags);
plotRewardGoalStartPath(connections,nodes,clusterIdxs,goalPointIdx,currentPointIdx,newPath,strcat(strcat("path",int2str(size(clustersRoute,2)+1)),".png"),flags)
Path = cat(2,Path,newPath);
plotting = true;

plotRewardGoalStartPath(connections,nodes,clusterIdxs,goalPointIdx,startPointIdx,Path,"pathFull.png",flags)

if(plotting)
    
    j = 1;
    temp = zeros(length(flags),2);

    for i=1:length(flags)
        
        if flags(i) == 1
            temp(j,1) = nodes(i,1);
            temp(j,2) = nodes(i,2);
            j = j+1;
        end

    end

    fprintf('plotting the nodes and connections \n')
    figure(5)
    plotNodes(temp,switchPlotAxis)
    plotConnections(nodes,connections,switchPlotAxis,flags)

end

for i=1:size(Path,2)
    if flags(Path(i)) == 1
        plot(nodes(Path(i),2),nodes(Path(i),1),'marker','.','markersize',25,'markeredgecolor','b')
        hold on
    end
end
