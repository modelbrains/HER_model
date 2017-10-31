function [outcome, filter]=interpret_response(resp, pos_neg_outs, cor_resp)
%really all this function seems to do is take the response, check to see if
%it matches the correct response or not, and then puts it into a feedback
%vector
temp_outcome=zeros(size(pos_neg_outs));

if resp==cor_resp
    temp_outcome(resp,1)=1;
else
    temp_outcome(resp,2)=1;
   
end

outcome=reshape(temp_outcome', 1, numel(temp_outcome));
temp_outcome(resp,:)=1;
filter=reshape(temp_outcome', 1, numel(temp_outcome));

