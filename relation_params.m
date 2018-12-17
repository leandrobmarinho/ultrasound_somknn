clear; clc; close all;

range_Ws = 10:10:60; %10:5:2000 10:10:100
range_Ks = 1:2:5;

clear params
% ========================================================================
comb = combvec(range_Ws, range_Ws);
comb = comb(:,(comb(1,:) - comb(2,:)) >= 0);
comb = combvec(range_Ks, comb)';

for i = 1 : length(comb)
    if comb(i,1) == 1
        fprintf('%d %d %d \n', comb(i,2), comb(i,3), prod(comb(i,2:3)))
    end
    params(i).size_som = comb(i,2:3);
    params(i).K = comb(i,1);
end

fprintf('Len_params: %d. Qtd_diff_neur: %.0f. Max_perc_neur: %.2f\n', ...
    length(params), length(params)/3, range_Ws(end)*range_Ws(end)/(40000*0.75))

clear params


%%
range_Ws = 10:4:30; %10:5:445 
range_Ks = 1:2:5;


comb = combvec(range_Ws, range_Ws);
comb = comb(:,(comb(1,:) - comb(2,:)) >= 0);
comb = combvec(range_Ks, comb)';

for i = 1 : length(comb)
    params(i).size_som = comb(i,2:3);
    params(i).K = comb(i,1);
end

fprintf('Len_params: %d. Qtd_diff_neur: %.0f. Max_perc_neur: %.2f\n', ...
    length(params), length(params)/3, range_Ws(end)*range_Ws(end)/(2000*0.75))



%% Best choice
fprintf('-----Best-----\n')

range_Ws = 10:10:60;
range_Ks = 1:2:5;
comb = combvec(range_Ws, range_Ws);
comb = comb(:,(comb(1,:) - comb(2,:)) >= 0);

best_comb = [];
for p =  [.3 .6 1 1.3 1.6 2 2.6 3 3.3 4 5 5.3 6 6.6 8 8.3 10 12]
   [a, b] = sort(abs((prod(comb)/(40000*0.75))*100 - p));
%    a(1:4)
   best_comb = [best_comb comb(:,b(1))];
   
%   fprintf('%.1f %dx%d\n', prod(comb(:,b(1)))/(40000*0.75)*100, comb(1,b(1)), comb(2,b(1)))
  fprintf('%d$\\times$%d,k=1\t%.1f\n', comb(1,b(1)), comb(2,b(1)), prod(comb(:,b(1)))/(40000*0.75)*100)

end

comb = combvec(range_Ks, best_comb)';
comb_30000 = [1,10,10;3,10,10;5,10,10;1,20,10;3,20,10;5,20,10;1,30,10;...
    3,30,10;5,30,10;1,40,10;3,40,10;5,40,10;1,50,10;3,50,10;5,50,10;...
    1,60,10;3,60,10;5,60,10;1,40,20;3,40,20;5,40,20;1,30,30;3,30,30;...
    5,30,30;1,50,20;3,50,20;5,50,20;1,60,20;3,60,20;5,60,20;1,50,30;...
    3,50,30;5,50,30;1,40,40;3,40,40;5,40,40;1,60,30;3,60,30;5,60,30;...
    1,50,40;3,50,40;5,50,40;1,60,40;3,60,40;5,60,40;1,50,50;3,50,50;...
    5,50,50;1,60,50;3,60,50;5,60,50;1,60,60;3,60,60;5,60,60];


fprintf('\n')
range_Ws = 1:20;
range_Ks = 1:2:5;
comb = combvec(range_Ws, range_Ws);
comb = comb(:,(comb(1,:) - comb(2,:)) >= 0);

best_comb = []; percent = [];
for p = [.3 .6 1 1.3 1.6 2 2.6 3 3.3 4 5 5.3 6 6.6 8 8.3 10 12] %10:5:95
   [a, b] = sort(abs((prod(comb)/(2000*0.75))*100 - p));
   best_comb = [best_comb comb(:,b(1))];
   
%    fprintf('%.0f %dx%d\n', prod(comb(:,b(1)))/(2000*0.75)*100, comb(1,b(1)), comb(2,b(1)))
   fprintf('%d$\\times$%d,k=1\t%.1f\n', comb(1,b(1)), comb(2,b(1)), prod(comb(:,b(1)))/(2000*0.75)*100)
end
comb = combvec(range_Ks, best_comb)';

comb_1500 = [1 10 10;3 10 10;5 10 10;1 20 10;3 20 10;5 20 10;1 30 10; ...
    3 30 10;5 30 10;1 40 10;3 40 10;5 40 10;1 50 10;3 50 10;5 50 10; ...
    1 50 10;3 50 10;5 50 10;1 60 10;3 60 10;5 60 10;1 70 10;3 70 10; ...
    5 70 10;1 70 10;3 70 10;5 70 10;1 80 10;3 80 10;5 80 10;1 90 10; ...
    3 90 10;5 90 10;1 100 10;3 100 10;5 100 10;1 110 10;3 110 10;5 110 10; ...
    1 110 10;3 110 10;5 110 10;1 120 10;3 120 10;5 120 10;1 130 10;3 130 10; ...
    5 130 10;1 130 10;3 130 10;5 130 10;1 140 10;3 140 10;5 140 10];