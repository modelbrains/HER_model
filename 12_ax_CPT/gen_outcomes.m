function new_outcome=gen_outcomes(prediction, outcome, curr_mem, filter);
new_outcome=[];
for i=1:length(curr_mem);
 
    
    tmp_out=(outcome-(prediction.*(outcome~=0))).*curr_mem(i);
   % tmp_out=(outcome-(prediction.*filter)).*curr_mem(i);
   %  tmp_out=(outcome-(prediction.*(outcome~=0))).*curr_mem(i);
    tmp_out=((outcome-(prediction)).*1).*curr_mem(i);
     
    new_outcome=[new_outcome tmp_out];
end
%new_outcome=new_outcome.*filter;
%we may have to reconsider something about this - in the original scripts,
%I had the 3rd level outcomes filtered by outcome2~=0.  I can't imagine why
%I did that, but it might have been important?  Something about not
%learning about events that didn't occur.