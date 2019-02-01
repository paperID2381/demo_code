function [precision, recall, corrRate] = evaluate(CorrectIndex, VFCIndex, siz,fid)
%   [PRECISION, RECALL, CORRRATE] = EVALUATE(CORRECTINDEX, VFCINDEX, SIZ)
%   evaluates the performence of VFC with precision and recall.
%
% Input:
%   CorrectIndex, VFCIndex: Correct indexes and indexes reserved by VFC.
%
%   siz: Number of initial matches.
%
% Output:
%   precision, recall, corrRate: Precision and recall of VFC, percentage of
%       initial correct matches.
%
%   See also:: VFC().

if length(VFCIndex)==0
    precision=0;
    recall=0;
    corrRate=length(CorrectIndex)/siz;
else
    tmp=zeros(1, siz);
    tmp(VFCIndex) = 1;
    tmp(CorrectIndex) = tmp(CorrectIndex)+1;
    VFCCorrect = find(tmp == 2);
    NumCorrectIndex = length(CorrectIndex);
    NumVFCIndex = length(VFCIndex);
    NumVFCCorrect = length(VFCCorrect);
    
    corrRate = NumCorrectIndex/siz;
    precision = NumVFCCorrect/NumVFCIndex;
    recall = NumVFCCorrect/NumCorrectIndex;
    
end