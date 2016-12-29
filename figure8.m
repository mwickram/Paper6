function figure8


%anodic CA scans        %AREA
%ceta=[-15 -14.2 -11.4 -1.5];
ceta(1:4)=0;

d1=load('cas_model/m011213_1.dat');%carea=9
d1=d1(80000:end-200000,:);
I1=d1(:,7);
v1=d1(:,2)+ceta(1);%


d2=load('cas_model/m011213_2.dat');%carea=11
d2=d2(200000:3300:end-100,:);
I2=d2(:,7);
v2=d2(:,2)+ceta(2);%


d3=load('cas_model/m011213_3.dat');%carea=18
d3=d3(100000:4000:end-19200,:);
I3=d3(:,7);%mAV
v3=d3(:,2)+ceta(3);%


d4=load('cas_model/m011213_4.dat');%carea=32
d4=d4(1:end-400000,:);
I4=d4(:,7);
v4=d4(:,2)+ceta(4);



d5=load('cas_model/m012813_1.dat');%carea=50
d5=d5(1:end,:);
I5=d5(:,7);
v5=d5(:,2);
%fg=figure(1);
%fg_pos=get(fg,'position');
%set(fg,'position',[fg_pos(1) fg_pos(2) fg_pos(3) fg_pos(4)])


fc=12;
dw=0;
dw1=-0.1;

h=subplot(5,2,1);

set(h,'fontsize',fc,'FontName','arial')
g=plot(v1,I1,'-k');
%set(h,'xTicklabel','')
%ylim([0 0.33])
%xlim([1.35 2])
h_pos=get(h,'position');
h_pos(4)=h_pos(4)+dw;
h_pos(3)=h_pos(3)+dw1;
set(h,'position',h_pos)
xlim([16 17])
ylim([1.2 1.6])
%set(h,'yTick',[0:0.1:0.33])
%set(h,'yTicklabel',{'0','','0.2',''})



h=subplot(5,2,3);

set(h,'fontsize',fc,'FontName','arial')
g=plot(v2,I2,'-k','linewidth',1);
ylim([0 1.7])
xlim([0 20])
%set(h,'xTicklabel','')
h_pos=get(h,'position');
h_pos(4)=h_pos(4)+dw;
h_pos(3)=h_pos(3)+dw1;
set(h,'position',h_pos)
%xlim([-12 1])
%set(h,'yTick',[0:0.1:0.33])
%set(h,'yTicklabel',{'0','','0.2',''})



h=subplot(5,2,5);

set(h,'fontsize',fc,'FontName','arial')
g=plot(v3,I3,'-k','linewidth',1);
ylim([0 3])
xlim([0 20])
%set(h,'xTicklabel','')
h_pos=get(h,'position');
h_pos(4)=h_pos(4)+dw;
h_pos(3)=h_pos(3)+dw1;
set(h,'position',h_pos)
ylabel('\itI','Fontname','times new roman')
%xlim([-12 1])
%set(h,'yTick',[0:0.1:0.33])
%set(h,'yTicklabel',{'0','','0.2',''})


h=subplot(5,2,7);

set(h,'fontsize',fc,'FontName','arial')
g=plot(v4,I4,'-k');
xlim([1 5])
ylim([1.2 1.6])
h_pos=get(h,'position');
h_pos(4)=h_pos(4)+dw;
h_pos(3)=h_pos(3)+dw1;
set(h,'position',h_pos)


h=subplot(5,2,9);

set(h,'fontsize',fc,'FontName','arial')
g=plot(v5,I5,'-k');
xlim([1.2 3.5])
ylim([1.2 1.6])
xlabel('\itV','Fontname','times new roman')
h_pos=get(h,'position');
h_pos(4)=h_pos(4)+dw;
h_pos(3)=h_pos(3)+dw1;
set(h,'position',h_pos)

%set(h,'yTick',[0:0.1:0.33])
%set(h,'yTicklabel',{'0','','0.2',''})
%anodic 3E scans           %R,ohm



% ad1=load('m080510_13.lvm');%393 
% ad1=ad1(500:end-975,:);
% I1=ad1(:,1)/1;%mA
% v1=ad1(:,2)-ocp(1)-I*r(1);
% 
% ad2=load('m062210_2.lvm');%658
% ad2=ad2(1:end-1070,:);
% I2=ad2(:,1)/10;%mA
% v2=ad2(:,2)-ocp(2)-I*r(2);
% 
% ad3=load('m062210_4.lvm');%1108
% ad3=ad3(200:end-1590,:);
% I3=ad3(:,1)/10;%mAV
% v3=ad3(:,2)-ocp(3)-I*r(3);
% 
% ad4=load('m080510_15.lvm');%96
% ad4=ad4(50:end-590,:);
% I4=ad4(:,1)/1;%mA
% v4=ad4(:,2)-ocp(4)-I*r(4);
% 
% gap=1.19;
% 
% h=subplot(4,2,2);
% 
% set(h,'fontsize',fc,'FontName','arial')
% g=plot(v1,I1,'-k');
% ylim([0 0.33])
% xlim([1.35 2])
% set(h,'yTick',[0:0.1:0.33])
% set(h,'xTicklabel','')
% set(h,'yTicklabel','')
% h_pos=get(h,'position');
% set(h,'position',[h_pos(1)/gap h_pos(2) h_pos(3) sub_h])
% 
% 
% 
% h=subplot(4,2,4);
% 
% set(h,'fontsize',fc,'FontName','arial')
% g=plot(v2,I2,'-k');
% ylim([0 0.33])
% xlim([1.35 2])
% set(h,'yTick',[0:0.1:0.33])
% set(h,'xTicklabel','')
% set(h,'yTicklabel','')
% h_pos=get(h,'position');
% set(h,'position',[h_pos(1)/gap h_pos(2) h_pos(3) sub_h])
% 
% 
% h=subplot(4,2,6);
% 
% set(h,'fontsize',fc,'FontName','arial')
% g=plot(v3,I3,'-k');
% ylim([0 0.33])
% xlim([1.35 2])
% set(h,'yTick',[0:0.1:0.33])
% set(h,'xTicklabel','')
% set(h,'yTicklabel','')
% h_pos=get(h,'position');
% set(h,'position',[h_pos(1)/gap h_pos(2) h_pos(3) sub_h])
% 
% h=subplot(4,2,8);
% 
% set(h,'fontsize',fc,'FontName','arial')
% g=plot(v4,I4,'-k');
% ylim([0 0.33])
% xlim([1.35 2])
% set(h,'yTick',[0:0.1:0.33])
% set(h,'yTicklabel','')
% xlabel('\it\eta\rm_a (V)')
% h_pos=get(h,'position');
% set(h,'position',[h_pos(1)/gap h_pos(2) h_pos(3) sub_h])
% 
% 
%print -r300 -dtiff figure8.tiff 