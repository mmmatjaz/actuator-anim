classdef Ani
    methods (Static)
        function fig=openFigure()
            fig=figure('doublebuffer','on');
%             set(gca,'XLim',[-1 1],'YLim',[-1 1])
            axis equal
            axis off
            ylim([-.5 .7])
            xlim([-1 1])
            set(gca, 'nextplot','replacechildren', ...
                'Visible','off');
            p=get(fig, 'Position');
            set(fig, 'Position',.8*p)
        end
        function plotElipse()
            a=.75;
            b=.45;
            cx=0;
            cy=0;
            angle=0;
            angle=angle/180*pi;

            r=0:0.1:2*pi+0.1;
            p=[(a*cos(r))' (b*sin(r))'];

            alpha=[cos(angle) -sin(angle)
                   sin(angle) cos(angle)];

             p1=p*alpha;
            color=[255,220,177]/255;
            patch(cx+p1(:,1),cy+p1(:,2),color,'EdgeColor',color);
        end
        
        function txt=plotText()
            txt=text(0,.8,...
                 sprintf(' '),...
                 'FontSize',30,'fontname','helvetica',...
                 'HorizontalAlignment','center');
        end
        
        function a=setActs4()
            pos=[0     .5; ... 
                .8      0;... 
                .0    -.5;...
               -.8      0];
            fi=[0 90 0 90];
            for i=1:4
                a(i)=Actuator(pos(i,1),pos(i,2),fi(i));
            end
        end
        
        function a=setActs2()
            pos=[-.3     .45; ... 
                  .3     .45];
            fi=[10 -10 0 90];
            for i=1:2
                a(i)=Actuator(pos(i,1),pos(i,2),fi(i));
            end
        end
        
        function exp1()
            delete(findobj('type','patch'))
            delete(findobj('type','text'))
            
            Ani.plotElipse();
            txt=Ani.plotText(); 
            a=  Ani.setActs4();
            dir='r';
            if dir=='l'
                a=flip(a);
                set(txt,'string',...
                     '\leftarrow');
            else
                set(txt,'string',...
                     '\rightarrow');
            end
            tic;
            t=toc;
            f=[1.5 2 3];
            nf=1;
            
            vidObj=Ani.initMovie(sprintf('exp1%s',dir));
            
            while t<10 && nf <=length(f);
                t=toc;
                nf=1;
                id=mod(round(f(nf)*t),length(a))+1;
                a(id).shake();
                id_=id-1;
                if id_==0 
                    id_=length(a); end
                a(id_).reset();
                
                %set(txt,'string',...
                %     sprintf('f=%1.1f Hz',f(nf)));
                nf=round(t/3)+1;
                pause(1/25)
                drawnow
                writeVideo(vidObj, getframe(gca));
            end
            close(vidObj);
        end
        
        function exp2()
            delete(findobj('type','patch'))
            delete(findobj('type','text'))
            
            Ani.plotElipse();
            txt=Ani.plotText(); 
            
            a=  Ani.setActs2();
            
            d='r';
            if d=='l'
                a=flip(a);
                set(txt,'string',...
                     '\leftarrow');
            else
                set(txt,'string',...
                     '\rightarrow');
            end
            
            vidObj=Ani.initMovie(sprintf('exp2%s',d));
%             a(1).setAviParams(vidObj);

            dur=1;
            self=a(1);
            tic;
            t=toc;
            while t<dur
                t=toc;
                self.shake();
                pause(1/25)
                drawnow
                writeVideo(vidObj, getframe(gca));
                
            end
            self.reset();
            pause(.1)
            
            for i=1:10
                writeVideo(vidObj, getframe(gca));
            end
             self=a(2);
            tic;
            t=toc;
            while t<dur
                t=toc;
                self.shake();
                pause(1/25)
                drawnow
                writeVideo(vidObj, getframe(gca)); 
            end
            self.reset();
            
            for i=1:25
                writeVideo(vidObj, getframe(gca));
            end
            close(vidObj);
        end
        
        function type(aa)
            delete(findobj('type','patch'))
            delete(findobj('type','text'))
            
            
            Ani.plotElipse();
            txt=Ani.plotText();
            
            % coz all objects are deleted with obove command
            ClassName = class(aa);
            a = eval(sprintf('%s()',ClassName));
            set(txt,'string',...
                     '');%a.getType());
            vidObj=Ani.initMovie(ClassName);
            a.setAviParams(vidObj);
            a.click(3);
            close(vidObj);
        end
        
        function vidObj=initMovie(fn)
            %# create AVI object
            ffn=sprintf('./vid/%s',fn);
            vidObj = VideoWriter(ffn);
            vidObj.Quality = 100;
            vidObj.FrameRate = 25;
            open(vidObj);
        end
    end
    
end

