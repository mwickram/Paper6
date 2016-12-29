
function figure3

% cathodic polarization scans
ca_cv=load('m080410_100.dat');%1 c
%ca_cv=ca_cv(1:end-575,:);
ca_cv1=load('m060910_101.dat');%0.05
%ca_cv2=load('m060210_115.dat');%1.5
ca_cv=sgolayfilt(ca_cv,1,51);


ocp=[-618 -632]; 

jca_cv=ca_cv(:,1);
jca_cv1=ca_cv1(:,1);
%jca_cv2=ca_cv2(:,1);

ovpcv=ca_cv(:,2)-ocp(2);
ovpcv1=ca_cv1(:,2)-ocp(1);
%ovpcv2=ca_cv2(:,2)-ocp(1);
indx=ovpcv<0;
indx1=ovpcv1<0;

ovpcv=ovpcv(indx);
ovpcv1=ovpcv1(indx1);

jca_cv=jca_cv(indx);
jca_cv1=jca_cv1(indx1);

dneg=[jca_cv ovpcv];
%dneg(1:10,:)
fc=16;


h=subplot(2,2,1);

set(h,'fontsize',fc)
g=plot(ovpcv1/1000,jca_cv1(:,1),'-k',ovpcv/1000,jca_cv(:,1),'-k');
set(g(1),'linewidth',0.8)
set(g(2),'linewidth',2)
xlim([-0.24 0])
ylim([-0.4 0.01])
ylabel('Current (mA)','fontname','times new roman')
xlabel('\it\eta\rm_c (V)','fontname','times new roman');



k=1;
dv=5;


nb=floor(length(dneg))/dv;


for b=1:nb    
    
d4=dneg(k:k+dv-1,:);
k=k + dv;
sec_res= polyfit(d4(:,2),d4(:,1),1);
sec_lpr(b,:)=1/sec_res(1);
sec_i(b,:)=mean(d4(:,1));
sec_v(b,:)=mean(d4(:,2));

end

sec_data=[sec_i sec_lpr sec_v];
sec_data=sgolayfilt(sec_data,1,5);


h=subplot(2,2,2);

set(h,'fontsize',fc)
g=plot(sec_data(:,3)/1000,sec_data(:,2)/1000,'-k','linewidth',2);
xlabel('\it\eta\rm_c (V)','fontname','times new roman');
ylabel('\itR \rm_F (k\Omega)','fontname','times new roman' );
xlim([-0.5 0])
ylim([-0.05 2.2])


h=subplot(2,2,3);

set(h,'fontsize',fc)
g=plot(sec_data(:,1),sec_data(:,2)/1000,'k-','linewidth',2);
set(g(1),'linewidth',2);
xlabel('Current (mA)','fontname','times new roman');
ylabel('\itR \rm_F (k\Omega)','fontname','times new roman');
xlim([-0.4 0])
ylim([-0.05 2.2])



ar1=load('artrail1.dat');
ar2=load('artrail2.dat');

ar1(:,1)=log10(ar1(:,1));
ar2(:,1)=log10(ar2(:,1));



h=subplot(2,2,4);

set(h,'fontsize',fc)

g=plot(ar1(:,1),ar1(:,2)/1000,'-ok',ar2(:,1),ar2(:,2)/1000,'-^k');

set(g,'markersize',10,'markerfacecolor','w')
set(g,'markersize',10,'markerfacecolor','w')
set(g,'linewidth',2)
ylim([-0.1 1.5])
xlim([-2.5 2])
xlabel('Log_1_0\rm [ Area ]','fontname','times new roman')
ylabel('\itR \rm_F (k\Omega)','fontname','times new roman')



print -r300 -dtiff figure3.tiff