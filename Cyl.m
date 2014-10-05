classdef Cyl< Actuator
    %CYL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function self=Cyl()
            self = self@Actuator(0,.5,0);
        end
        function [x y]=getShape(self)
            radius=0.1;
            numPoints=100;
            theta=linspace(0,2*pi,numPoints);
            rho=ones(1,numPoints)*radius;
            [x,y] = pol2cart(theta,rho);
        end
        function t=getType(self)
            t='Cylindrical';
        end
        
        function [dx, dy]=getDisplacement(self, t)
            amp=.02;
            freq=4;
            dx=amp*sin(2*pi*freq*t);
            dy=amp*cos(2*pi*freq*t);
        end
        
        
    end
    
end

