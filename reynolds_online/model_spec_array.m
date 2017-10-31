%specify model parameters and architecture

num_layers=3; %number of layers in the hierarchy
num_stim=21; %number of stimuli in the task
num_out=6; %number of unique response outcome conjunctions
num_resps=3;
weights={};
attweights={};
curr_mem={};
prev_stim={};
wm_tmp={};
alpha={};
trace_decay={};
for i=1:num_layers
    weights{i}=zeros(num_stim, num_stim.^(i-1).*num_out);
    attweights{i}=zeros(num_stim+1, num_stim);
    curr_mem{i}=zeros(1,num_stim);
    prev_stim{i}=zeros(1,num_stim);
end

curr_stim=zeros(1,num_stim);  %vector containing currently presented stimulus
pos_neg_outs=[1 2; 3 4; 5 6];%specifies for each of the responses (rows) which correspond to positive (1st column) and negative (2nd column) outcomes
resp_temp=12;

trace_decay{1}=.3;
trace_decay{2}=.5;
trace_decay{3}=.9;
wm_temp{1}=12;
wm_temp{2}=12;
wm_temp{3}=12;
alpha{1}=.1;
alpha{2}=.02;
alpha{3}=.02;