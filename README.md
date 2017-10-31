# HER_model
Simulations for HER model (Alexander & Brown, 2015, Neural Computation; Alexander & Brown, forthcoming)

Code for selected simulations of the HER model in manuscript under consideration:
  Koechlin et al, 2003, Task Condition -- 
    run script 'koechlin_task_wrapper.m' to run the model/ 
    run 'process_task_data.m' to plot the data as in Koechlin et al., Figure 4
    
  Reynolds et al., 2012, Figure 5 -- 
    run script: runreynolds2012.m/
    figure 5 will be plotted for you
    
  12-AX CPT --
    run script run_12ax.m/
    the model will run through ~16000 loops of the 12-AX CPT, and the accuracy over time will be plotted.
    
  12-AX CPT - better performance --
    same as above, but the parameters are less bad, so it tends to converge a bit more quickly/reliably
  
    
Note that these simulations were conducted using a single, non-optimized parameter set - consequently,
the performance of the HER model is, well, suboptimal.  Sometimes it fails to learn - as do we all,
from time to time.  Makes one think.

