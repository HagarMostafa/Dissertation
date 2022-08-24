function [RewardVec] = createClusterReward(clustersConnection,startCluster,CurrentCluster,currentReward,initReward)

fprintf('entered from cluster %d \n',CurrentCluster);
RewardVec = initReward;

if(RewardVec(CurrentCluster) > currentReward)
    fprintf('Reached before in a shorter path\n')   
else
    RewardVec(CurrentCluster) = currentReward;
    for i= 1:size(clustersConnection,1)
        if(clustersConnection(CurrentCluster,i) > 0)
            if(i ~= startCluster && i~=CurrentCluster)
                RewardVec = createClusterReward(clustersConnection,CurrentCluster,i,currentReward/2,RewardVec);

            end
        end
    end
    fprintf('exit from cluster %d\n',CurrentCluster);
end