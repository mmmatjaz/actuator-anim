clear all

% tic;
% t=toc
% 
% p01=[0.59,0.35,3.75,1.37];
% while t<3
%     hold off
%     t=toc;
%     p1=p01;
%     p1(1:2)=p1(1:2)+rand(1,2)/10;
%     rect=rectangle('Position',p1,...
%               'Curvature',[0.8,0.4],...
%              'LineWidth',2);
%     daspect([1,1,1])
%     toc
%     pause(1/25)
%     drawnow
% end

% figure('doublebuffer','on')

delete(findobj('type','patch'))

b = .75;
h = .15;

r=patch([-b/2 b/2 b/2 -b/2],[-h/2 -h/2 h/2 h/2],.5*[1 1 1]);
x0=get(r,'Xdata');
y0=get(r,'Ydata');
for n=1:25
    
    center=[mean(get(r,'Xdata')) mean(get(r,'Ydata')) 0];
%     rotate(r,[0 0 1],n,center)
%     move
    set(r,'Xdata',x0+ones(4,1).*rand(1).*.1)
    set(r,'Ydata',y0+ones(4,1).*rand(1).*.1)

    set(gca,'XLim',[-1 1],'YLim',[-1 1])
    drawnow
    pause(1/25)
end
hold off
% plot