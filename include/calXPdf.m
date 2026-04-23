function [realEdges,realNBins] = calXPdf(ax,X)
%CALXPDF Summary of this function goes here
% make sure X is an integer
X = round(X);
X_Len = length(X);
% get edge of the data
maxX = max(abs(X));
realEdges = [-maxX,maxX];
% Initial Arr
ArrLen = 2*maxX+1;
realNBins = ArrLen;
Arr = zeros(ArrLen,1);
% index of Arr
Arrind = X+1+maxX;
% count
ArrCnt = 1;
while ArrCnt<=X_Len
    Arr(Arrind(ArrCnt))=Arr(Arrind(ArrCnt))+1;
    ArrCnt = ArrCnt+1;
end
% cal Pdf
pdfval = Arr/X_Len;
plot(ax,-maxX:maxX,pdfval,'LineWidth',1);


