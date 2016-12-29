function find_lpr (file,isy,relu,area,metal,ovp_select,ncol)


d=load(file);%Pt electrode immersed 2 cm  1st column: current 2nd: potential
d=sgolayfilt(d,1,61 );
d=d(1:end-ncol,1:2);

[row]=find((isy-relu)<(d(:,1)) &(d(:,1))<(isy+relu));

res=abs(diff(d(:,2)))./abs(diff(d(:,1)));
res=sgolayfilt(res,1,31);


cud=d(:,1)/area;% mA/cm2


Range=[d(row,1) d(row,2)]; 
disp('Range');
%disp([num2str(Range(1,1:2))]); 
%disp([num2str(Range(end,1:2))]);
disp('Data fitting') ;  
disp([num2str(length(Range))]);
%LPR=mean(res(row))


p_res= polyfit(d(row,2),d(row,1),1);
fit=polyval(p_res,d(row,2));
disp('From Curve Fitting');
LPR_cf=1/p_res(1)


figure(1)

subplot(3,2,1)

g=plot(d(:,2),d(:,1),'--',d(row,2),fit,'-r','linewidth',2.5);
ylabel('i (mA)'); xlabel( 'V (mV)');
ylim([d(end,1) 0]);
%de=d(find(d(:,1)<0),1);
%text(d(end,2),de(10),metal,'FontSize',10);
set(g(1),'linewidth',2);
title([metal,'      ','scan',' ',file(1:7),'\_',file(9:13)]);


subplot(3,2,2)


nr=find(d(:,1)<=0);nr1=find(d(:,1)>=0);
    ocp=mean([d(nr(1),2) d(nr1(end),2)]);

% for the model calculation ocp=0

if file(1)=='g'
ocp=0;
end

ovp=d(:,2)-ocp;% overpotetial 
ovp_neg=ovp(find(ovp<0));
ovp_fit=find(abs(ovp_neg)>ovp_select);%ovp_slect >slect the range where data should be done fitting for negative over potentials
ovp_s=ovp_neg(ovp_fit);%fit data to slected negative over potential in ovp

neg_cud= cud(find(ovp<0));% cathodic current

p=polyfit(ovp_s,log(abs(neg_cud(ovp_fit))),1);
fit=polyval(p,ovp_s);

plot(ovp,log(abs(cud)),ovp_s,fit,'-r','Linewidth',2);
ylabel('ln( j ) (mA/cm^2)'); xlabel( '\eta (mV)');
em_alpha=1000*abs((p(1)*8.314*283)/96500);% convert mV of overpotentil in to Volt
title(['j_o=',' ',num2str(exp(p(2))),' ','mA/cm^2','   ','\alpha=',num2str(em_alpha),'  ','OCP=', num2str(ocp), 'mV']);
xlim([(ovp(end)-10) (ovp(1)+10)]);
 
disp(['Exchange current density','=',' ',num2str(exp(p(2))),' ','mA/cm^2']);
disp(['Alpha =',num2str(em_alpha)]);


subplot(3,2,3)

g=plot(ovp_neg, neg_cud);
ylabel('j (mA/cm^2)');
xlabel('\eta (mV)');
set(g,'linewidth',2);
ylim([neg_cud(end) 0])


subplot(3,2,4)
    
g2=plot(d(1:end-1,1),(res(:,1)),'--',Range(:,1),Range(:,2),'r-','Linewidth',2.5);
set(g2(1),'linewidth',2);
xlabel('i (mA)');
ylabel('R (\Omega)');
%rw1=d(find(res==max(res(:,1))),1);
%xlim([rw1-0.5 (relu+Range(1,1))]);
xlim([d(end,1) d(1,1)]);
title(['LPR',  '=' , num2str(LPR_cf), '\Omega','  ','@',' ', num2str(isy),' ','mA']);


disp('j_o mA/cm^2     Alpha     Current mA     LPR_cf');
disp(num2str([exp(p(2)) em_alpha isy LPR_cf]));

subplot(3,2,5)
    
g2=plot(cud(1:end-1,1),(res(:,1)),'--',Range(:,1)/area,Range(:,2),'r-','Linewidth',2.5);
set(g2(1),'linewidth',2);
xlabel('j (mA/cm^2)');
ylabel('R (\Omega)');
xlim([cud(end,1) cud(1,1)]);
%xlim([(rw1-0.5)/area  (relu+Range(1,1))/area]);
title(['LPR',  '=' , num2str(LPR_cf), '\Omega','  ','@',' ', num2str(isy/area),' ','mA/cm^2']);


disp('Current mA/cm^2  LPR_cf');
disp(num2str([isy/area  LPR_cf]));


ran_meu=0.000001;
meu1=ovp(1,1)/1000:-ran_meu:0; % in order to get the theoratical OCP
meu2=-ran_meu:-ran_meu:ovp(end,1)/1000;

meu=[meu1 meu2];
neg_curr=area*neg_cud;
data=[neg_curr ovp_neg]; %contain negative over opential and current

% butler-volmer is used for experimental data only
 if file(1)=='m'
 [out_d]=butler_volmer(meu,data,em_alpha,exp(p(2)),area);
 end

 figure(1)
 
subplot(3,2,6)
    
g3=plot(out_d(:,2),out_d(:,1)/area,'-k',ovp_neg(1:20:end),neg_cud(1:20:end),'--ob');
%xlim([out_d(end,2) 0])
ylim([neg_cud(end) 0])
set(g3(2),'markersize',1.5);
legend('model','exp','location','best')

ylabel('j (mA/cm^2)');
xlabel('\eta (mV)');

end





