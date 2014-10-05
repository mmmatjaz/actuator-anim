classdef Coin < Actuator
    methods
        function self=Coin()
            self = self@Actuator(0,.5,0);
        end
        
        
        function [dx, dy]=getDisplacement(self, t)
            amp=.05;
            freq=3;
%             set(self.r,'facecolor',(.7-abs(x)*5)*[1 1 1]);
            dx=amp*sin(2*pi*freq*t);
            dy=0;
        end
        function t=getType(self)
            t='Coin';
        end
    end
    
end

