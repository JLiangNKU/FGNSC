function [S,groups_ours,groups_omp]=demo_omp(X,S_number,S_max,S_weight_max,nCluster,numcloser)

reduceDimension = @(data) dimReduction_PCA(data, 0);
normalizeColumn = @(data) cnormalize_inplace(data);
buildRepresentation = @(data) OMP_mat_func(data, 4, 1e-6);
genLabel = @(affinity, nCluster) SpectralClustering(affinity, nCluster, 'Eig_Solver', 'eigs');

N=size(X,2);

X = reduceDimension(X);
X = normalizeColumn(X);
tic;
[R_,R] = omp(X,S_number,S_max,S_weight_max,numcloser-1);
if size(R,2)==size(X,2)-1
    R(:,size(X,2))=zeros(size(X,2),1);
    R(size(X,2),size(X,2)-1)=1;
end
R(1:N+1:end) = 0;
t_ours_com=toc;
tic;
A = abs(R) + abs(R)';
groups_ours = genLabel(A, nCluster);
t_our=toc;

tic;
[S,C] = get_omp_S(X, 4, 0.01);
C(1:N+1:end) = 0;
B = abs(C) + abs(C)';
groups_omp = genLabel(B, nCluster);
t_omp=toc;