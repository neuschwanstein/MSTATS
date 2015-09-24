function [mu, a] = fromTheta(d,theta)
    mu = theta(1:d);
    a = triu(ones(d,d));
    mask = a;
    a(mask == 1) = theta(d+1:end);
    
    for i=1:d
        a(i,i) = exp(a(i,i));
    end
%     a = zeros(d);
%     it = 1;
%     for i=1:d
%         for j=i:d
%             if i == j
%                 a(i,j) = exp(theta(d+it));
%             else
%                 a(i,j) = theta(d+it);
%             end
%             it = it+1;
%         end
%     end
end