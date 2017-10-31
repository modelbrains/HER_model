subN=10;
pretask=[];
caudal=[];
rostral=[];

for i=1:subN
    
     thisfile=['koechlin_task_experiment_' num2str(i) '.mat'];
    
  
    m=load(thisfile);
    labels={'ar', 'cr', 'tr'};
    task_task={};
    m_conds=zeros(2,2);
    m_conds(1,1)=mean(mean([m.ar1(:,:);m.ar2(:,:)]));
    m_conds(1,2)=mean(mean([m.ar3(:,:)]));%cause ar4 is exactly the same as ar3
    m_conds(2,1)=mean(mean([m.ar5(:,:);m.ar6(:,:)]));
    m_conds(2,2)=mean(mean([m.ar7(:,:);m.ar8(:,:)]));
    task_task{1}=m_conds;
    rostral=[rostral; reshape(m_conds,1,4)];
    
    m_conds=zeros(2,2);
    m_conds(1,1)=mean(mean([m.cr1(:,:);m.cr2(:,:)]));
    m_conds(1,2)=mean(mean([m.cr3(:,:)]));%cause cr4 is exactly the same as cr3
    m_conds(2,1)=mean(mean([m.cr5(:,:);m.cr6(:,:)]));
    m_conds(2,2)=mean(mean([m.cr7(:,:);m.cr8(:,:)]));
    task_task{2}=m_conds;
    caudal=[caudal; reshape(m_conds,1,4)];
    
    
    m_conds=zeros(2,2);
    m_conds(1,1)=mean(mean([m.tr1(:,:);m.tr2(:,:)]));
    m_conds(1,2)=mean(mean([m.tr3(:,:)]));%cause tr4 is exactly the same as tr3
    m_conds(2,1)=mean(mean([m.tr5(:,:);m.tr6(:,:)]));
    m_conds(2,2)=mean(mean([m.tr7(:,:);m.tr8(:,:)]));
    task_task{3}=m_conds;
    pretask=[pretask; reshape(m_conds,1,4)];
    
end
          
    bits=[0 0;2 1];bits=reshape(bits,1,4);
    respN=[1 2; 1 2];respN=reshape(respN,1,4);
    space=zeros(size(pretask,1),1);
%save the data if you're into that sort of thing
% csvwrite('koechlin_task_subs_.txt', [pretask space caudal space rostral])
% csvwrite('bits_resp.txt', [bits; respN])
    
figure
plot(bits(1:2), mean(rostral(:,1:2)), 'b');
hold on
plot(bits(3:4), mean(rostral(:,3:4)), 'r');
hold off
title('rostral')

figure
plot(bits(1:2), mean(caudal(:,1:2)), 'b');
hold on
plot(bits(3:4), mean(caudal(:,3:4)), 'r');
hold off
title('caudal')

figure
plot(bits(1:2), mean(pretask(:,1:2)), 'b');
hold on
plot(bits(3:4), mean(pretask(:,3:4)), 'r');
hold off
title('premotor')





