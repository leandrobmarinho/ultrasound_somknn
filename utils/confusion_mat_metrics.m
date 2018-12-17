function [ general_metrics, metrics] = confusion_mat_metrics( matrix )
%METRICASMATCONF Summary of this function goes here
%   Detailed explanation goes here
%   metricas [spe sens ppv fscore hm acc; ...]
%   metricasGeral [spe sens ppv fscore hm acc; ...] (media ponderadada das metricas)

matrix = matrix';
for c = 1 : size(matrix,2)
    TP = matrix(c,c);
    TN = trace(matrix())- TP;
    FP = sum(matrix(:,c)) - TP;
     FN = sum(matrix(c,:)) - TP;
%     FN = sum(sum(matriz)) - TN - TP - FP;
    
    metrics(c,1) = ( TN ) / ( TN + FP ); %spe  
    metrics(c,2) = ( TP ) / ( TP + FN ); %sens (recall)
    metrics(c,3) = ( TP ) / ( TP + FP ); %ppv (precision)
    metrics(c,4) = ( 2*metrics(c,3)*metrics(c,2)) / ....
        (metrics(c,3) + metrics(c,2)); %fscore
    metrics(c,5) = ( 2*metrics(c,2)*metrics(c,1)) / ...
        (metrics(c,2) + metrics(c,1)); %hm
    metrics(c,6) = TP/sum(matrix(c,:)); %acc
        
end
metrics(isnan(metrics)) = 0;

general_metrics = sum(metrics.*repmat(sum(matrix,2), 1, size(metrics,2)))...
    ./repmat(sum(sum(matrix,2)), 1, size(metrics,2));

end
