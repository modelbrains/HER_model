function [curr_mem, prev_stim]=updateWM(att_weights, curr_stim, curr_mem, wm_temp, prev_stim)

val=[curr_stim 0]*att_weights; %get value of current stimulus replacing any possible contents of WM
val_old=sum(val.*curr_mem); %value of replacing actual contents of WM
val_new=sum(val.*curr_stim); %value of new contents of WM

maintain=exp(wm_temp.*val_old)./(exp(wm_temp.*val_old)+exp(wm_temp.*val_new)); %Softmax

if rand>maintain
    if sum(curr_stim==curr_mem)~=length(curr_stim) %is there an actual difference between the two?
        curr_mem=curr_stim; %insert current stimulus into WM
        prev_stim=prev_stim.*0; %erase stimulus traces - may want to revisit whether this is necessary
      
    end
end
if sum(curr_mem)==0
    curr_mem=curr_stim;
end
