function new_outcome=gen_outcomes(prediction, outcome, curr_mem, filter);
new_outcome=[];
for i=1:length(curr_mem);
 
    
    tmp_out=(outcome-(prediction.*(outcome~=0))).*curr_mem(i);
    tmp_out=((outcome-(prediction)).*1).*curr_mem(i);
     
    new_outcome=[new_outcome tmp_out];
end
