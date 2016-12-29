function figure5

beta=[0.3 0.5 0.7];
jo=1e-4;%A/cm2%
f=96485/8.314/283;

eta=(-0.3:0.0001:0)';% V
E=f*eta; 

cathode1=-jo*exp(-(1-beta(1))*E);%by convension cathodic current is negative
anode1=jo*exp(beta(1)*E);%by convension anodic current is positive

cathode2=-jo*exp(-(1-beta(2))*E);%by convension cathodic current is negative
anode2=jo*exp(beta(2)*E);%


cathode3=-jo*exp(-(1-beta(3))*E);%by convension cathodic current is negative
anode3=jo*exp(beta(3)*E);%


currd1=anode1+cathode1;%A/cm2
dr1=diff(currd1)./diff(eta);
dr1=1./dr1;

currd2=anode2+cathode2;
dr2=diff(currd2)./diff(eta);
dr2=1./dr2;

currd3=anode3+cathode3;
dr3=diff(currd3)./diff(eta);
dr3=1./dr3;



data_i=[currd1 currd2 currd3];
datar=[dr1 dr2 dr3];

fc=16;
wd=0.01;
nl=3;

h=subplot(3,3,1);

hp=get(h,'position');
hp(4)=hp(4)-wd;
set(h,'position',hp, 'fontsize',fc)

fct=1000;
g=plot(eta,currd1*fct,'-k',eta,currd2*fct,'-k',eta,currd3*fct,'--k');
%xlabel('\it\eta');
ylabel('\iti \rm(mA)','fontname','times new roman');
set(g(2:3),'linewidth',1.2)
xlim([-0.2 0])
ylim([-1 0])
%axis square


iset=-0.1;
ndata=0;

for n=1:3
    
for k=1:length(datar)
    if data_i(k,n) < 0
        ndata=ndata+1;
   A(ndata,n)=iset./data_i(k,n);
   R(ndata,n)=datar(k,n)/A(ndata,n);
    end
end

end


h=subplot(3,3,4);

hp=get(h,'position');
hp(4)=hp(4)-wd;
set(h,'position',hp,'fontsize',fc)

set(h,'fontsize',fc)
g=plot(eta(1:end-1),dr1/1000,'-k',eta(1:end-1),dr2/1000,'-k',eta(1:end-1),dr3/1000,'--k');
set(g(2:3),'linewidth',1.2)
xlim([-0.3 0])
ylim([-0.02 0.4])
ylabel('\itR \rm_F (k\Omega)','fontname','times new roman')
%xlabel('\it\eta')
%axis square


h=subplot(3,3,7);

hp=get(h,'position');
hp(4)=hp(4)-wd;
set(h,'position',hp,'fontsize',fc)

g=plot(log10(A(:,1)),R(:,1),'-k',log10(A(:,2)),R(:,2),'-k',log10(A(:,3)),R(:,3),'--k');

set(g(2:3),'linewidth',1.2)
xlim([1.5 4.5])
ylim([0 1])
xlabel('Log_1_0\rm(\itA\rm)','fontname','times new roman');
ylabel('\itR \rm_F (\Omega)','fontname','times new roman');
%axis square

print -r300 figure5.tiff


