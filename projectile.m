clear 
clc
close all

  m=0.080
  A=pi*(7.5*10^(-2))^2 
  C=.45
  rho= 1.225 
  g=9.81
  D=rho*C*A/(2*m)
  fin1 = 0
  fin2 = 0
    
    delta_t= .001 
    angle = [0.4, 0.6, pi/4, 1.0, 1.2];
    
    numberOfAngles = length(angle);
    for k = 1 : numberOfAngles
        theta = angle(k)
                
        x(1)=0;
        y(1)=0;
        x2(1)=0;
        y2(1)=0;
        t(1)=0; 
        t2(1)=0; 
        v=14;
        
        vx=v*cos(theta);
        vy=v*sin(theta);
        vx2=v*cos(theta);
        vy2=v*sin(theta);

        
        i=1;
        while min(y2)> -.0001
            ay2=-g;
            ax2=0.0;
            vx2=vx2;
            vy2=vy2+ay2*delta_t;
            x2(i+1)=x2(i)+vx2*delta_t+.5*ax2*delta_t^2;
            y2(i+1)=y2(i)+vy2*delta_t+.5*ay2*delta_t^2;
            t2(i+1)=t2(i)+delta_t;
            i=i+1;
            fin1=i;
        end
        fin1;
        
        i=1; 
        while min(y)> -.0001
            cv=(vx*vx+vy*vy)^0.5;
            ax=-(D)*cv*vx;
            ay=-g-(D)*cv*vy;
            vx= vx + ax*delta_t;
            vy= vy + ay*delta_t;
            x(i+1)=x(i)+vx*delta_t+.5*ax*delta_t^2;
            y(i+1)=y(i)+vy*delta_t+.5*ay*delta_t^2;
            t(i+1)=t(i)+delta_t;
            i=i+1;
            fin2=i;
        end
        fin2;
      
          %disp(x(i-1));
          %disp(y(i-1));
          subplot(2, 3, k);
          plot(x,y,'-',x2,y2,'-')
          %legend({'', 'No Drag'},'FontSize',8)
          legend({'Drag','Ideal'},'FontSize',6,'Location','southoutside','NumColumns',2)
          legend('boxoff')
          legend('show')
          xlabel('x distance (m)')
          ylabel('y distance (m)')
          caption = sprintf('Angle = %.2f degrees\n Velocity = %.2f ',theta*180/pi, v);
          grid on;
          title(caption, 'FontSize', 12);
        
       tip = 1;
       while tip <= fin1
         x2(tip) = 0.0;
         y2(tip) = 0.0;
         t2(tip) = 0.0;
         tip=tip+1;
       end
       
       tip = 1;
       while tip <= fin2
         x(tip) = 0.0;
         y(tip) = 0.0;
         t(tip) = 0.0;
         tip=tip+1;
       end
       
    end
    print -djpg Plots.pdf

    set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
