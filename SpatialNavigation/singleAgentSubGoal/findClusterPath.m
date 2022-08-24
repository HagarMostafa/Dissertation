function [clusterPath] = findClusterPath(clusterReward,clusterConnection,startingCluster,goalCluster,maxIterations)
clusterPath = []
iterationIdx = 0;
reached = false;
currentCluster = startingCluster;
while((iterationIdx < maxIterations ) &&(~reached))
    iterationIdx = iterationIdx + 1;
    nextClusterIdx = NearNeigh(clusterReward,clusterConnection,currentCluster,size(clusterConnection,1));
    clusterPath(iterationIdx) = nextClusterIdx
    currentCluster = nextClusterIdx
    if(currentCluster == goalCluster)
        reached = true;
    end
end
end