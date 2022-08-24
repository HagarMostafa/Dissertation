function [soff]=Softy(nodesMat,SigX,numOfNodes)

for i=1:numOfNodes
    aa=dist(nodesMat(i,:),SigX');
    Rdis(i)=(5.64)*exp(-(aa)/75);
%     plot3(sk(i,1),sk(i,2),R(i),'marker','.','markersize',5,'markeredgecolor','k');
    end
soff=Rdis;




