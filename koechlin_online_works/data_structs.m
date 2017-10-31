%%%create some variables for storing data
correct_responses=zeros(1,length(stim_seq));%keep track of correct and incorrect responses
pcorrect=zeros(1,length(stim_seq)); %keep track of the activity of the output unit corresponding to the correct response

%for  purposes of the stimuli generated by koechlin_context2, the num_dat must be in multiples of 25
num_data=26000;%specifies how much data we should save (from the end of the experiment)... allows for learning to take place 1st without using it to plot activity

%matrices for storing the unmodulated predictions at each layer
pred3mat=zeros(num_stim.^2.*num_out,num_data);
pred2mat=zeros(num_stim.*num_out,num_data);
pred1mat=zeros(num_out, num_data);

%matrices for storing themodulated predictions at each layer
mod3mat=pred3mat;
mod2mat=pred2mat;
mod1mat=pred1mat;

%matrices for storing the weight strengths at each layer at each iteration
wm3mat=zeros(num_stim,num_data);
wm2mat=zeros(num_stim,num_data);
wm1mat=zeros(num_stim,num_data);

%determine when to start recording.
max_trial=length(stim_seq);
record_start=max_trial-num_data+1;