
num_layers=3; %number of layers in the hierarchy
num_stim=18; %number of stimuli in the task
num_out=10; %number of unique response outcome conjunctions
num_resps=5; %total number of responses
weights={}; %array for assoc. weights
attweights={}; %array for WM gating
curr_mem={}; %array for WM reps
prev_stim={}; %eligibility trace array
wm_tmp={}; %holds WM gain params
alpha={}; %assoc. learning rate params
trace_decay={}; %elig. trace decay %params

%create weight matrices based on stimuli and outcomes spec'd above
for i=1:num_layers
    weights{i}=zeros(num_stim, num_stim.^(i-1).*num_out);
    attweights{i}=zeros(num_stim+1, num_stim);
    curr_mem{i}=zeros(1,num_stim);
    prev_stim{i}=zeros(1,num_stim);
  
end

curr_stim=zeros(1,num_stim);  %vector containing currently presented stimulus
pos_neg_outs=[1 2; 3 4; 5 6; 7 8; 9 10];%specifies for each of the responses (rows) which correspond to positive (1st column) and negative (2nd column) outcomes
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