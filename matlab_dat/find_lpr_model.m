function find_lpr_model(file,isy,relu)

d=load(file);%Pt electrode immersed 2 cm  1st column: current 2nd: potential
cud=d(:,1);

area=pi*(0.05^2); % diameter Ni- 0.1 cm
n=4;%# of electrodes
tarea=n*area

d(:,1)=tarea*d(:,1);%Current density changed to current

[row]=find((isy-relu)<abs(d(:,1)) & abs(d(:,1))<(isy+relu));
res=abs(diff(d(:,2)))./abs(diff(d(:,1)));

ocp=-0.70;
d(:,2)=d(:,2)+ocp; 

LPR=1000*mean(res(row))%in ohms

subplot(2,2,1)
g=plot(1000*d(:,2),d(:,1));         %current in  mA 
ylabel('i (mA)'); xlabel( 'V (mV)');
set(g,'linewidth',2);

subplot(2,2,2)
g=plot(1000*d(:,2),cud);            % mA/cm2
ylabel('j (mA/cm^2)');
xlabel('V (mV)');
set(g,'linewidth',2);

subplot(2,2,3)
g1=plot(cud(2:end), log10(1000*res(:,1)));
set(g1(1),'linewidth',2);
xlabel('j (mA/cm^2)');
ylabel('log(R)');


subplot(2,2,4)
g2=plot(d(2:end,1),(1000*res(:,1)));
set(g2(1),'linewidth',2);
xlabel('i (mA)');
ylabel('R (\Omega)');
xlim([-isy-relu (-isy+relu)]);
%ylim([LPR-10 (LPR+10)])
title(['LPR',  '=' , num2str(LPR), '\Omega','  ','@',' ', num2str(isy),' ','mA'])

fitcurve
end



