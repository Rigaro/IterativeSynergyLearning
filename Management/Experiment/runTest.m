while(i<50)
    appendIteration
    updateSynergy
%     set_param('sim2DOFArmSynergySimulink','SimulationCommand','start');
    simOut = sim('hmi2DOFArmSynergySimulink', model_cs);
end