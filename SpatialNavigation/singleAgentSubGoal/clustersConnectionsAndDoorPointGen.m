clc
clear all

%
connectionsFileName =  'connections_combined.txt';
nodesFileName = 'points_combined.txt'; 
clustersFileName = 'clusters.txt'; 
%
connections = load(connectionsFileName);
nodes = load(nodesFileName);
clusterIdxs = load(clustersFileName)

%
clusterSize = 6;

centersOfRows = [-320, -160, 0, 160, 320];
sideMargin = 50;

numOfNodes = size(nodes,1);
clusterConnections = zeros(clusterSize,clusterSize);
doorPoints = [];
doopPointsSize = 0;



for i=1:numOfNodes
    for j=1:numOfNodes
        if(clusterIdxs(i) > 0 && clusterIdxs(j) > 0 )
            if(connections(i,j)>0)
                clusterConnections(clusterIdxs(i),clusterIdxs(j)) = clusterConnections(clusterIdxs(i),clusterIdxs(j)) + 1;
                if(clusterIdxs(i) ~= clusterIdxs(j))
                    doopPointsSize = doopPointsSize + 1;
                    doorPoints(doopPointsSize,:) = [i , clusterIdxs(i) , clusterIdxs(j)  ];
                end
            end
        end
    end
end

save clusterConnections.txt clusterConnections -ascii
save doorPoints.txt doorPoints -ascii

figure(1)
plot(clusterIdxs)