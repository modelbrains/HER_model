%specify model parameters and architecture.

num_layers=3; %number of layers in the hierarchy
num_stim=8; %number of stimuli in the task
num_out=4; %number of unique response outcome conjunctions
num_resps=2; %number of responses available for the model
weights={}; %assoc. weight array
attweights={}; %WM weight array
curr_mem={}; %contents of WM at each hierarchical level
prev_stim={}; %array for storing delay trace
wm_temp={}; %array for layer-wise softmax gain param
alpha={}; %layer-wise assoc. learning rate.
bias={}; %not used
trace_decay={};%decay parameter for each layer
for i=1:num_layers %create assoc. and WM weights for each layer.
    weights{i}=zeros(num_stim, num_stim.^(i-1).*num_out);
    attweights{i}=zeros(num_stim+1, num_stim);
    curr_mem{i}=zeros(1,num_stim);
    prev_stim{i}=zeros(1,num_stim);
    
end

curr_stim=zeros(1,num_stim);  %vector containing currently presented stimulus
pos_neg_outs=[1 2; 3 4];%; 5 6];%specifies for each of the responses (rows) which correspond to positive (1st column) and negative (2nd column) outcomes

resp_temp=12;%gain for response selection

trace_decay{1}=.3;
trace_decay{2}=.5;
trace_decay{3}=.9;
bias{1}=1;
bias{2}=.1;
bias{3}=.01;
default_temp=12;
wm_temp{1}=default_temp;
wm_temp{2}=default_temp;
wm_temp{3}=default_temp;

alpha{1}=.1;
alpha{2}=.02;
alpha{3}=.02;