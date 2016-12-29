function find_lpr1(d,isy,relu)

nr=find(d(:,1)<=0);nr1=find(d(:,1)>=0);
ocp=mean([d(nr(1),2) d(nr1(end),2)])
%ocp=-620;
d=sgolayfilt(d,1,61);
d=d(1:end,:);

[row]=find((isy-relu)<(d(:,1)) &(d(:,1))<(isy+relu));

cud=d(:,1);% mA% this is just current


Range=d(row,1);
disp(['Curve fitting around' ' ' num2str(isy)]);
disp('Range');
disp(num2str(Range(1)));
disp(num2str(Range(end)));
disp('Data points') ;  
disp(num2str(length(Range)));


p_res= polyfit(d(row,2),d(row,1),1);
fitres1=polyval(p_res,d(row,2));
disp('From Curve Fitting');
LPR_cf=1/p_res(1)


k=1;
nb=floor(length(d))/10;
for b=1:nb    
d4=d(k:k+9,:);
k=k + 10;
sec_res= polyfit(d4(:,2),d4(:,1),1);
sec_lpr(b,:)=1/sec_res(1);
sec_i(b,:)=mean(d4(:,1));
sec_v(b,:)=mean(d4(:,2));
end

sec_data=[sec_i sec_lpr sec_v];
sec_data=sgolayfilt(sec_data,1,7);

figure(1)

subplot(3,2,1)

g=plot(d(:,2),d(:,1),'-k',d(row,2),fitres1,'-r');

ylabel('i (mA)'); xlabel( 'V (mV)');
ylim([d(end,1) d(1,1)]);
set(g(1),'linewidth',1);
set(g(2),'linewidth',2)
%title([metal,'      ','scan',' ','\_',file(9:13)]);


subplot(3,2,2)


ovp=d(:,2)-ocp;% overpotetial 
%ovp_neg=ovp(find(ovp<0));
%ovp_fit=find(abs(ovp_neg)>ovp_select);%ovp_slect >slect the range where data should be done fitting for negative over potentials
%ovp_s=ovp_neg(ovp_fit);%fit data to slected negative over potential in ovp

neg_cud= cud(find(ovp<0));% cathodic current

%p=polyfit(ovp_s,log(abs(neg_cud(ovp_fit))),1);
%fitres=polyval(p,ovp_s);

plot(d(:,2),log(abs(cud)),'-k','linewidth',2);
ylabel('ln( i ) (mA)'); xlabel( 'V (mV)');
%em_alpha=1000*abs((p(1)*8.314*283)/96500);% convert mV of overpotentil in to Volt
title(['OCP=', num2str(ocp), 'mV']);
%disp(['Exchange current density','=',' ',num2str(exp(p(2))),' ','mA/cm^2']);
%disp(['Alpha =',num2str(em_alpha)]);


% subplot(3,2,3)
% 
% g=plot(d(:,2),d(:,1),'-k',d(row,2),fitres1,'-r');
% ylabel('i (mA)');
% xlabel('V (mV)');
% set(g(1),'linewidth',1);
% set(g(2),'linewidth',2.2);
% %ylim([-0.20 -0.02]);
% xlim([-1029 -979])


subplot(3,2,5)

g2=plot(sec_data(1:end,3),sec_data(1:end,2)/1000,'-k','linewidth',2);


title(['R_F',  '=' , num2str(round(LPR_cf)), '\Omega','  ','@',' ', num2str(round(mean(d(row,2)))),' ','mV']);
xlabel('V (mA)');
ylabel('R (k\Omega)' );

subplot(3,2,6)
    
g2=plot(sec_data(1:end,1),sec_data(1:end,2)/1000,'k-','linewidth',2);
set(g2(1),'linewidth',2);
xlabel('i (mA)');
ylabel('R (k\Omega)');
title(['R_F',  '=' , num2str(round(LPR_cf)), '\Omega','  ','@',' ', num2str(isy),' ','mA']);


%disp('j_o mA/cm^2     Alpha     Current mA     LPR_cf');
%disp(num2str([exp(p(2)) em_alpha isy LPR_cf]));




end