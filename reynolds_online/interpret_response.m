function [outcome, filter]=interpret_response(resp, pos_neg_outs, cor_resp)

temp_outcome=zeros(size(pos_neg_outs));

if resp==cor_resp
    temp_outcome(resp,1)=1;
else
    temp_outcome(resp,2)=1;
   
end

outcome=reshape(temp_outcome', 1, numel(temp_outcome));
%disp(num2str(outcome))
temp_outcome(resp,:)=1;
filter=reshape(temp_outcome', 1, numel(temp_outcome));

