function smoothvec=smoove(thisvec, window);
if length(thisvec)>window
    tmpvec=zeros(1,length(thisvec)-window);
for i=1:length(thisvec)-window;
  
    tmpvec(1,i)=mean(thisvec(1, i:(i+window-1)));
end
smoothvec=tmpvec;
    

end