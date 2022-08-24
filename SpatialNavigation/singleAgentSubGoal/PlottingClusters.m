clc
clear

connectionsFileName =  'cAll.txt';
nodesFileName = 'wAll.txt'; 
clustersIdxsFileName = 'clusterIdxs.txt';


connections = load(connectionsFileName);
nodes = load(nodesFileName);
clusterIdxs = load(clustersIdxsFileName);

colors = ['k';'r';'m';'c';'b';'y';'g';'w']

figure1 = figure;

for i=1:length(nodes)
    if(clusterIdxs(i)>0)
        plot(nodes(i,2),nodes(i,1),'o-','MarkerFaceColor',colors(clusterIdxs(i)+1),'MarkerEdgeColor',colors(clusterIdxs(i)+1),'MarkerSize',4); 
        grid on;
        hold on;
    end
    
end


axis([min(nodes(:,2)) max(nodes(:,2)) min(nodes(:,1)) max(nodes(:,1))])


for io=1:size(connections,1)
    for jo=1:size(connections,1)
        if(connections(io,jo) ~=0 && clusterIdxs(io) >0 && clusterIdxs(jo) > 0)
            %line([nodesMap(io,1),nodesMap(jo,1)],[nodesMap(io,2),nodesMap(jo,2)],'Color','r')
            plot([nodes(io,2),nodes(jo,2)],[nodes(io,1),nodes(jo,1)],colors(clusterIdxs(io)+1),'LineWidth',1);
        end
    end
end
saveas(figure1, 'clusters.png')
