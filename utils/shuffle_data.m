function [train_data, test_data] = shuffle_data(data, ptrn, type)
%SHUFFLE_DATA Summary of this function goes here
%   Detailed explanation goes here
% === Input === 
% data - data to suffler
% ptrn - percentage for training
% type - balanced (1) or unbalanced (2) class number
% 
% == Output ===
% train_data
% test_data

[N, ~] = size(data.x);

if (type == 1)
    train_data.x = []; train_data.y = []; test_data.x = []; test_data.y = [];
    
    if (size(data.y, 2) == 1)
        labels = data.y;
    else
        % 1_of_k representation
        labels = vec2ind(data.y')';
    end
    classes = unique(labels);
    
    numLabels = length(classes);
    for i = 1 : numLabels
        inds = find(labels == classes(i));
        
        numInds = length(inds);
        
        limit = floor(ptrn*numInds);
        if not(isempty(inds))
            
            inds = inds(randperm(numInds));
            train_data.x = [train_data.x; data.x(inds(1:limit), :)];
            train_data.y = [train_data.y; data.y(inds(1:limit), :)];
            
            test_data.x = [test_data.x; data.x(inds(limit+1:end), :)];
            test_data.y = [test_data.y; data.y(inds(limit+1:end), :)];
        end
    end
    
    % Embaralha os dados
    inds = randperm(size(train_data.x,1));
    train_data.x = train_data.x(inds, :);
    train_data.y = train_data.y(inds, :);
    
    inds = randperm(size(test_data.x,1));
    test_data.x = test_data.x(inds, :);
    test_data.y = test_data.y(inds, :);
    
elseif type == 2
    limit = floor(ptrn*N);
    inds = randperm(N);
    
    train_data.x = data.x(inds(1:limit), :);
    train_data.y = data.y(inds(1:limit), :);
    test_data.x = data.x(inds(limit+1:end), :);
    test_data.y = data.y(inds(limit+1:end), :);    
end

end

