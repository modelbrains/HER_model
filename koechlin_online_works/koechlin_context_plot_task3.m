%variables for storing data by condition - the variable IDs derive from the
% koechlin_context_bothstim.m script where the experiment contingencies are
% set up
r1=[]; %1 task, 2 color 0 context bits, 0 cue bits
r2=[]; %1 task, 2 color  0 context bits, 0 cue bits
r3=[]; %2 tasks, 2 colors 1 context bit, 0 cue bits
r4=[]; %2 tasks, 2 colors 1 context bit, 0 cue bits
r5=[]; %1 task, 3 colors 0 context bits, 2 cue bits
r6=[]; %1 task, 3 colors 0 context bits, 2 cue bits
r7=[]; %2 tasks, 3 colors 1 context bit, 1 cue bit
r8=[];%2 tasks, 3 colors 1 context bit, 1 cue bit
if record_start<1;record_start=1;end
tmp_stim_seq=stim_seq(1,record_start:end); %record_start defined in her_model_arrays

for i=1:blocklength.*1+1:length(tmp_stim_seq)   ;%loop through blocks
     %which condition is this
    tmpcond=tmp_stim_seq(i);
        %get sources of activity - eqs 14/15/16
   predact=1.*sum(abs(mod2mat(:,i:1:i+blocklength.*1-1)))...
    +1.*sum(abs(mod2mat(:,i:1:i+blocklength.*1-1)-pred2mat(:,i:1:i+blocklength.*1-1)))...
   +1.*sum(abs(diff(mod2mat(:,i:1:i+blocklength.*1)')'));


    eval(['r' num2str(tmpcond) '=[r' num2str(tmpcond) ' ; predact];']);
end


plot(mean(r1(1:length(r1),:)))%0bits, 1 task
hold on
plot(mean(r2(1:length(r2),2:end)),'m')%0 bits, 1 task
plot(mean(r3(1:length(r3),2:end)),'k')%0 bits, 2 tasks
plot(mean(r4(1:length(r4),2:end)),'k')%0 bits, 2 tasks
plot(mean(r5(1:length(r5),2:end)),'c')%2bits, 1 task
plot(mean(r6(1:length(r6),2:end)),'c')%2bits, 1 task
plot(mean(r7(1:length(r7),2:end)),'g')%1 bits, 2 tasks
plot(mean(r8(1:length(r8),2:end)),'g')%1 bits, 2 tasks

hold off  

cr1=(r1(1:length(r1),2:end));
cr2=(r2(1:length(r2),2:end));
cr3=(r3(1:length(r3),2:end));
cr4=(r4(1:length(r4),2:end));
cr5=(r5(1:length(r5),2:end));
cr6=(r6(1:length(r6),2:end));
cr7=(r7(1:length(r7),2:end));
cr8=(r8(1:length(r8),2:end));
% 

