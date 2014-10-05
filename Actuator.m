classdef Actuator < handle
    %ACTUATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = protected)
        x0;
        y0;
        r;
        vidObj;
        vidObjSet=0;
    end
    
    methods
        function self=Actuator(x0,y0,alpha)
            [x, y]=self.getShape();
            self.r=patch(x,y,.7*[1 1 1]);
            center=[mean(get(self.r,'Xdata')) mean(get(self.r,'Ydata')) 0];
            rotate(self.r,[0 0 1],alpha,center)
            self.x0=get(self.r,'Xdata');
            self.x0=self.x0+ones(size(self.x0)).*(x0);
            self.y0=get(self.r,'Ydata');
            self.y0=self.y0+ones(size(self.y0)).*(y0);
            set(self.r,'Xdata',self.x0)
            set(self.r,'Ydata',self.y0)
        end
        
        % get the polygon
        function [x, y]=getShape(self)
            b = .25;
            h = .1;
            x=[-b/2 b/2 b/2 -b/2];
            y=[-h/2 -h/2 h/2 h/2];
        end
        
        % move the patch for dx, dy
        function move(self,dx,dy)
            set(self.r,'Xdata',self.x0+ones(size(self.x0)).*dx);
            set(self.r,'Ydata',self.y0+ones(size(self.y0)).*dy);
        end
        
        % move randomly
        function shake(self)
            self.move(rand(1).*.05,rand(1).*.05);
            set(self.r,'facecolor',.5*[1 1 1]);
        end
        
        % reset position to initial
        function reset(self)
            set(self.r,'Xdata',self.x0);
            set(self.r,'Ydata',self.y0);
            set(self.r,'facecolor',.7*[1 1 1]);
        end
        
        % set the video object to record during click
        function setAviParams(self, vidObj)
            self.vidObj=vidObj;
            self.vidObjSet=1;
        end
        
        % shake it baby
        function click(self, dur)
            tic;
            t=toc;
            while t<dur
                t=toc;
                [dx, dy]=self.getDisplacement(t);
                self.move(dx,dy);
                pause(1/25)
                drawnow
                if self.vidObjSet==1
                    writeVideo(self.vidObj, getframe(gca));
                end
            end
            self.reset();
        end
        
        % ABSTRACT get displacement
        function [dx, dy]=getDisplacement(self, t)
            dx=rand(1).*.05;
            dy=rand(1).*.05;
            set(self.r,'facecolor',.5*[1 1 1]);
        end
        
        % get name
        function t=getType(self)
            t='';
        end
        
        
    end
    
    
end

