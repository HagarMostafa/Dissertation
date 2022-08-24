clc
clear all


connectionsFileName =  'cAll.txt';
nodesFileName = 'wAll.txt'; 


connections = load(connectionsFileName);
nodes = load(nodesFileName);


centersOfRows = [-320, -160, 0, 160, 320];
sideMargin = 50;

numOfNodes = size(nodes,1);
clusterIdxs = zeros(numOfNodes,1);
clusterConnections = zeros(6,6);
doorPoints = [];
doopPointsSize = 0;
for i=1:numOfNodes

    if(nodes(i,2)>4000)
        clusterIdxs(i) = 6;
    else
        if(dist(nodes(i,1),centersOfRows(1)) < sideMargin)
            clusterIdxs(i) = 1;
        elseif (dist(nodes(i,1),centersOfRows(2) )< sideMargin)
            clusterIdxs(i) = 2;
        elseif (dist(nodes(i,1),centersOfRows(3) )< sideMargin)
            clusterIdxs(i) = 3;
        elseif (dist(nodes(i,1),centersOfRows(4) )< sideMargin)
            clusterIdxs(i) = 4;
        elseif (dist(nodes(i,1),centersOfRows(5) )< sideMargin)
            clusterIdxs(i) = 5;
        else
            clusterIdxs(i) = 0;
        end
    end
end


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

save clusterIdxs.txt clusterIdxs -ascii
save clusterConnections.txt clusterConnections -ascii
save doorPoints.txt doorPoints -ascii

figure(1)
plot(clusterIdxs)