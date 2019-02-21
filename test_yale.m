clear;

paths = genpath('others');
addpath(paths);
paths = genpath('not_mine');
addpath(paths);

load pick_3_5_8_10_15_20_25_30_35.mat;
picked=[picked_15];
idx=find(picked==14);
picked(idx)=39;
temp=0;
num_inputs=[15];
% % 
% load pick_3_5_8.mat;
% picked=[picked_3,picked_5,picked_8];
% temp=0;
% num_inputs=[3,5,8];

howmuch=64;
num_closer=5;
num_judge=20;
lambda = 0.9;

for i=1:1%3,5,10��ѭ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  3+5
    nCluster=3;
    groundtruth=[];
    for kk=1:nCluster
        groundtruth1=kk*ones(1,64);
        groundtruth=[groundtruth,groundtruth1];
    end

%     nCluster=38;
%     for j=1:size(picked_3,1)%1:50
      for j=1:50%1:50
%         picked=[1:3];
        for k=1:nCluster%3,5,10
%         for k=1:38 %3,5,10
%             X(:,howmuch*(k-1)+1:howmuch*k)=dataset(:,num_everycla*(picked(j,temp+k)-1)+1:num_everycla*(picked(j,temp+k)-1)+howmuch);
%             X(:,howmuch*(k-1)+1:howmuch*k)=dataset(:,num_everycla*(picked(k)-1)+1:num_everycla*(picked(k)-1)+howmuch);
            X(:,64*(k-1)+1:64*k)=load_faces(strcat('B',num2str(picked(j,temp+k),'%6.2d')));
        end
        X = X/255;
%         dim = size(X,2) / howmuch * 15 ;
%         fea = X;
%         [ eigvector , eigvalue ] = PCA( fea ) ;
%         maxDim = length(eigvalue);
%         data = eigvector(:,1:dim)' * fea ;
% 
%         for jj = 1 : size(data,2)
%             data(:,jj) = data(:,jj) /norm(data(:,jj));
%         end
%         
%         X=data;
        j
        i
        
%         tic;
        [Z]=demo_orgen(X,nCluster,groundtruth);
%         [Z_lsr,group_lsr,acc_lsr]=demo_lsrr(X,nCluster,howmuch,truth_lable);
%         t1=toc;
%         nmi_lsr = MutualInfo(truth_lable,group_lsr);
%         acc_lsr_all(j,i)=acc_lsr;
%         nmi_lsr_all(j,i)=nmi_lsr;
%         t_lsr_all(j,i)=t1;
%         i
%         j
%         acc_lsr
%         nmi_lsr
     
%         [Z]=demo_lsrr(X,howmuch,nCluster);
%         W_lsr = abs(Z_lsr) + abs(Z_lsr)';
%         [Z_orgen,groups_orgen,acc_orgen]=demo_orgen(X,nCluster,truth_lable);
%         W_orgen = abs(Z_orgen) + abs(Z_orgen)';

%         [Z] = demo_smr(X,nCluster,64);
        Z=1./Z;
        tic;
        1
        [idx,NCLUST]=cluster_dp(Z);
        t_dp=toc;
        ACC_dp = compacc(idx,groundtruth)
        NMI_dp = MutualInfo(idx,groundtruth)
        RI_dp = compare_segmentations(idx,groundtruth)
        Num_esti_dp_all(i,j)=NCLUST;
        ACC_dp_all(i,j)=ACC_dp;
        NMI_dp_all(i,j)=NMI_dp;
        RI_dp_all(i,j)=RI_dp;
        t_dp_all(i,j)=t_dp;
        clear X;
    end

    temp=temp+num_inputs(i);

end

rmpath(paths);