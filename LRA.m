classdef LRA < Actuator
    methods
        function self=LRA()
            self = self@Actuator(0,.5,0);
        end
        
        function [dx, dy]=getDisplacement(self, t)
            amp=.05;
            freq=5;
            dy=amp*sin(2*pi*freq*t);
            dx=0;
        end
        
        function t=getType(self)
            t='Linear';
        end
    end
    
end

