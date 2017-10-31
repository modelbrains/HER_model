stim_seq=[];
resp_seq=[];
faux_resp_seq=[];
conds=[1 2 3 4 5 6 7 8];

blocklength=12;
%conditions from koechlin et al. 2003 supplement
% first 8 stimuli are the condition cues
% next 4 stimuli are letter identities - upper/lower case, vowel/consonant
%stimulus setup conds 1-8 = stim 1-8
%          red=13
%          green=14; 
%          white=15;
%          yellow=16;
%          blue=17;
%          cyan=18;

%ro conjunctions
%left/correct = 1
%left/error=2
%right/correct=3
%right/error=4
%nr/correct=5 %no responses
%nr/error=6


for i=1:trialN; %cycle through blocks
    %get current condition
    thiscond=randperm(length(conds));
    thiscond=conds(thiscond(1));
    actcond=[thiscond;thiscond];

% % % % tmp variables for storing the stimuli and responses for the current 
        tmpseq=[];
        tmpresp=[];
        faux_resp=[];
switch thiscond
    case 1 %task 1 (vowel/consonant judgments)
       
        for j=1:blocklength
            thisseq=zeros(2,1);
            thisresp=zeros(1,1);
            thisresp(1,1)=5;%correct response is no response
            resps=[1 1 2 2];%vowel vowel, cons, cons
            type=randperm(4); %decide if this letter is a consonant or vowel
            type=type(1);
               thisseq(2,1)=8+type; 

        if rand>.33
        
          color=13;%green
          thisresp(1,1)=resps(type);
          
        
        else
            color=15;%black - no task
            thisresp(1,1)=5;
        end
         thisseq(1,1)=color;
         thisseq;
      tmpseq=[tmpseq thisseq];
      tmpresp=[tmpresp thisresp];
      faux_resp=[faux_resp 1 0];
    
        end
        
    case 2 %task 2 (lower/upper case)
        
            for j=1:blocklength
            thisseq=zeros(2,1);
            thisresp=zeros(1,1);
            resps=[3 4 3 4];%vowel vowel, cons, cons
     
            type=randperm(4);
            type=type(1);
               thisseq(2,1)=8+type; 
                thisresp(1,1)=5;
            
        if rand>.33
        
          color=14;%red
          thisresp(1,1)=resps(type);
          
        
        else
            color=15;%black
            thisresp(1,1)=5;
        end
        thisseq(1,1)=color;
      tmpseq=[tmpseq thisseq];
      tmpresp=[tmpresp thisresp];
      faux_resp=[faux_resp 1 0];
        end
        
    case 3 %2 task - vowel/consonant for green, upper/lower case for red
          for j=1:blocklength
            thisseq=zeros(2,1);
            thisresp=zeros(1,1);
            
            type=randperm(4);
            type=type(1);
            thisseq(2,1)=8+type; 
             thisresp(1,1)=5;
        if rand>.33 %red or green cue
             %it's a task cue, but which one?
            if rand>.5%red, let's say
                resps=[3 4 3 4];

                 color=14;%red
                  thisresp(1,1)=resps(type);
            else
                resps=[1 1 2 2];
                   color=13;%green
                   thisresp(1,1)=resps(type);
            end
        else
                  color=15;
                   thisresp(1,1)=5;
        end
         thisseq(1,1)=color;
        tmpseq=[tmpseq thisseq];
         tmpresp=[tmpresp thisresp];
         faux_resp=[faux_resp 1 0];
        end
    case 4 %2 choice/ right on red and left on green
            for j=1:blocklength
            thisseq=zeros(2,1);
            thisresp=zeros(1,1);
            
            type=randperm(4);
            type=type(1);
            thisseq(2,1)=8+type; 
             thisresp(1,1)=5;
        if rand>.33 %red or green cue
            if rand>.5%red, let's say
                resps=[3 4 3 4];

                 color=14;
                  thisresp(1,1)=resps(type);
            else
                resps=[1 1 2 2];
                   color=13;
                   thisresp(1,1)=resps(type);
            end
        else
                  color=15;
                   thisresp(1,1)=5;
        end
         thisseq(1,1)=color;
         tmpseq=[tmpseq thisseq];
         tmpresp=[tmpresp thisresp];
         faux_resp=[faux_resp 1 0];
        end
    case 5 %1 choice/ task1 on blue and cyan - ignore on yellow
        
       for j=1:blocklength
           thisseq=zeros(2,1);
            thisresp=zeros(1,1);
            
            type=randperm(4);
            type=type(1);
            thisseq(2,1)=8+type; 
             thisresp(1,1)=5;
           resps=[1 1 2 2];%vowel vowel consonant consonant
       
        if rand>.33
            if rand>.5
                  color=17;
                   thisresp(1,1)=resps(type);
            else
                  color=18;
                    thisresp(1,1)=resps(type);
            end
        else
            color=16;
          thisresp(1,1)=5;
        end
                 thisseq(1,1)=color;
         tmpseq=[tmpseq thisseq];
         tmpresp=[tmpresp thisresp];
         faux_resp=[faux_resp 1 0];
       end

    case 6 %task2 on yellow and cyan, ignore on blue
        
          for j=1:blocklength
            thisseq=zeros(2,1);
            thisresp=zeros(1,1);            
            type=randperm(4);
            type=type(1);
            thisseq(2,1)=8+type; 
             thisresp(1,1)=5;
          resps=[3 4 3 4];

        if rand>.33
            if rand>.5
                 color=16;
                  thisresp(1,1)=resps(type);
            else
                 color=18;
                   thisresp(1,1)=resps(type);
            end
        else
            color=17;
            thisresp(1,1)=5;
        end
                 thisseq(1,1)=color;
         tmpseq=[tmpseq thisseq];
         tmpresp=[tmpresp thisresp];
         faux_resp=[faux_resp 1 0];
          end

    case 7 %2 choice/left on yellow, right on blue, nr on cyan
         for j=1:blocklength
            thisseq=zeros(2,1);
            thisresp=zeros(1,1);            
            type=randperm(4);
            type=type(1);
            thisseq(2,1)=8+type; 
            thisresp(1,1)=5;
        if rand>.33
            if rand>.5
                  resps=[3 4 3 4];

                  color=17;
                 thisresp(1,1)=resps(type);
            else
                 resps=[1 1 2 2 ];
                  color=16;
                   thisresp(1,1)=resps(type);
            end
        else
                   color=18;
                   thisresp(1,1)=5;
        end
               thisseq(1,1)=color;
         tmpseq=[tmpseq thisseq];
         tmpresp=[tmpresp thisresp];
         faux_resp=[faux_resp 1 0];
         end
   
          case 8 %2 choice/left on yellow, right on blue, nr on cyan
                  for j=1:blocklength
            thisseq=zeros(2,1);
            thisresp=zeros(1,1);            
            type=randperm(4);
            type=type(1);
            thisseq(2,1)=8+type; 
             thisresp(1,1)=5;
        if rand>.33
            if rand>.5
                  resps=[3 4 3 4];

                  color=17;
                 thisresp(1,1)=resps(type);
            else
                 resps=[1 1 2 2 ];
                  color=16;
                   thisresp(1,1)=resps(type);
            end
        else
                   color=18;
                   thisresp(1,1)=5;
        end
                  thisseq(1,1)=color;
         tmpseq=[tmpseq thisseq];
         tmpresp=[tmpresp thisresp];
         faux_resp=[faux_resp 1 0];
                  end

end

stim_seq=[stim_seq actcond tmpseq];
resp_seq=[resp_seq 5 tmpresp];
faux_resp_seq=[faux_resp_seq 0 faux_resp];
end

