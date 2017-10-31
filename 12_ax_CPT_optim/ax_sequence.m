%the idea here is to generate a stimulus sequence for the task, as well as
%the correct response for each stimulus.  There is nothing preventing one
%from doing this on the fly in the model loop; this is just to save time.

stim_seq=[];%this is where the stimulus ID will be 
resp_seq=[];%correct response vector


targ_seq=[]; 
block_seq=[];
for i=1:trialN; %number of outer loops (context variable presentations
    tmpseq1=[];
    tmpresp1=[];
    if rand>.5; %determine context variable
        tmpseq1=1; 
    else
        tmpseq1=2;
    end
    tmpresp1=[2];%default, non-target response to contex variables.
    targ_seq=[targ_seq 0];
    
    %how many innerloop sequences?
    this_num=randperm(4);
    this_num=this_num(1);
    
    %depending on the context, these are the non-target sequences 
    nontargs2=[ 4 5; 3 5; 3 6];
    nontargs1=[ 4 5; 4 6; 3 6];

    %these are sequences with distractor stimulu (Cs and 3s)
    nontargs_distractors=[7 8; 3 8; 4 8; 7 8; 7 5; 7 6];
    
    %context specific non-target sequences
    nontargs2=[nontargs2; nontargs_distractors];
    nontargs1=[nontargs1; nontargs_distractors];
    
    %loop through the total inner loop sequences for this outer loop
    for j=1:this_num

        tmpseq2=[];
        tmpresp2=[];
        
        if rand < .5 %is target sequence (35, 46) - not necessary a valid target sequence though
        
           choose_targ=randperm(2);
           choose_targ=choose_targ(1);
           
           if choose_targ==2
               tmpseq2=[4 6];
               tmpresp2=[2 2];
               if tmpseq1(1)==2;tmpresp2=[2 1];end
           else
               tmpseq2=[3 5];
               tmpresp2=[2 2];
               if tmpseq1(1)==1;tmpresp2=[2 1];end
           end
           

        else
            %non-target  %pick one of the non-target sequences for this
            %context
            tmpresp2=[2 2];
                thisun=randperm(size(nontargs2, 1));
                thisun=thisun(1);
            if tmpseq1(1)==2
               tmpseq2=nontargs2(thisun,:);
            else
                tmpseq2=nontargs1(thisun,:);
            end
        end
        tmpseq1=[tmpseq1 tmpseq2];
        tmpresp1=[tmpresp1 tmpresp2];
       
    end
    %concatenate everything together
    stim_seq=[stim_seq tmpseq1];
    resp_seq=[resp_seq tmpresp1];
     block_seq=[block_seq ones(1,size(tmpresp1,2)).*tmpseq1(1)];
end

            
            
            