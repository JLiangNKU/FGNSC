
% load test_Snumber.mat;
% temp=0;
% for i=1:size(S_number,1)
%     for j=1:size(S_number,2)
%         a=[0,64,128];
%         b=floor((i-1)/64)+1;
%         if S_number(i,j)<64*a(b) || S_number(i,j)>64*a(b+1)
%             temp=temp+1;
%         end
%     end
% end
function S_error = S_number_judge(S_number,nCluster,samples)
 
truth_lable=[];
for m=1:nCluster
   lable=m.*ones(1,samples); 
   truth_lable=[truth_lable,lable];
end    
    
corre=0;
for i=1:size(S_number,1)
   idx=find(truth_lable == truth_lable(i));
   for j=1:size(S_number,2)
       if find(idx==S_number(i,j))
           corre=corre+1;
       end
   end
end

S_error=1-corre/(size(S_number,1)*size(S_number,2));
    