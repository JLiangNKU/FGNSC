function [S_weight,S_number,S_weight_max,S_max]=choose_value(Z,num_closer,num_judge)

z=sum(Z');

for i=1:size(Z,1)
        w(i,:)=Z(i,:)./z(i);
end


for i=1:size(w,1)
    C(i,:)=w(i,:)+w(:,i)';
    
    for j=1:num_judge 
        [p,q]=max(C(i,:));
        S_number_temp(i,j)=q;
        S_weight_temp(i,j)=p;
        C(i,q)=0; 
    end
    
end

S_max= S_number_temp(:,1:num_closer); 
S_weight_max= S_weight_temp(:,1:num_closer); 
        
C=[];
num=0;
for i=1:size(w,1)
    
    C(i,:)=w(i,:)+w(:,i)';
    
    for j=1:num_closer 
        [p,q]=max(C(i,:));
        
        
        for k=1:size(w,1)
           if  find(S_number_temp(q,:)==i)
               S_weight(i,j)=p;
               S_number(i,j)=q;
               C(i,q)=0; 
               break;
           else
               num=num+1;
               C(i,q)=0; 
               [p,q]=max(C(i,:));
           end
        end
    end
end

for k=1:size(w,1)
   idx=find(S_number(k,:)==0) ;
   S_number(k,idx)=k;
   S_weight(k,idx)=1;
end
