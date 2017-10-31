%generally the idea is that we pregenerate a stimulus sequence (and
%associated target responses) based on the contingencies of the experiment
%described in the paper.  Individual experiments tend to be intricate, so
%most of this is obfuscatory... i'll try to mark up the first condition,
%and the rest are left as an exercise for the reader

stim_seq=[];
resp_seq=[];

%conds=1:5 %low through high levels of abstraction;
%conds=2
%1 - baseline
%2 - low level - single trial
%3 - low level - multi-trial
%4 - high level - single trial
%5 - high level - multi trial

blocklength=5;

%ro conjunctions
%left/correct = 1
%left/error=2
%right/correct=3
%right/error=4
%nr/correct=5
%nr/error=6

for i=1:1000
    
%thiscond comes from the runreynolds2012 script
    actcond=thiscond;
tmpseq=[];
tmpresp=[];

switch thiscond
    case 1 %baseline
        %possible target stimuli and their associated responses
        poss_targs=[17 18 19 20];
        resps=[ 1 2 2 1];

        %populate this block
        for j=1:blocklength
            %init some block variables
        this_bit=zeros(1,3);
        this_resp=this_bit;
        
        %get target stimuli and responses
        targ=randperm(4);
        target=poss_targs(targ(1));
        targresp=resps(targ(1));
        
        %since this is the baseline condition, the first two stimuli are
        %'?' (see reynolds_stimmapping file for mapping)
        this_bit(1)=21;
        this_bit(2)=21;
        this_bit(3)=target;
        %the first two stimuli have a null response (==3), and a target
        %response on the third
        this_resp(1)=3;
        this_resp(2)=3;
        this_resp(3)=targresp;
        
        %concatenate this part of the sequence onto the whole.
        tmpseq=[tmpseq this_bit];
        tmpresp=[tmpresp this_resp];
        end
        tmpseq(1)=1;
        

    case 2 %lowlevel abstraction - single trial
        poss_cues=[7:10];
        
      for j=1:blocklength
        this_bit=zeros(1,3);
        this_resp=this_bit;
        targcue=randperm(4);
        thiscue=poss_cues(targcue(1));
        
        targtarg=randperm(2);
        targ=targtarg(1);
        if thiscue==7||thiscue==8
            this_bit(3)=12+targ;
            if thiscue==7
            this_resp(3)=targ;
            else
                this_resp(3)=-targ+3;
            end
        else
            this_bit(3)=14+targ;
            if thiscue==9
            this_resp(3)=-targ+3;
            else
                this_resp(3)=targ;
            end
        end
        this_resp(1)=3;
        this_resp(2)=3;
        this_bit(1)=21;
        this_bit(2)=thiscue;
        
        tmpseq=[tmpseq this_bit];
        tmpresp=[tmpresp this_resp];
      end
      
         tmpseq(1)=2;
        
    case 3 %lowlevel abstraction -  multitrial
              
         poss_cues=[7:10]; 
         targcue=randperm(4);
          thiscue=poss_cues(targcue(1));
         for j=1:blocklength
         this_bit=zeros(1,3);
         this_resp=this_bit;
         
         targtarg=randperm(2);
         targ=targtarg(1);
        if thiscue==7||thiscue==8
            this_bit(3)=12+targ;
            if thiscue==7
            this_resp(3)=targ;
            else
                this_resp(3)=-targ+3;
            end
        else
            this_bit(3)=14+targ;
            if thiscue==9
            this_resp(3)=-targ+3;
            else
                this_resp(3)=targ;
            end
        end
        this_bit(2)=21;
        
        this_bit(1)=21;
        this_resp(1)=3;
        this_resp(2)=3;
         
        if j==1
            this_bit(2)=thiscue;
            
        end
          tmpseq=[tmpseq this_bit];
        tmpresp=[tmpresp this_resp];
         end
         tmpseq(1)=2;

    case 4 %highlevel abstract - single trial
        
        poss_ucues=[3 4];           
        poss_lcues=[5 6];
        poss_targs=[11 12];
        
        
      for j=1:blocklength
         this_bit=zeros(1,3);
         this_resp=this_bit; 
          
        targ_ucue=randperm(2);
        targ_ucue=poss_ucues(targ_ucue(1));
        targ_lcue=randperm(2);
        targ_lcue=poss_lcues(targ_lcue(1));
        targ_targ=randperm(2);
        targ_targ=poss_targs(targ_targ(1));
        
        ul=[num2str(targ_ucue) num2str(targ_lcue)];
        ul=str2double(ul);
        switch ul
            
            case 35
              if rand>.5
                  this_bit(3)=11;
                  this_resp(3)=1;
              else
                  this_bit(3)=12;
                  this_resp(3)=2;
              end
           case 36
              if rand>.5
                  this_bit(3)=12;
                  this_resp(3)=1;
              else
                  this_bit(3)=11;
                  this_resp(3)=2;
              end
           case 45
              if rand>.5
                  this_bit(3)=12;
                  this_resp(3)=1;
              else
                  this_bit(3)=11;
                  this_resp(3)=2;
              end
            
          case 46
              if rand>.5
                  this_bit(3)=11;
                  this_resp(3)=1;
              else
                  this_bit(3)=12;
                  this_resp(3)=2;
              end
        end
        this_bit(1)=targ_ucue;
        this_bit(2)=targ_lcue;
        this_resp(1)=3;
        this_resp(2)=3;
     tmpseq=[tmpseq this_bit];
        tmpresp=[tmpresp this_resp];
      end
      
        
    case 5 %highlevel abstraction - multi trial
        poss_ucues=[3 4];           
        poss_lcues=[5 6];
        poss_targs=[11 12];
        
        targ_ucue=randperm(2);
        targ_ucue=poss_ucues(targ_ucue(1));
       for j=1:blocklength
        this_bit=zeros(1,3);
        this_resp=this_bit; 
             
        targ_lcue=randperm(2);
        targ_lcue=poss_lcues(targ_lcue(1));
        targ_targ=randperm(2);
        targ_targ=poss_targs(targ_targ(1));
        
        ul=[num2str(targ_ucue) num2str(targ_lcue)];
        ul=str2double(ul);
        switch ul
            
            case 35
              if rand>.5
                  this_bit(3)=11;
                  this_resp(3)=1;
              else
                  this_bit(3)=12;
                  this_resp(3)=2;
              end
           case 36
              if rand>.5
                  this_bit(3)=12;
                  this_resp(3)=1;
              else
                  this_bit(3)=11;
                  this_resp(3)=2;
              end
           case 45
              if rand>.5
                  this_bit(3)=12;
                  this_resp(3)=1;
              else
                  this_bit(3)=11;
                  this_resp(3)=2;
              end
            
          case 46
              if rand>.5
                  this_bit(3)=11;
                  this_resp(3)=1;
              else
                  this_bit(3)=12;
                  this_resp(3)=2;
              end
        end
        
       this_bit(1)=21;
        this_bit(2)=targ_lcue;
        this_resp(1)=3;
        this_resp(2)=3;
     tmpseq=[tmpseq this_bit];
        tmpresp=[tmpresp this_resp];
    
       end
tmpseq(1)=targ_ucue;


end

stim_seq=[stim_seq tmpseq];
resp_seq=[resp_seq  tmpresp];
end

