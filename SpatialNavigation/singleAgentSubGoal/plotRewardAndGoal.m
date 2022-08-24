clc
clear

connectionsFileName =  'cAll.txt';
nodesFileName = 'wAll.txt'; 
clustersIdxsFileName = 'clusterIdxs.txt';


connections = load(connectionsFileName);
nodes = load(nodesFileName);
clusterIdxs = load(clustersIdxsFileName);

colors = ['k';'r';'m';'c';'b';'y';'g';'w']

numOfNodes = length(nodes)

goalPointIdx = 1430;
Goal=[nodes(goalPointIdx,1) nodes(goalPointIdx,2)];

figure1 = figure('Renderer', 'painters', 'Position', [10 10 2000 1000])


rewardGain = 1;       %50.64;
rewardDumping = 3000;      %230;


for i=1:numOfNodes
        aa=dist(nodes(i,:),Goal');
        R(i)=(rewardGain)*exp(-(aa)/rewardDumping);
end


myColorMap = jet(256);

%Drawing Points based
mka=max(R);
for i=1:size(nodes,1)
    if(clusterIdxs(i)>0)
        mcol=fix(R(i)/mka * 256);
        if(mcol == 0)
            mcol = 1;
        end
        plot(nodes(i,2),nodes(i,1),'o-','MarkerFaceColor',myColorMap(mcol,:),'markersize',4,'markeredgecolor',myColorMap(mcol,:));
        hold on 
    end
end    


for i=1:size(nodes,1)
    for jo=1:numOfNodes        
        if(connections(i,jo) ~=0 && clusterIdxs(i) >0 && clusterIdxs(jo) > 0)
            mcol=fix(R(jo)/mka * 256);
            if(mcol == 0)
                mcol = 1;
            end
            line([nodes(i,2),nodes(jo,2)],[nodes(i,1),nodes(jo,1)],'Color',myColorMap(mcol,:));
            hold on
        end
    end
    i
end


plot(nodes(goalPointIdx,2),nodes(goalPointIdx,1),'o','MarkerFaceColor','g','markersize',15,'markeredgecolor','g');
hold on 
saveas(figure1, 'rewardAndGoal.png')



