clear; clc; close all;

%%
names_650 = {'result_ecos_4M_650.mat', 'result_ecos_5M_650.mat', 'result_retr_4M_650.mat', 'result_retr_5M_650.mat'};
names_950 = {'result_ecos_4M_950.mat', 'result_ecos_5M_950.mat',  'result_retr_4M_950.mat', 'result_retr_5M_950.mat'};

k = 1;
names = names_650;
names = names_950;

type_output = 'time_acc'; %time

%%

range = floor(k/2) + 1:3:63;
for i = 1 : length(names)
    load(names{i});
    name = names{i};
    
    % Sort params by product
    multi_params = zeros(1, length(params));
    for j = 1 : length(params)
        %         fprintf('%d ', prod(params(j).size_som))
        multi_params(j) = prod(params(j).size_som);
    end
    [~, indx] = sort(multi_params);
    params = params(indx);
    acc_means = acc_means(indx);
    general_metrics = general_metrics(:,:, indx);
    test_time = test_time(:, indx);
    train_time = train_time(:, indx);
    conf_mat_test = conf_mat_test(:,:,:,indx);
    
    [acc, ks_indx] = max(reshape(acc_means, 3, length(acc_means)/3));
    best_topologies = params(1:3:63 + (ks_indx - 1));
    
    general_metrics = general_metrics(:, :, 1:3:63 + (ks_indx - 1));
    conf_mat_test = conf_mat_test(:,:,:,1:3:63 + (ks_indx - 1));
    test_time = test_time(:, 1:3:63 + (ks_indx - 1));
    train_time = train_time(:, 1:3:63 + (ks_indx - 1));
    
    if not(isempty(strfind(names{i},'ecos')))
        tam_database = 40000;
    elseif not(isempty(strfind(names{i},'retr')))
        tam_database = 2000;
    end
    
    for j = 1 : length(acc)
        if strcmp(type_output, 'acc')
            fprintf('%d$\\times$%d, k=%d\t%.1f\t%.2f$\\pm$%.2f\n', best_topologies(j).size_som, ...
                best_topologies(j).K, 100*(prod(best_topologies(j).size_som)/tam_database), ...
                100*acc(j), var(general_metrics(end,:,j))*100)
            
        elseif strcmp(type_output, 'rank')
            fprintf('%dx%d, k=%d\t%.1f\t%.2f\t%.2G\t%.2G\t%s\t%s\t%s\n', ...
                best_topologies(j).size_som, best_topologies(j).K, ...
                100*(prod(best_topologies(j).size_som)/tam_database), ...
                100*acc(j), mean(test_time(:,j)),  mean(train_time(:,j)), ...
                name(8:11), name(13:14), name(16:18))            
            
        elseif strcmp(type_output, 'time')
            fprintf('%d$\\times$%d, k=%d\t%.1f\t%.2f$\\pm$%.1f\t%2.1E$\\pm$%1.E\t%2.1E$\\pm$%1.E\t%s\t%s\t%s\n', ...
                best_topologies(j).size_som, best_topologies(j).K, ...
                100*(prod(best_topologies(j).size_som)/tam_database), ...
                100*acc(j), var(general_metrics(end,:,j))*100, ...
                mean(test_time(:,j)),  std(test_time(:,j)), ...
                mean(train_time(:,j)), std(train_time(:,j)), ...
                name(8:11), name(13:14), name(16:18))
            
        elseif strcmp(type_output, 'time_acc')
            fprintf('%.2f$\\pm$%.1f\t%2.1E$\\pm$%1.E\t%2.1E$\\pm$%1.E\n', ...                
                100*acc(j), var(general_metrics(end,:,j))*100, ...
                mean(test_time(:,j)),  std(test_time(:,j)), ...
                mean(train_time(:,j)), std(train_time(:,j)))            
            
        elseif strcmp(type_output, 'acc_')
            metrics =  mean(general_metrics(:,:,j)');

            % spe sens ppv fscore hm acc
            fprintf('%s %.1f %.1f %.1f %.1f %.1f %.1f\n', names{i}, 100*metrics)
            
            mean_matrix = mean(conf_mat_test(:,:,:,j), 3);
        end
        
    end
    fprintf('\n')

end