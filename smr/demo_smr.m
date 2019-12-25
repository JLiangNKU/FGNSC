function [Z_smr] = demo_smr(X,nCluster,samples)

dim = size(X,2) / samples * 6 ;

data=X;

fea = data./max(data(:));
exp_name = 'FaceClustering';

para.knn = 4;
para.gamma = 5;
para.elpson = 0.01;
para.aff_type = 'J2_nonorm';
para.alpha = 2^15;

tic;
W = smr(data,para);
W2 = W;

for ic = 1 : size(W,2)
   W2(:,ic) = W(:,ic)/(max(abs(W(:,ic)))+eps) ;    
end

gnd=[];
    for m=1:nCluster
       lable=m.*ones(1,samples); 
       gnd=[gnd,lable];
    end

Z_smr=W2;
end
