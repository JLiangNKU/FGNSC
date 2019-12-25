function [C,D] = omp(X,S,S1,S_weight_max,K)

[~, N] = size(X);

Ind = repmat((1:N)', 1, K);
Val = zeros(N, K); % Nonzero Value 
t_vec = ones(N, 1) * K;

for i=1:size(S,1)
    for j=1:size(S,2)
       C(i,S(i,j))=1/size(S,2); 
    end
end

for m=1:size(S1,1)
    for n=1:size(S1,2)
       D(m,S1(m,n))=S_weight_max(m,n); 
    end
end

