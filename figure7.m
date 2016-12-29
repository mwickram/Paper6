function figure7

%seems ok

data=load('m060210_111.dat');
data=sgolayfilt(data,1,61);


area=0.008; %cm2
ocp=-615;
exp_curr_den=data(:,1)/area;%mA/cm2
exp_E=data(:,2)-ocp;%mV

k1=1.9e-7;
km1=1.11e-8;
k2=2.15e-11;
k3=5.8e-10;
k4=3.75e-9;
b1=0.5;
b2=0.6;
b3=0.5;
b4=0.74;
c=3;

C(1)=k1;
C(2)=km1;
C(3)=k2;
C(4)=k3;
C(5)=k4;
C(6)=b1;
C(7)=b2;
C(8)=b3;
C(9)=b4;
C(10)=c;


Pot=[-22.7:0.1:3.541]/50;%in V
T=283;
R=8.314;
F=96485.34;
f=F/(R*T);

for k=1:length(Pot)
    E=Pot(k);
    C(11)=E;
    teta=fzero(@(x) hred(x,C),0.1);
    curr=2*F*k4*(1-teta)*exp(b4*E*f)-F*k1*c*(1-teta)*exp(-(1-b1)*E*f)+F*km1*teta*exp(b1*E*f)-F*k2*teta*c*exp(-(1-b2)*E*f);
    Teta(k)=teta;
    Curr_den(k)=curr;
end

Curr_den=Curr_den*1000; % mA
Pot=Pot*1000;%mV

data_fit=[Curr_den' Pot'];

save -ascii fitm060210_111.dat data_fit

% subplot(2,2,1);
% plot(Pot,Teta);
% 
% xlabel('mV');
% ylabel('\Theta');
% title('a');


% subplot(2,2,2);
% 
% plot(Pot,Curr_den,exp_E,exp_curr_den,'-r');
% 
% xlabel('mV');
% ylabel('j');
% title('b');

fc=16;

h=subplot(2,2,3);
set(h,'fontsize',fc)
g=plot(Pot/1000,log(abs(Curr_den)),'--k',exp_E/1000,log(abs(exp_curr_den)),'-k');
set(g,'linewidth',2)
xlim([-0.5 0.1])
ylim([-7.1 3.5])

xlabel('\it\eta\rm_c (V)');
ylabel('log_e\mid\itj\rm \mid');


dri=diff(Curr_den)./diff(Pot);
dr=1./dri;

iset=-0.135;
ndata=0;
for k=1:length(dr)
    if Curr_den(k) < 0
        ndata=ndata+1;
   A(ndata)= iset./Curr_den(k);
   R(ndata) = dr(k)/A(ndata);
    end
end

ar1=load('artrail1.dat');
ar2=load('artrail2.dat');


h=subplot(2,2,4);
set(h,'fontsize',fc)

g=plot(log10(A),R/1000,'-k',log10(ar2(:,1)),ar2(:,2)/1000,'ok',log10(ar1(:,1)),ar1(:,2)/1000,'^k');
set(g(2:3),'markerfacecolor','w','markersize',10,'linewidth',1.1)

set(g(1),'linewidth',2)
xlabel('log_1_0[Area]');
ylabel('\itR \rm_F  (k\Omega)');
xlim([-2.4 2.05])
ylim([-0.05 1.4])


print -r300 -dtiff figure7.tiff



