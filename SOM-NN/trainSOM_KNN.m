function [ model ] = trainSOM_KNN(data, config, varargin )
% fprintf('Positioning neurons.\n')


if isempty(varargin)
    net = selforgmap(config.size_som);
    net.trainParam.showWindow = 0;
    [net,tr] = train(net,data.x');
    model.W = net.IW{1};
else
    model.W = varargin{1};
end

dist = pdist2(data.x, model.W);
[~, posicoes] = sort(dist);

for i = 1 : size(model.W,1)
    
    y = data.y(posicoes(1:config.K, i), :);
    
    U = unique(y);
    H = histc(y,U);
    
%     try
%         Wy(i) = U(H==max(H));
%     catch
%         keyboard
%     end
    dec_classe = U(H==max(H));
    if (length(dec_classe) == 1)
        Wy(i) = U(H==max(H));
    else
        % Wy(i) = 0;
        Wy(i) = dec_classe(1);
    end
    
end

model.Wy = Wy';
model.K = config.K;

% pos = gridtop(config.size_som)
% labels = cellstr( num2str([model.Wy']') );
% plotsom(pos)
% if (size(pos,1) == 1)
%     pos = [pos; zeros(1,size(pos,2))];
% end
% pos_ = pos';
% text(pos_(:,1), pos_(:,2), labels, 'VerticalAlignment','bottom', ...
% 'HorizontalAlignment','right')

end