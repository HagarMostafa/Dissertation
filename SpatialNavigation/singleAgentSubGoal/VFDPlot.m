function [ppp]=VFDPlot(Vals)
load Connectivity700.txt
load CodeBook.txt
load LatCon.txt
mka=max(Vals);
for i=1:710
%     mcol=(1-vinit(i)/mka);
mcol=Vals(i)/mka;
    if(mcol>0.8)
plot(CodeBook(i,1),CodeBook(i,2),'marker','.','markersize',5,'markeredgecolor',[0 0.2 0.2]);
    end
    if(mcol<0.8)
plot(CodeBook(i,1),CodeBook(i,2),'marker','.','markersize',5,'markeredgecolor',[mcol 0.9 0.9]);
    end
hold on
end    

for io=1:size(Connectivity700,1)
        for jo=1:size(Connectivity700,1)
             if(Connectivity700(io,jo) ~=-1)
               mcol=Vals(jo)/mka;
                    if(mcol>0.8)
                line([CodeBook(io,1),CodeBook(jo,1)],[CodeBook(io,2),CodeBook(jo,2)],'Color',[1 0.1 0.1]);
                    end
                 if((mcol>0.5)&&(mcol<0.8))
                line([CodeBook(io,1),CodeBook(jo,1)],[CodeBook(io,2),CodeBook(jo,2)],'Color',[mcol+0.2 0.6 0.2]);
               end
                    if(mcol<0.5)
                line([CodeBook(io,1),CodeBook(jo,1)],[CodeBook(io,2),CodeBook(jo,2)],'Color',[0.5+mcol 0.8 0.7]);
               end
%                     mcol=(1-vinit(jo)/mka);
%                 line([CodeBook(io,1),CodeBook(jo,1)],[CodeBook(io,2),CodeBook(jo,2)],'Color',[mcol 0.9 0.9])
            end
        end
    end
hold on

ppp=0;



