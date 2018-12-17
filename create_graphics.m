clear; clc; close all;

names_650 = {'result_ecos_4M_650.mat', 'result_ecos_5M_650.mat', 'result_retr_4M_650.mat', 'result_retr_5M_650.mat'};
names_950 = {'result_ecos_4M_950.mat', 'result_ecos_5M_950.mat',  'result_retr_4M_950.mat', 'result_retr_5M_950.mat'};


%% All parameters by k
y_lim = [30 100];
% plot_all_by_k(names_650, 1, y_lim)
% plot_all_by_k(names_650, 3, y_lim)
% plot_all_by_k(names_650, 5, y_lim)

y_lim = [30 100];
plot_all_by_k(names_950, 1, y_lim)
plot_all_by_k(names_950, 3, y_lim)
plot_all_by_k(names_950, 5, y_lim)



%% Function
function plot_all_by_k(names, k, y_lim)
%     color = [127 201 127; 190 174 212; 253 192 134; 255 255 153]/255;
%     color = [27 158 119; 217 95 2; 117 112 179; 231 41 138]/255;
    color = [228 26 28; 55 126 184; 77 175 74;  152 78 163]/255;

    temperature = names{1};
    temperature = temperature(end-6 : end-4);
        
    range = floor(k/2) + 1:3:63;
    figure('Name', sprintf('All-topologies, K=%d, %s',k, temperature), 'units','normalized','outerposition',[0 0 1 1])
    all_acc = [];
    for i = 1 : length(names)
        load(names{i});
        
        % Sort params by product
        multi_params = zeros(1, length(params));
        for j = 1 : length(params)
            
            if mod(j,3) == 0
                temp = params(j).size_som;
%                 fprintf('\n%d %d - %d --> %d | ', temp(1), temp(2), j, prod(temp))
            end
            multi_params(j) = prod(params(j).size_som);
        end
%         fprintf('\n%d\n',length(params))
        [~, indx] = sort(multi_params);
        params = params(indx);
        acc_means = acc_means(indx);


        if not(isempty(strfind(names{i}, 'ecos')))
            plot(acc_means(range)*100, '-', 'LineWidth',3, 'Color', color(mod(i,4)+1, :))

        elseif not(isempty(strfind(names{i}, 'retr')))
            plot(acc_means(range)*100, '--', 'LineWidth',3, 'Color', color(mod(i,4)+1, :))

        end

        fprintf('mean, max, min: %f %f %f\n', mean(acc_means(range)), max(acc_means(range)), min(acc_means(range)))
        all_acc = [all_acc; mean(acc_means(range))];

        hold on
    end
    mean(all_acc)
    hold off
    ylim(y_lim)
    xlim([1 21])  
    set(gca,'fontsize',30)
    xticks(1:length(range))    
    
    hold on
    plot(repmat(mean(all_acc)*100, 1, length(range)), 'Color', [99,99,99]/255, 'LineWidth', 3)
    
    name_leg = {'Echo (4MHz)', 'Echo (5MHz)', 'Backscattered (4MHz)', 'Backscattered (5MHz)', 'mean'};
    legend(name_leg, 'Location', 'southeast', 'FontSize', 30)
    
    set(gca, 'LooseInset', get(gca, 'TightInset'))
    
%     title(sprintf('All topologies, K=%d, Temperature=%s',k, temperature))
    ylabel('Accuracy', 'FontSize', 50)    
    xlabel('Topology', 'FontSize', 50)
    grid('on') 
    
    
    
end