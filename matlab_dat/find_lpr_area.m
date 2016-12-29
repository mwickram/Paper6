function find_lpr_area (file,isy,relu,area,area_lo,area_up)


d=load(file);%Pt electrode immersed 2 cm  1st column: current 2nd: potential
d=sgolayfilt(d,1,61);

cud=d(:,1)/area;

ran_area=0.1;
area1=area_lo:ran_area:area; area2=area+ran_area:ran_area:area_up ;%area2=1+ran_area:ran_area:32;
area=[area1 area2]';

for k=1:length(area)
    
d1(:,k)=area(k)*cud(:,1);
end

d=[d1 d(:,2)];%The last column is potential

Range=zeros(length(d),1); %a dummy vector

for k=1:length(area)
    
[row]=find((isy-relu)<(d1(:,k)) &(d1(:,k))<(isy+relu));
res(:,k)=abs(diff(d(:,end)))./abs(diff(d(:,k)));


Ra=res(row);

LPR(k,1)=mean(res(row)); % The value of LPR calulated from entire selected range

lg(k,1)=length(Ra);
ml=min(lg);

Range=Range(1:ml,:);
Range(:,k)=Ra(1:ml,:); % Not entire selected values may not be in this vector

% disp('Range');
% disp([num2str(Range(,:))]) ;
% disp([num2str(Range(end,1:2))]);
% disp('Data fitting') ;
% disp([num2str(length(Range))]);


p_res= polyfit(d(row,end),d(row,k),1);
fit(:,k)=polyval(p_res,d(row,end));

LPR_cf(k,1)=1/p_res(1);

end

%Range
LPR;
disp('From Curve Fitting');
LPR_cf

figure(1)

subplot(2,2,1)

g=plot(d(:,end),d1(:,1),'--k',d(:,end),d(:,length(area1)),'r',d(:,end),d1(:,end),'--');
ylabel('i (mA)'); xlabel( 'V (mV)');
%ylim([d(end,1) 0]);
%de=d(find(d(:,1)<0),1);
%text(d(end,2),de(4),metal,'FontSize',15);
set(g(2),'linewidth',2);
title(['scan',' ',file(1:7),'\_',file(9:13)]);


% subplot(3,2,2)
% 
% 
% 
% nr=find(d(:,1)<=0);nr1=find(d(:,1)>=0);
% ocp=mean([d(nr(1),2) d(nr1(end),2)]);
% 
% % for the model calculation ocp=0
% 
% if file(1)=='g'
% ocp=0;
% end
% 
% ovp=d(:,2) - ocp;% overpotetial 
% ovp_neg=ovp(find(ovp<0));
% ovp_fit=find(abs(ovp_neg)>ovp_select);%ovp_slect >slect the range where data should be done fitting for negative over potentials
% ovp_s=ovp_neg(ovp_fit);%fit data to slected negative over potential in ovp
% 
% neg_cud= cud(find(ovp<0));% cathodic current
% 
% p= polyfit(ovp_s,log(abs(neg_cud(ovp_fit))),1);
% fit=polyval(p,ovp_s);
% 
% plot(ovp,log(abs(cud)),ovp_s,fit,'-r','Linewidth',2);
% ylabel('ln( j ) (mA/cm^2)'); xlabel( 'V (mV)');
% em_alpha=1000*abs((p(1)*8.314*283)/96500);% convert mV of overpotentil in to Volt
% title(['j_o=',' ',num2str(exp(p(2))),' ','mA/cm^2','   ','\alpha=',num2str(em_alpha),'  ','OCP=', num2str(ocp), 'mV']);
% xlim([(ovp(end)- 10) (ovp(1)+10)]);
%  
% disp(['Exchange current density','=',' ',num2str(exp(p(2))),' ','mA/cm^2']);
% disp(['Alpha =',num2str(em_alpha)]);
% 
% 
% subplot(3,2,3)
% 
% g=plot(ovp_neg, neg_cud);
% ylabel('j (mA/cm^2)');
% xlabel('V (mV)');
% set(g,'linewidth',2);

%cud(1:end-1,1),res(:,area1(end))

subplot(2,2,2)
    
g2=plot(d1(1:end-1,1),res(:,1),d1(1:end-1,1),res(:,length(area1)),d(1:end-1,end-1),res(:,end-1),'--','Linewidth',2.5);
set(g2(1),'linewidth',2);
xlabel('i (mA)');
ylabel('R (\Omega)');
%xlim([d(end,1)  (relu+Range(1,1))]);
%title(['LPR',  '=' , num2str(LPR_cf), '\Omega','  ','@',' ', num2str(isy),' ','mA']);


%disp('j_o mA/cm^2     Alpha     Current mA     LPR_cf');
%disp(num2str([exp(p(2)) em_alpha isy LPR_cf]));

subplot(2,2,3)
    
g2=plot(area(:,1),LPR_cf(:,1));
xlabel('Area Cm^2');
ylabel('R (\Omega)');
%xlim([cud(end,1)  (relu+Range(1,1))/area]);
%title(['LPR',  '=' , num2str(LPR_cf), '\Omega','  ','@',' ', num2str(isy/area),' ','mA/cm^2']);


%disp('Current mA/cm^2  LPR_cf');
%disp(num2str([isy/area  LPR_cf]));


subplot(2,2,4)

R_p=5000;%ohms

sigma=2*LPR_cf(:,1)/(R_p*(2*LPR(:,1)+ R_p));
sigma=log10(1/sigma(:,1));
    
g2=plot(LPR_cf(:,1),sigma(:,1));
set(g2(1),'linewidth',2);
xlabel('R (\Omega)');
ylabel('k')
%xlim([d(end,1)  (relu+Range(1,1))]);
%title(['LPR',  '=' , num2str(LPR_cf), '\Omega','  ','@',' ', num2str(isy),' ','mA']);


end





