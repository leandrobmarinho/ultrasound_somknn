function [topology] = search_topology(data, params, num_iter)
%SEARCH_TOPOLOGY Summary of this function goes here
%   Detailed explanation goes here

topology.K = 3;
topology.size_som = [12 12];
% topology.size_som = [2 2];

fprintf('Searching topology\n');
for i = 1:num_iter
    for j = 1 : length(params)
        
        % Shuffle data to train and test
        [train_data, test_data] = shuffle_data(data, 0.8, 1);
        
        % Train
        modelo = trainSOM_KNN(train_data, params{j});
        
        % Test
        class_predicted = testSOM_KNN(modelo, test_data);
        conf_mat = confusionmat(test_data.y, class_predicted);
        acc(i,j) = trace(conf_mat) / length(class_predicted);

        fprintf('Acc: %f. (%d, %d) K=%d\n', acc(i,j), params{j}.size_som(1), params{j}.size_som(2), ...
            params{j}.K);
    end
end

Ecv = mean(acc,1);
[~, indice] = max(Ecv);
topology = params{indice};


end

