function find_lpr (file,isy,relu,area,metal,ovp_select)


d=load(file);%Pt electrode immersed 2 cm  1st column: current 2nd: potential
d=sgolayfilt(d,1,61);


[row]=find((isy-relu)<(d(:,1)) &(d(:,1))<(isy+relu));

res=abs(diff(d(:,2)))./abs(diff(d(:,1)));


cud=d(:,1)/area;% mA/cm2


Range=[d(row,1) res(row)]; 
disp('Range');
disp([num2str(Range(1,1:2))]) 
disp([num2str(Range(end,1:2))])
disp('Data fitting') 
disp([num2str(length(Range))])
LPR=mean(res(row))


p_res= polyfit(d(row,2),d(row,1),1);
fit=polyval(p_res,d(row,2));
disp('From Curve Fitting');
LPR_cf=1/p_res(1)


figure(1)

subplot(2,2,1)

g=plot(d(:,2),d(:,1),'--',d(row,2),fit,'-r');
ylabel('i (mA)'); xlabel( 'V (mV)');
ylim([d(end,1) 0]);
de=d(find(d(:,1)<0),1);
text(d(end,2),de(4),metal,'FontSize',15);
set(g,'linewidth',2);
title(['scan',' ',file(1:7),'\_',file(9:13)]);


subplot(2,2,2)

nr=find(d(:,1)<=0);nr1=find(d(:,1)>=0);
ocp=mean([d(nr(1),2) d(nr1(end),2)]);

% for the model calculation ocp=0
if file(1)=='g'
    ocp=0;
end

ovp=d(:,2) - ocp;% overpotetial 
ovp_neg=ovp(find(ovp<0));
ovp_fit=find(abs(ovp_neg)>ovp_select);%ovp_slect >slect the range where data should be done fitting for negative over potentials
ovp_s=ovp_neg(ovp_fit);%fit data to slected negative over potential in ovp

neg_cud= cud(find(ovp<0));% cathodic current density

p= polyfit(ovp_s,log(abs(neg_cud(ovp_fit))),1);
fit=polyval(p,ovp_s);

plot(ovp,log(abs(cud)),ovp_s,fit,'-r','Linewidth',2);
ylabel('ln( j ) (mA/cm^2)'); xlabel( 'V (mV)');
em_alpha=1000*abs((p(1)*8.314*283)/96500);% convert mV of overpotentil in to Volt
title(['j_o=',' ',num2str(exp(p(2))),' ','mA/cm^2','   ','\alpha=',num2str(em_alpha),'  ','OCP=', num2str(ocp), 'mV']);
xlim([(ovp(end)- 10) (ovp(1)+10)]);
 
disp(['Exchange current density','=',' ',num2str(exp(p(2))),' ','mA/cm^2']);
disp(['Alpha =',num2str(em_alpha)]);


subplot(2,2,3)

 
 g=plot(ovp_neg, neg_cud);
 ylabel('j (mA/cm^2)');
 xlabel('V (mV)');
 set(g,'linewidth',2);



subplot(2,2,4)
g2=plot(d(1:end-1,1),(res(:,1)),'--',Range(:,1),Range(:,2),'r-','Linewidth',2);
set(g2(1),'linewidth',2);
xlabel('i (mA)');
ylabel('R (\Omega)');
xlim([d(end,1)  (relu+Range(1,1))]);
title(['LPR',  '=' , num2str(LPR_cf), '\Omega','  ','@',' ', num2str(isy),' ','mA']);


disp(' Current mA   j_o mA/cm^2     Alpha            LPR_cf');
disp(num2str([ isy exp(p(2)) em_alpha LPR_cf]));

ran_meu=0.00001;
meu1=ovp(1,1)/1000:-ran_meu:0; % in order to get the theoratical OCP
meu2=-ran_meu:-ran_meu:ovp(end,1)/1000;
%meu3=meu2(end)-ran_meu:-ran_meu:-7;


meu=[meu1 meu2];
neg_curr=area*neg_cud;
data=[neg_curr ovp_neg]; %contain negative over opential and current


% for experimental data only.
if file(1)=='m'
butler_volmer(meu,data,em_alpha,exp(p(2)),area);
end

end





