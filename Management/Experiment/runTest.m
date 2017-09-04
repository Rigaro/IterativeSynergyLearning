while(i<50)
    appendIteration
    updateSynergy
%     set_param('sim2DOFArmSynergyTemplate','SimulationCommand','start');
    simOut = sim('hil2DOFArmSynergyTemplate', model_cs);
end