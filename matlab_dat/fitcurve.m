function fitcurve 

dmo=load('bv081109_1.dat');
dex=load('m072409_13.dat');

area =pi*(0.05^2);
n=4; % # of electrodes
cud=dex(:,1)./(n*area);
ocp=-0.70;
dmo(:,2)=dmo(:,2)+ocp; 

figure(3)
g=plot(1000*dmo(:,2),dmo(:,1),'-k',dex(:,2),dex(:,1),'ok');         %current in  mA 
ylabel('i (mA)'); xlabel( 'V (mV)');
set(g(2),'markersize',1.5);
legend('model','exp')