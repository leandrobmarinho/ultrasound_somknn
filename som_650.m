clearvars -except retr_4M_650 retr_5M_650 ecos_4M_650 ecos_5M_650 classes_retr_650 classes_ecos_650;
clc; close all; addpath('./SOM-NN'); addpath('./utils');

%% Read 650 data
if not(exist('retr_4M_650', 'var')) | not(exist('retr_5M_650', 'var')) | ...
        not(exist('ecos_4M_650', 'var')) | not(exist('ecos_5M_650', 'var'))
    fprintf('Reading data 650\n');
    
    read_data650
end


% %% Run SOM Backscattered
% num_repet = 2; % times holdout
% 
% % % Define paramters to search topology
% % range_Ws = 10:4:30; %10:5:445
% % range_Ks = 1:2:5;
% % 
% % 
% % 
% % % ========================================================================
% % comb = combvec(range_Ws, range_Ws);
% % comb = comb(:,(comb(1,:) - comb(2,:)) >= 0);
% % comb = combvec(range_Ks, comb)';
% 
% comb = [1 10 10;3 10 10;5 10 10;1 20 10;3 20 10;5 20 10;1 30 10; ...
%     3 30 10;5 30 10;1 40 10;3 40 10;5 40 10;1 50 10;3 50 10;5 50 10; ...
%     1 50 10;3 50 10;5 50 10;1 60 10;3 60 10;5 60 10;1 70 10;3 70 10; ...
%     5 70 10;1 70 10;3 70 10;5 70 10;1 80 10;3 80 10;5 80 10;1 90 10; ...
%     3 90 10;5 90 10;1 100 10;3 100 10;5 100 10;1 110 10;3 110 10;5 110 10; ...
%     1 110 10;3 110 10;5 110 10;1 120 10;3 120 10;5 120 10;1 130 10;3 130 10; ...
%     5 130 10;1 130 10;3 130 10;5 130 10;1 140 10;3 140 10;5 140 10];
% 
% for i = 1 : length(comb)
%     params(i).size_som = comb(i,2:3);
%     params(i).K = comb(i,1);
% end
% 
% 
% % Backscattered and Echos
% for dataset = {'retr_4M_650', 'retr_5M_650'}
%     
%     fprintf('Processing %s \n', dataset{1})
%     eval(sprintf('data.x = %s;', dataset{1}))
%     
%     data.y = classes_retr_650;
%     
%     for j = 1 : num_repet        
%     
%         % Shuffle data to train and test
%         [train_data, test_data] = shuffle_data(data, 0.75, 1);
%                     
%         for p = 1 : length(params)            
%             fprintf('Parameter %d, hold out %d\n', p, j)
%             
%             % Train
%             if params(p).K == 1
%                 tic            
%                 model = trainSOM_KNN(train_data, params(p));
%                 train_time(j,p) = toc;
%                 weight = model.W;
%                 time = train_time(j,p);
%             else
%                 model = trainSOM_KNN(train_data, params(p), weight);
%                 train_time(j,p) = time;
%             end
%             
%             % Test
%             tic
%             class_predicted = testSOM_KNN(model, test_data);
%             test_time(j,p) = toc/size(test_data.y,1);
%             conf_mat_test(:,:,j,p) = confusionmat(test_data.y, class_predicted);
%             % Metrics
%             [general_metrics(:,j,p), metrics(:,:,j,p)] = confusion_mat_metrics(conf_mat_test(:,:,j,p));
%         end
%         
%         save(sprintf('result_%s',dataset{1}), 'general_metrics', 'metrics', ...
%             'conf_mat_test', 'train_time', 'test_time')
%     end
%     
%     acc_means = reshape(mean(general_metrics(end,:,:),2), 1, length(params));
%     save(sprintf('result_%s',dataset{1}), 'general_metrics', 'metrics', ...
%             'conf_mat_test', 'train_time', 'test_time', 'acc_means', 'params')
% end


%% Run SOM Ecos
num_repet = 2;

% % Define paramters to search topology
% range_Ws = 10:10:60; %10:5:2000;
% range_Ks = 1:2:5;
% 
% clear params
% % ========================================================================
% comb = combvec(range_Ws, range_Ws);
% comb = comb(:,(comb(1,:) - comb(2,:)) >= 0);
% comb = combvec(range_Ks, comb)';

comb = [1 150 100; 3 150 100; 5 150 100];

for i = 1 : length(comb)
    params(i).size_som = comb(i,2:3);
    params(i).K = comb(i,1);
end

for dataset = {'ecos_4M_650', 'ecos_5M_650'}
    fprintf('Processing %s \n', dataset{1})
    eval(sprintf('data.x = %s;', dataset{1}))
    
    data.y = classes_ecos_650;
    
%     [data.x, ia, ~] = unique(data.x, 'rows');
%     data.y = data.y(ia);
    
    for j = 1 : num_repet        
    
        % Shuffle data to train and test
        [train_data, test_data] = shuffle_data(data, 0.75, 1);
                    
        for p = 1 : length(params)            
            fprintf('Parameter %d, hold out %d\n', p, j)
            
            % Train
            if params(p).K == 1
                tic            
                model = trainSOM_KNN(train_data, params(p));
                train_time(j,p) = toc;
                weight = model.W;
                time = train_time(j,p);
            else
                model = trainSOM_KNN(train_data, params(p), weight);
                train_time(j,p) = time;
            end
            
            % Test
            tic
            class_predicted = testSOM_KNN(model, test_data);
            test_time(j,p) = toc/size(test_data.y,1);
            conf_mat_test(:,:,j,p) = confusionmat(test_data.y, class_predicted);
            % Metrics
            [general_metrics(:,j,p), metrics(:,:,j,p)] = confusion_mat_metrics(conf_mat_test(:,:,j,p));
        end
        
        save(sprintf('result_%s',dataset{1}), 'general_metrics', 'metrics', ...
            'conf_mat_test', 'train_time', 'test_time')
    end
    
    acc_means = reshape(mean(general_metrics(end,:,:),2), 1, length(params));
    save(sprintf('result_%s',dataset{1}), 'general_metrics', 'metrics', ...
            'conf_mat_test', 'train_time', 'test_time', 'acc_means', 'params')
end
run som_950.m

%{
- Não é para buscar por topologia e sim avaliar quanto de neuronio retirno,
sem perder acurácia
- Retirar função search_topology
- Salvar todos os resultados médios por topologia
- Avaliar diferentes parâmetros de topologia de acorodo com tamanho da base
2000 (10:5:445) e 40000 (10:5:2000)
%}