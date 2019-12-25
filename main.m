clear;

paths = genpath('omp');
addpath(paths);
paths = genpath('smr');
addpath(paths);

load picked_38_max50.mat;
picked=[picked_8,picked_15,picked_30];
idx=find(picked==14);
picked(idx)=39;
temp=0;
num_inputs=[8,15,30];
test_times = 2; % test the algorithm with different classes (according to the given set), max 50.

howmuch=64;
num_closer=8;
num_judge=20;
lambda = 0.9;
nCluster=3;
truth_lable=[];

for m=1:nCluster
   lable=m.*ones(1,howmuch); 
   truth_lable=[truth_lable,lable];
end
for j=1:test_times
%         picked=[1:13,15:39]; % if nCluster=38
    for k=1:nCluster
        X(:,64*(k-1)+1:64*k)=load_faces(strcat('B',num2str(picked(j,temp+k),'%6.2d')));
    end  
    X = X/255;

    dim = size(X,2) / howmuch * 6 ;
    fea = X;
    [ eigvector , eigvalue ] = PCA( fea ) ;
    maxDim = length(eigvalue);
    data = eigvector(:,1:dim)' * fea ;

    for jj = 1 : size(data,2)
        data(:,jj) = data(:,jj) /norm(data(:,jj));
    end

    X=data;

    [Z_smr] = demo_smr(X,nCluster,howmuch);
    tic;
    [S_weight,S_number,S_weight_max,S_max]=choose_value(Z_smr,num_closer,num_judge);
    S_number=S_number(:,2:size(S_number,2));
    t_choose=toc;
    t_choose_all(j)=t_choose;

    S_max=S_max(:,2:size(S_max,2));

    [S,groups_ours,groups_omp]=demo_omp(X,S_number,S_max,S_weight_max,nCluster,num_closer);

    S_error_omp = S_number_judge(S,nCluster,howmuch);
    S_error_ours = S_number_judge(S_number,nCluster,howmuch);
    S_error_max = S_number_judge(S_max,nCluster,howmuch);

    acc_ours = compacc(truth_lable',groups_ours);
    acc_omp = compacc(truth_lable',groups_omp);

    nmi_omp = MutualInfo(truth_lable,groups_omp);
    nmi_ours = MutualInfo(truth_lable,groups_ours);

    nmi_omp_all(j)=nmi_omp;
    nmi_ours_all(j)=nmi_ours;

    acc_omp_all(j)=acc_omp;
    acc_ours_all(j)=acc_ours;

    S_error_omp_all(j)=S_error_omp;
    S_error_ours_all(j)=S_error_ours;

    clear X;

end
      
rmpath(paths);