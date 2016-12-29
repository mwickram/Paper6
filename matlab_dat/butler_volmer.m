function data=butler_volmer(meu_all,d,alpha,jo,area)


Frd=96500;
f=Frd/(8.314*283);%10 oC

meu=meu_all(find(meu_all<=0));
jo=area*jo;
cathode=-jo*exp(-alpha*f*meu);%by convension cathodic current is negative
anode=jo*exp((1-alpha)*f*meu);%by convension anodic current is positive

meu=1000*meu;

figure(2)


h=subplot(3,2,1);
g=plot(meu,cathode,'-k');
set(g(1),'linewidth',1);
ylim([d(end,1) 0]);
xlabel('\mu (mV)');ylabel('i_c (mA)');


h=subplot(3,2,2);

g=plot(meu, anode,'-k');
xlabel('\mu (mV)');ylabel('i_a (mA)');
xlim([meu(end) meu(1)]);
curr=cathode+anode; 
set(g,'linewidth',1);

subplot(3,2,3);
g=plot(meu,curr,'--k',d(1:15:end,2),d(1:15:end,1),'-ob','markersize',2);
ylim([d(end,1) 0]);set(g(1),'linewidth',1);
xlabel('\mu (mV)');ylabel('i (mA)');
legend('Model','Experimental','Location','best');

h=subplot(3,2,[4 6]);
g=plot(meu, cathode,'--k',meu, anode,'-.k',meu,curr,'-k');
xlim([meu(end) meu(1)]);set(g,'linewidth',1);
legend('i_c','i_a','i','Location','best');
xlabel('\mu (mA)');ylabel('i (mA)');

h=subplot(3,2,5);
cathode=-jo*exp(-alpha*f*meu_all);
anode=jo*exp((1-alpha)*f*meu_all);
curr=cathode+anode; 

g=plot(meu_all*1000, log(abs(curr)/area),'-k');
xlim([(d(end)- 10) (d(1)+10)]);
xlabel('\mu (mV)');ylabel('ln|j| (mA/cm^2)');
set(g,'linewidth',1);

meu_all=1000*meu_all';
data=[curr' meu_all];%file contains curr and overpential

end

