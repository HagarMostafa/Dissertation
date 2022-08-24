function [] = plotConnections(nodesMap,connectionsMap,switchAxis,flags)
    if(switchAxis)
        for io=1:size(connectionsMap,1)
            for jo=1:size(connectionsMap,1)
                if(connectionsMap(io,jo) ~=0) && flags(io) == 1 && flags(jo) == 1
                    %line([nodesMap(io,1),nodesMap(jo,1)],[nodesMap(io,2),nodesMap(jo,2)],'Color','r')
                    plot([nodesMap(io,2),nodesMap(jo,2)],[nodesMap(io,1),nodesMap(jo,1)],'r','LineWidth',1)
                end
            end
        end

    else
        for io=1:size(connectionsMap,1)
            for jo=1:size(connectionsMap,1)
                if(connectionsMap(io,jo) ~=0) && flags(io) == 1 && flags(jo) == 1
                    %line([nodesMap(io,1),nodesMap(jo,1)],[nodesMap(io,2),nodesMap(jo,2)],'Color','r')
                    plot([nodesMap(io,1),nodesMap(jo,1)],[nodesMap(io,2),nodesMap(jo,2)],'r','LineWidth',1)
                end
            end
        end
    end
    hold on
end