%HER Model

%%general algorithm: 
%1: model gets input from environment
%2: at each hierarchical level, determines whether to update WM
%3: at each hierarchical level gets predictions based on WM after updating
%4: gets predictions modulated by higher order layers 
%5: at bottom layer, selects response using softmax based on modulated
%   predictions
%6: interprets response given task contingencies (generated using pregenerated sequences)
%7: uses feedback from 6 to get error and outcomes for higher layers using regular generated predictions
%8: attentional error for BG learning obtained by backpropagating error at
%   each level using modulated weights
%9: BG and mPFC weights updated at each level
%10: stimulus traces updated

%specify number of trials
trialN=5000;

%generate stimulus sequence along with correct responses
% koechlin_context_bothstim
% koechlin_context2
%create model
model_spec_array;

%create variables for storing data, as well as when to collect data
data_structs


%arrays for storing model variables.
predictions={}; %predictions at each level
prev_stimtmp={};
modweight={}; %weights modulated by top-down influences
err={};%output error at each level
atterr={}; %backprop'd error at each level used to train WM gaiting
filter={}; %determines which units are eligible for learning
last_stim=1;
for i=1:length(stim_seq);

    %bit of fluff to keep track of progress
    if mod(i,1000)==0;
        disp([ num2str(i) '/' num2str(length(stim_seq))]);
    end

    %initialize input for the trial
    this_stim=stim_seq(:,i); %get current stimulus from pre-generated sequence
    cor_resp=resp_seq(i); %get the correct response
    curr_stim=curr_stim.*0; %make sure the last stimulus is removed
    curr_stim(this_stim)=1; %and enter the next stimulus
        

    
 %First Step - Do we update WM at each level or not. Iterate through model
 %layers
    for att=1:3 %calls script updateWM.m
            [curr_mem{att}, prev_stim{att}]=updateWM(attweights{att}, curr_stim,...
                curr_mem{att}, wm_temp{att}, prev_stim{att});

    end
%     curr_mem{1}=curr_stim;
%update eligibility traces
     for elig=1:num_layers
              
         prev_stim{elig}=prev_stim{elig}.*trace_decay{elig};
         prev_stim{elig}(this_stim)=1;

     end  
     

%get predictions for each level based on current WM contents
    for preds=1:num_layers 
        predictions{preds}=curr_mem{preds}*weights{preds};

    end
    
    %get top-down modulation and predictions from one (superior) layer to
    %the next (inferior)
    for this_layer=1:num_layers
        
        rev_layers=fliplr(1:num_layers);%work from the top down. num_layers is defined in model_spec_arrays
        mods=rev_layers(this_layer);
        
        
        if mods==num_layers %if we are at the top, nothing happens
            modweight{mods}=weights{mods};
            modpred{mods}=predictions{mods};

        else %otherwise adjust the weights for the current layer
            
            %1st update the weights
            modweight{mods}=weights{mods}+reshape(modpred{mods+1}, ....
                num_stim.^(mods-1)*num_out, num_stim)';
            %next update the predictions based on the updated weights.
            modpred{mods}=curr_mem{mods}*modweight{mods};
        end
        
        
    end %this_layer
    
    %get response predictions (affectively positive outcome given r - affectively negative outcome)
    resp_act=zeros(1,size(pos_neg_outs,1));  %oh, man, how do I explain pos_neg_outs?  
                                             %It is defined in
                                             %model_spec_array, and is an
                                             %N x 2 matrix, with N being
                                             %the number of responses (also
                                             %defined in model_spec_array,
                                             %and each column being the
                                             %affectively positive and
                                             %negative outcome,
                                             %respectively
    
    %okay, here we get the net output strength for each response by
    %subtracting the predicted negative outcome from the predicted positive
    %outcome at the lowest hierarchical level
    for resps=1:num_resps; %num_resps defined in model_spec_array
        resp_act(resps)=(modpred{1}(pos_neg_outs(resps,1))-modpred{1}(pos_neg_outs(resps,2)));
    end
    
    %keep track of the net strength of evidence in favor of the correct
    %response
    pcorrect(i)=resp_act(cor_resp);
    
    %get response with softmax activation function
    resp=get_response(resp_act, resp_temp);
    
    %store correct response or not
        if resp==cor_resp;
            correct_responses(i)=1;
        end
      
        
%%%%This completes the Top-Down pass - stimuli have been presented, WM
%%%%updated and information has filtered down from higher model levels to
%%%%lower model levels to inform the models response.  Now we do the
%%%%Bottom-Up pass where we interpret what the consequences of the action
%%%%just taken are, generate error signals, and pass those error signals up
%%%%the hierarchy.
        
    %interpret response - what are the consequences of what the model just
    %did?
     [outcome{1}, filter{1}]=interpret_response(resp, pos_neg_outs, cor_resp);
        
    %generate filters for higher layers - we only want to learn about
    %actions that were actually selected.
%      filter{1}=ones(1,num_out); 
     for f=2:num_layers;
  
     tmp_filt=curr_mem{f-1}'*filter{f-1};
     filter{f}=reshape(tmp_filt',1, numel(tmp_filt));

     end     
         
     %generate outcome vectors for higher levels based on error identity,
     %active WM representations
     for outs=2:num_layers;
         tmp_outcome=gen_outcomes(predictions{outs-1}, outcome{outs-1}, ...
             curr_mem{outs-1}, filter{outs});
         outcome{outs}=tmp_outcome;

     end
     

     %now we have outcomes for each layer, we can generate error signals
     %and update weights
     for es=1:num_layers;
         
         %error signal for updating associative weights
         err{es}=(outcome{es}-modpred{es}).*filter{es};
         %error signal for WM gating mechanism
         atterr{es}=(modweight{es}*err{es}')'.*curr_mem{es};
         
         %update WM gate weights

         attweights{es}=attweights{es}+ .1 .* ([prev_stim{es} 0]'*atterr{es});
         
         %update associative weights
         delta=curr_mem{es}' *err{es};
         weights{es}=weights{es} + alpha{es}.*delta;
         

     end

     
% % % % % % Now we are done with the Bottom-Up Pass, we can do some book-keeping
% % % % % % and get things ready for the next iteration.

     
last_stim=this_stim; %keep track of the previous stimulus for... some reason I guess?
    if i>=record_start; %are we recording data yet?
                pred3mat(:,i-record_start+1)= predictions{3}';
                pred2mat(:,i-record_start+1)=predictions{2}';
                pred1mat(:,i-record_start+1)=predictions{1}';
                mod3mat(:,i-record_start+1)=modpred{3}';
                mod2mat(:,i-record_start+1)=modpred{2}';
                mod1mat(:,i-record_start+1)=modpred{1}';
                wm3mat(:,i-record_start+1)=curr_mem{3}';
                wm2mat(:,i-record_start+1)=curr_mem{2}';
                wm1mat(:,i-record_start+1)=curr_mem{1}';

    end

end %model iteration

     
     
     
     
     
    
    
    
    