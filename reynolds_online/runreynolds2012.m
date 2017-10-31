%Run simulations for reynolds et al, 2012, fig 5


nSubs=3;%number of subjects

% % %condition key
% % 1 - baseline
% % 2 - low/single
% % 3 - low/multiple
% % 4 - high/single
% % 5 - high/multiple

%now run the HER model on each condition
thiscond=1;
bline2=[];
for trial=1:nSubs
    %generate sequence
reynolds_sequence
her_model_arrays

%get model activity
x=1.*sum(abs(mod2mat(:,1:end-1)))...
    +1.*sum(abs(mod2mat(:,1:end-1)-pred2mat(:,1:end-1)))...
    +1.*sum(abs(diff(mod2mat(:,1:end)')'));
x=[x 0];

%store each subject's data on the target trial
bline2=[bline2 [mean(x(end-100*3:end-1))]];

end

thiscond=2
lowsing2=[];
for trial=1:nSubs
reynolds_sequence
her_model_arrays

x=1.*sum(abs(mod2mat(:,1:end-1)))...
    +1.*sum(abs(mod2mat(:,1:end-1)-pred2mat(:,1:end-1)))...
    +1.*sum(abs(diff(mod2mat(:,1:end)')'));
x=[x 0];

lowsing2=[lowsing2 [mean(x(end-100*3:end-1))]];
end

thiscond=3

lowmult2=[];
for trial=1:nSubs
reynolds_sequence
her_model_arrays

x=1.*sum(abs(mod2mat(:,1:end-1)))...
    +1.*sum(abs(mod2mat(:,1:end-1)-pred2mat(:,1:end-1)))...
    +1.*sum(abs(diff(mod2mat(:,1:end)')'));
x=[x 0];

lowmult2=[lowmult2 [mean(x(end-100*3:end-1))]];


end

thiscond=4


highsing2=[];
for trial=1:nSubs
reynolds_sequence
her_model_arrays

x=1.*sum(abs(mod2mat(:,1:end-1)))...
    +1.*sum(abs(mod2mat(:,1:end-1)-pred2mat(:,1:end-1)))...
    +1.*sum(abs(diff(mod2mat(:,1:end)')'));
x=[x 0];
highsing2=[highsing2 [mean(x(end-100*3:end-1))]];

end



thiscond=5
highmult2=[];
for trial=1:nSubs
reynolds_sequence
her_model_arrays


x=1.*sum(abs(mod2mat(:,1:end-1)))...
    +1.*sum(abs(mod2mat(:,1:end-1)-pred2mat(:,1:end-1)))...
    +1.*sum(abs(diff(mod2mat(:,1:end)')'));
x=[x 0];
highmult2=[highmult2 [mean(x(end-100*3:end-1))]];
end

%reynoldsfigure 5
single_trials=[mean(bline2(1,:)') mean(lowsing2(1,:)') mean(highsing2(1,:)')];
mult_trials=[mean(lowmult2(1,:)') mean(highmult2(1,:)')];

%show figure 5
close all
plot([1 2 2.25], single_trials(1:3), 'rx-')
hold on
plot([1 2], mult_trials, 'bo-');
xlim([.75 2.5])
title('reynolds et al., 2012, figure 5 (upper right frame)')
% % % %uncomment this stuff if you want to save the results.
% % % save reynolds_data_testnewagain.mat bline2 lowmult2 lowsing2 highsing2 highmult2
% % % 
% % % csvwrite('reynolds_data2testnewagain.txt', [bline2' lowsing2' highsing2' lowmult2' highmult2']);


