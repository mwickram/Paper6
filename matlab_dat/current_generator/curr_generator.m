function curr_generator (file,area,ovp_select)


cd ('C:\Documents and Settings\mwickram\My Documents\mahesh\ACM\Matlab_dat');
d=load(file);%Pt electrode immersed 2 cm  1st column: current 2nd: potential
d=sgolayfilt(d,1,61);


cud=d(:,1)/area;% mA/cm2


figure(1)

subplot(2,2,1)

g=plot(d(:,2),d(:,1));
ylabel('i (mA)'); xlabel( 'V (mV)');
ylim([d(end,1) 0]);
set(g,'linewidth',2);
title(['scan',' ',file(1:7),'\_',file(9:13)]);


subplot(2,2,2)

nr=find(d(:,1)<=0);nr1=find(d(:,1)>=0);
ocp=mean([d(nr(1),2) d(nr1(end),2)])
ovp=d(:,2) - ocp;% overpotetial 
ovp_neg=ovp(find(ovp<0));
ovp_fit=find(abs(ovp_neg)>ovp_select);%ovp_slect >slect the range where data should be done fitting for negative over potentials
ovp_s=ovp_neg(ovp_fit);%fit data to slected negative over potential in ovp

neg_cud= cud(find(ovp<0));% cathodic current

p= polyfit(ovp_s,log(abs(neg_cud(ovp_fit))),1);
fit=polyval(p,ovp_s);

plot(ovp,log(abs(cud)),ovp_s,fit,'-r','Linewidth',2);
ylabel('ln( j ) (mA/cm^2)'); xlabel( 'V (mV)');
em_alpha=1000*abs((p(1)*8.314*283)/96500);% convert mV of overpotentil in to Volt
title(['j_o=',' ',num2str(exp(p(2))),' ','mA/cm^2','   ','\alpha=',num2str(em_alpha),'  ','OCP=', num2str(ocp), 'mV']);
xlim([(ovp(end)- 10) (ovp(1)+10)]);
 
disp(['Exchange current density','=',' ',num2str(exp(p(2))),' ','mA/cm^2']);
disp(['Alpha =',num2str(em_alpha)]);
    
ran_meu=0.00001;
meu1=ovp(1,1)/1000:-ran_meu:0; % in order to get the theoratical OCP
meu2=-ran_meu:-ran_meu:ovp(end,1)/1000;
%meu3=meu2(end)-ran_meu:-ran_meu:-7;

meu=[meu1 meu2];
neg_curr=area*neg_cud;
data=[neg_curr ovp_neg]; %contain negative over opential and current

[outfile]=butler_volmer(meu,data,em_alpha,exp(p(2)),area);

cd ('C:\Documents and Settings\mwickram\My Documents\mahesh\ACM\Matlab_dat\current_generator')

filename=strcat('g',file)

save( '-ascii',filename,'outfile') 

end





