function [] = plotNodes(nodesMat,switchAxis)
    
    if(switchAxis)
        plot(nodesMat(:,2),nodesMat(:,1),'ko','MarkerFaceColor','y','MarkerSize',3)
        grid on;
        hold on
        axis([min(nodesMat(:,2)) max(nodesMat(:,2)) min(nodesMat(:,1)) max(nodesMat(:,1))]);
    else
        plot(nodesMat(:,1),nodesMat(:,2),'ko','MarkerFaceColor','y','MarkerSize',3)
        grid on;
        hold on
        axis([min(nodesMat(:,1)) max(nodesMat(:,1)) min(nodesMat(:,2)) max(nodesMat(:,2))]);
    end
  
end