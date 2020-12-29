%HER model temporal dynamics.  Requires that weight matrices and vectors 
%derived from the original version of the HER model are in the MatLab workspace.
%including: attweights, weights, curr_mem.  Note that this is an example
%script that needs additional apparatus to run an actual simulated
%experiment.


%initialize activity vectors

    %Working Memory Representation vectors
    initact1=0.*curr_mem{1}; %level 1
    initact2=0.*curr_mem{1}; %level 2
    
    %Hierarchical Level Output Vectors
    initout=zeros(1,num_out);
    initpred2=0.*predictions{2};
    
    %Error Activity Vectors 
    initerract1=initout;
    initerract2=initpred2;
    
    %Stimuli - the vector should be updated to reflect the combination of
    %features for a trial
    trial_stim=ones(1,size(attweights{1},1))';

%shunting equation parameters
asymptote=10;%upper firing boundary
decay_mult=.05; %activity decay
eta=.0075; %time constant
noise=.00; %gaussian noise variance
lb=.05;%lower boundary

%softmax parameters
beta=2.5;
gamma=2.5;
      
%Simulation Params
pIter=800;%number of iterations
StimOnset=101;
StimOffset=350;
FeedbackOnset=300;
FeedbackOffset=350;

%simulation loop
for pN=1:pIter;
    
    %check whether stimulus is present or absent
    if pN<StimOnset  
        curr_stim=trial_stim.*0;
    else
        curr_stim=trial_stim;
    end
    if pN>StimOffset
        curr_stim=trial_stim.*0;
    end
     
    %%%%Now run the top-down pass through the model
     %start at level 2, 
     l2exc=[curr_stim;0]'*attweights{2};%calculate WM activitity for 2nd hierarchical level
     deltal2=(asymptote-initact2).*l2exc - (initact2+decay_mult) +randn(1,length(curr_mem{2})).*noise;
     initact2=initact2+eta.*deltal2;
     initact2(initact2<0)=0;
    
     %softmax
     pact2=exp(beta.*initact2)./(sum(exp(beta.*initact2)));
    
    %%get output of level 2
      pred2=pact2*weights{2};
     deltap2=(asymptote-initpred2).*pred2 - (initpred2+decay_mult) +randn(1,length(pred2)).*noise;
     initpred2=initpred2+eta.*deltap2;
        
     %output of level 2 will be used to modulate level 1 activity
     tmpmod(:,pN)=initpred2';
    

    %%now do layer 1 with modded weights
     l1exc=[curr_stim;0]'*(attweights{1});
     mut_inhib_weights=eye(length(curr_mem{1}));mut_inhib_weights=(mut_inhib_weights-1).*0.5;
     deltal1=(asymptote-initact1).*l1exc - (initact1+decay_mult) +randn(1,length(curr_mem{1})).*noise;
     initact1=initact1+eta.*deltal1;
     initact1(initact1<0)=0;
    %softmax
       pact1=exp(beta.*initact1)./(sum(exp(beta.*initact1)));
       
    %apply top-down modulation of level 1 weights
       modweight{1}=weights{1}+reshape(initpred2,10,7)';

       %now get output of level 1 with mutual inhibition
        out_exc=initact1*modweight{1};
        inhibit_weights=eye(10);inhibit_weights=(inhibit_weights-1);
        out_inh=initout*inhibit_weights;

        delta_out=(asymptote-initout).*out_exc - (initout+decay_mult+out_inh) +randn(1,num_out).*noise;
        initout=initout+eta.*delta_out;
        initout(initout<0)=0;
        
        %softmax for response
        pout=exp(gamma.*initout)./(sum(exp(gamma.*initout)));
        tmpout(:,pN)=initout;
        tmp_pout(:,pN)=pout;
 
        
        %display feedback to model - this will depend on the experiment
        %details...
        if pN>FeedbackOnset;
           outcome= [0 0 0 0 0  1  0 1 0 0];
       else
           outcome=[0 0 0 0 0 0 0 0 0 0];
        end
       if pN>FeedbackOffset
           outcome=[0 0 0 0 0 0 0 0 0 0];
       end
     
       
       %Now do the bottom-up error processing stuff
       err=outcome-pout; %calculate level 1 error
       derr1_exc=abs(err);%tmp_p1(:,end)*err;    
       derr1=(errasymptote-initerract1).*abs(derr1_exc)-(initerract1+lb) + randn(1,length(err)).*noise;
        initerract1=initerract1+eta.*derr1;
        
        %composite 2nd level error signal
        derr2_exc=pact1'*abs(initerract1);
        derr2_exc=reshape(derr2_exc, 1, length(pact1).*length(pout));
        derr2=(errasymptote-initerract2).*abs(derr2_exc)-(initerract2+lb)+ randn(1,length(initerract2)).*noise;
        initerract2=initerract2+eta.*derr2;

end  %and go back to the beginning
        