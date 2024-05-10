clear;close all;
Nx=1200;Ny=1000;Nperiod=6;Nt=500;Npoints_max=300;
s=1:90;
A0=0.0002;
B0=-0.03;
C0=0.7;
phi0=A0*s.^2+B0*s+C0;
x1=cumsum(cos(phi0));x1=[-x1(end:-1:1),x1];x1=x1+Nx/4;
y1=cumsum(sin(phi0));y1=[y1(end:-1:1),y1];y1=y1+Ny/8;
x2=cumsum(cos(phi0));x2=[-x2(end:-1:1),x2];x2=x2+2*Nx/4;
y2=cumsum(sin(phi0));y2=[y2(end:-1:1),y2];y2=y2+Ny/8;
x3=cumsum(cos(phi0));x3=[-x3(end:-1:1),x3];x3=x3+3*Nx/4;
y3=cumsum(sin(phi0));y3=[y3(end:-1:1),y3];y3=y3+Ny/8;
figure;background=randi(10,Ny,Nx,3)/100+0.9;background(:,:,1)=randi(80,Ny,Nx,1)/100+0.1;
background(3:Ny-2,3:Nx-2,1)=(background(1:Ny-4,1:Nx-4,1)+background(2:Ny-3,2:Nx-3,1)+background(3:Ny-2,3:Nx-2,1)+background(4:Ny-1,4:Nx-1,1)+background(5:Ny,5:Nx,1))/5-0.2;
background(:,:,2)=background(:,:,2)-0.1;
background(1:Ny/8,:,1:2)=background(1:Ny/8,:,1:2)-0.3;%ocean
% background(1:round(Ny/10),:,1)=background(1:round(Ny/10),:,1)-0.4;
% background(round(1+Ny/8):Ny,:,2:3)=background(round(1+Ny/8):Ny,:,2:3)-0.2;
background(round(6*Ny/8):round(7*Ny/8),round(Nx/4):round(Nx/4+Ny/8),3)=background(round(6*Ny/8):round(7*Ny/8),round(Nx/4):round(Nx/4+Ny/8),3)-0.3;%sun
background(round(6*Ny/8):round(7*Ny/8),round(Nx/4):round(Nx/4+Ny/8),1:2)=0.95;
image(background);set(gca,'YDir','normal');hold on;axis off;
bird1=plot(x1,y1,'k-');
bird2=plot(x2,y2,'k-');
bird3=plot(x3,y3,'k-');
axis equal;
D1=cumsum(smooth(0.003*(randi(11,Npoints_max+10,1)-6),Npoints_max/10));
D1=D1(5:4+Npoints_max)-D1(5);
D2=cumsum(smooth(0.003*(randi(11,Npoints_max+10,1)-6),Npoints_max/10));
D2=D2(5:4+Npoints_max)-D2(5);
D3=cumsum(smooth(0.003*(randi(11,Npoints_max+10,1)-6),Npoints_max/10));
D3=D3(5:4+Npoints_max)-D3(5);
Np1(1:Nt)=Npoints_max*(1:Nt)/Nt;
Np2(1:Nt)=Npoints_max*(1:Nt)/Nt*2;Np2(round(Nt/2):Nt)=Npoints_max;
Np3(1:Nt)=Npoints_max*(1:Nt)/Nt/5;
for it=1:Nt
    B=B0+0.001*sin(it/Nt*Nperiod*2*pi);
    A=A0+0.00005*sin(it/Nt*Nperiod*2*pi);
    C=C0+0.3*sin(it/500*Nperiod*2*pi);
    phi0=A*s.^2+B*s+C;
    x1=cumsum(cos(phi0));x1=[-x1(end:-1:1),x1];
    y1=cumsum(sin(phi0));y1=[y1(end:-1:1),y1];
    x2=cumsum(cos(phi0));x2=[-x2(end:-1:1),x2];
    y2=cumsum(sin(phi0));y2=[y2(end:-1:1),y2];
    x3=cumsum(cos(phi0));x3=[-x3(end:-1:1),x3];
    y3=cumsum(sin(phi0));y3=[y3(end:-1:1),y3];
    xR1=x1*cos(D1(ceil(Np1(it))))-y1*sin(D1(ceil(Np1(it))))-1.8*Ny*3/4/Nt*sum(sin(D1(1:ceil(Np1(it)))));xR1=xR1+Nx/4;
    yR1=x1*sin(D1(ceil(Np1(it))))+y1*cos(D1(ceil(Np1(it))))+1.8*Ny*3/4/Nt*sum(cos(D1(1:ceil(Np1(it)))));yR1=yR1+Ny/8;
    xR2=x2*cos(D2(ceil(Np2(it))))-y2*sin(D2(ceil(Np2(it))))-1.8*Ny*3/4/Nt*sum(sin(D2(1:ceil(Np2(it)))));xR2=xR2+2*Nx/4;
    yR2=x2*sin(D2(ceil(Np2(it))))+y2*cos(D2(ceil(Np2(it))))+1.8*Ny*3/4/Nt*sum(cos(D2(1:ceil(Np2(it)))));yR2=yR2+Ny/8;
    xR3=x3*cos(D3(ceil(Np3(it))))-y3*sin(D3(ceil(Np3(it))))-1.8*Ny*3/4/Nt*sum(sin(D3(1:ceil(Np3(it)))));xR3=xR3+3*Nx/4;
    yR3=x3*sin(D3(ceil(Np3(it))))+y3*cos(D3(ceil(Np3(it))))+1.8*Ny*3/4/Nt*sum(cos(D3(1:ceil(Np3(it)))));yR3=yR3+Ny/8;
    delete(bird1);
    delete(bird2);
    delete(bird3);
    bird1=plot(xR1,yR1,'-','Linewidth',3,'color',[(sin(it/Nt*Nperiod*2*pi)+1)/3 (sin(it/Nt*Nperiod*2*pi)+1)/3/2 it/Nt*0.3]);
    bird2=plot(xR2,yR2,'-','Linewidth',3,'color',[(sin(it/Nt*Nperiod*2*pi)+1)/3 it/Nt*0.3 (sin(it/Nt*Nperiod*2*pi)+1)/3/2]);
    bird3=plot(xR3,yR3,'-','Linewidth',3,'color',[it/Nt*0.3 (sin(it/Nt*Nperiod*2*pi)+1)/3 (sin(it/Nt*Nperiod*2*pi)+1)/3/2]);
    axis equal;
    axis([0,Nx,1,Ny]);
    pause(0.001);
end