function [resp]=get_response(resp_act, resp_temp)

resp_sel=exp(resp_temp.*resp_act)./(sum(exp(resp_temp.*resp_act)));%softmax

tmpsel=[0 cumsum(resp_sel)];
tempresp=find(rand>tmpsel);
resp=tempresp(end);


