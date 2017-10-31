subN=10;

for i=1:subN
    thisfile=['koechlin_task_experiment_' num2str(i) '.mat'];
    her_model_arrays;%_activebaseline;
    koechlin_motor_plot_task3;
    koechlin_abstract_plot_task3;
    koechlin_context_plot_task3;
eval(['save ' thisfile ' tr1 tr2 tr3 tr4 tr5 tr6 tr7 tr8 '...
                                            'cr1 cr2 cr3 cr4 cr5 cr6 cr7 cr8 '...
                                            'ar1 ar2 ar3 ar4 ar5 ar6 ar7 ar8'])
end

                                        