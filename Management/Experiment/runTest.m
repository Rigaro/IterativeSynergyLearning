while(i<iMax)
%     appendIterationHIL2
%     updateSynergyHIL2
    appendIterationHIL4
    updateSynergyHIL4
%     set_param('sim2DOFArmSynergyTemplate','SimulationCommand','start');
%     simOut = sim('hil2DOFArmSynergyTemplate', model_cs);
    simOut = sim('hil4DOFArmSynergyTemplate', model_cs);
end