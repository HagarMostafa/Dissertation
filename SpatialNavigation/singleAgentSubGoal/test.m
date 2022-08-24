clc
clear


connectionsFileName =  'cAll.txt';
nodesFileName = 'wAll.txt'; 
clustersIdxsFileName = 'clusterIdxs.txt';
clusterConnectionsFileName = 'clusterConnections.txt';
doorPointsFileName = 'doorPoints.txt';

connections = load(connectionsFileName);
nodes = load(nodesFileName);

clusterIdxs = load(clustersIdxsFileName);
clusterConnections = load(clusterConnectionsFileName);

doorPoints = load(doorPointsFileName);

startPointIdx = 100;
goalPointIdx = 1430;


plotting = true;
debugging = true;
switchPlotAxis = true;

maxIterations = 1000;

%Cluster parameters
maxClusterReward = 1; 
maxClusterIterations = 10;


%reward parameter
rewardGain = 50.64;       %50.64;
rewardDumping = 320;      %230;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fprintf('finding goal point cluster and start point cluster \n')

startCluster = clusterIdxs(startPointIdx);
goalCluster = clusterIdxs(goalPointIdx);

fprintf('goal cluster is  : %d \n',goalCluster)
fprintf('start cluster is : %d \n',startCluster)


clusterReward = createClusterReward(clusterConnections,goalCluster,goalCluster,maxClusterReward,zeros(1,6))
clustersRoute = findClusterPath(clusterReward,clusterConnections,startCluster,goalCluster,maxClusterIterations)


Goal=[nodes(goalPointIdx,1) nodes(goalPointIdx,2)];
Start=[nodes(startPointIdx,1) nodes(startPointIdx,2)];


numOfNodes = size(nodes,1);
for i=1:numOfNodes
        aa=dist(nodes(i,:),Goal');
        globalReward(i)=(rewardGain)*exp(-(aa)/rewardDumping);
end


currentPointIdx = startPointIdx
Path=[]
for i=1:size(clustersRoute,2)
    subGoalIdx = getDoorPoint(globalReward,doorPoints,clustersRoute(i),clusterIdxs(currentPointIdx))

    subGoal = nodes(subGoalIdx,:);
    for i=1:numOfNodes
        aa=dist(nodes(i,:),subGoal');
        R(i)=(rewardGain)*exp(-(aa)/rewardDumping);
    end
    newPath = findPath(R,nodes,connections,numOfNodes,currentPointIdx,subGoalIdx,maxIterations,false);
    Path = cat(2,Path,newPath)

    currentPointIdx = subGoalIdx;



end

newPath = findPath(globalReward,nodes,connections,numOfNodes,currentPointIdx,goalPointIdx,maxIterations,false);
Path = cat(2,Path,newPath)
plotting = true;


if(plotting)
    fprintf('plotting the nodes and connections \n')
    figure(1)
    plotNodes(nodes,switchPlotAxis)
    plotConnections(nodes,connections,switchPlotAxis)
end


for i=1:size(Path,2)
    plot(nodes(Path(i),2),nodes(Path(i),1),'marker','.','markersize',25,'markeredgecolor','b') ;
    hold on
end
 