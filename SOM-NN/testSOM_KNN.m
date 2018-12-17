function [ output ] = testSOM_KNN(model, data)

if (size(model.W, 1) == 1)
    output = repmat(model.Wy, size(data.x, 1), 1);
else
    dist = pdist2(model.W, data.x);
    [~, posicoes] = sort(dist);
    
    
%     output = modelo.Wy(posicoes(1,:));
%     output =  mode(modelo.Wy(posicoes(1:modelo.K,:)))';
    
    for i = 1 : size(data.x, 1)
        %Se tentar pegar mais neuronios que existe
        if (model.K > size(model.W, 1))
            model.K = size(model.W, 1); 
        end
        
        y = model.Wy(posicoes(1:model.K, i));
        
        U = unique(y);
        H = histc(y,U);
        
%         try
%             output(i) = U(H==max(H));
%         catch
%             keyboard
%         end
        dec_classe = U(H==max(H));
        if (length(dec_classe) == 1)
            output(i) = U(H==max(H));
        else
%             output(i) = 0;
            output(i) = dec_classe(1);
        end
    end
    output = output';
    
end

end
