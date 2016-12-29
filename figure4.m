function figure4


%anodic CA scans        %AREA


shiftv=[0.221 0.238 0.147 0.101 0.008];

d1=load('m061110_3.lvm');%0.05
d1=d1(400:end-390,:);
I1=d1(:,1)/1;%mAV
v1=d1(:,2)-shiftv(1);%

d2=load('m061110_6.lvm');%0.5
d2=d2(850:end-1735,:);
I2=d2(:,1)/1;%mAV
v2=d2(:,2)-shiftv(2);%

d3=load('m061110_5.lvm');%1
d3=d3(450:end-1240,:);
I3=d3(:,1)/1;%mAV
v3=d3(:,2)-shiftv(3);%

d4=load('m061110_8.lvm');%1.5
d4=d4(400:end-890,:);
I4=d4(:,1)/1;%mAV
v4=d4(:,2)-shiftv(4);%

d5=load('m061110_11.lvm');%6
d5=d5(1:end-432,:);
I5=d5(:,1)/1;%mAV
v5=d5(:,2)-shiftv(5);%

figure(1);
%fg_pos=get(fg,'position');
%set(fg,'position',[fg_pos(1) fg_pos(2) fg_pos(3) fg_pos(4)])


fc=16;
sub_h=0.16;

h=subplot(5,2,1);

set(h,'fontsize',fc,'FontName','arial')
g=plot(v1,I1,'-k');
set(h,'xTicklabel','')
ylim([0 0.33])
xlim([1.35 2])
h_pos=get(h,'position');
set(h,'position',[h_pos(1) h_pos(2) h_pos(3) sub_h])
set(h,'yTick',[0:0.1:0.33])
set(h,'yTicklabel',{'0','','0.2',''})

h=subplot(5,2,3);

set(h,'fontsize',fc,'FontName','arial')
g=plot(v2,I2,'-k');
ylim([0 0.33])
xlim([1.35 2])
set(h,'xTicklabel','')
h_pos=get(h,'position');
set(h,'position',[h_pos(1) h_pos(2) h_pos(3) sub_h])
set(h,'yTick',[0:0.1:0.33])
set(h,'yTicklabel',{'0','','0.2',''})

h=subplot(5,2,5);

set(h,'fontsize',fc,'FontName','arial')
g=plot(v3,I3,'-k');
ylim([0 0.33])
xlim([1.35 2])
set(h,'xTicklabel','')
h_pos=get(h,'position');
set(h,'position',[h_pos(1) h_pos(2) h_pos(3) sub_h])
set(h,'yTick',[0:0.1:0.33])
set(h,'yTicklabel',{'0','','0.2',''})



h=subplot(5,2,7);

set(h,'fontsize',fc,'FontName','arial')
g=plot(v4,I4,'-k');
ylim([0 0.33])
xlim([1.35 2])
set(h,'xTicklabel','')
h_pos=get(h,'position');
set(h,'position',[h_pos(1) h_pos(2) h_pos(3) sub_h])
set(h,'yTick',[0:0.1:0.33])
set(h,'yTicklabel',{'0','','0.2',''})


h=subplot(5,2,9);

set(h,'fontsize',fc,'FontName','arial')
g=plot(v5,I5,'-k');
ylim([0 0.33])
xlim([1.35 2])
xlabel('\it\eta\rm_a (V)')
h_pos=get(h,'position');
set(h,'position',[h_pos(1) h_pos(2) h_pos(3) sub_h])
set(h,'yTick',[0:0.1:0.33])
set(h,'yTicklabel',{'0','','0.2',''})

%anodic 3E scans           %R,ohm


ocp=(-1)*[0.615 0.575 0.620 0.618 0.625];
I=0.134/1000;
r=[393 658 1108 923 96];

ad1=load('m080510_13.lvm');%393 
ad1=ad1(500:end-975,:);
I1=ad1(:,1)/1;%mA
v1=ad1(:,2)-ocp(1)-I*r(1);

ad2=load('m062210_2.lvm');%658
ad2=ad2(1:end-1070,:);
I2=ad2(:,1)/10;%mA
v2=ad2(:,2)-ocp(2)-I*r(2);

ad3=load('m062210_4.lvm');%1108
ad3=ad3(200:end-1590,:);
I3=ad3(:,1)/10;%mAV
v3=ad3(:,2)-ocp(3)-I*r(3);

ad4=load('m062210_6.lvm');%923
ad4=ad4(300:end-1540,:);
I4=ad4(:,1)/10;%mA
v4=ad4(:,2)-ocp(4)-I*r(4);

ad5=load('m080510_15.lvm');%96
ad5=ad5(50:end-590,:);
I5=ad5(:,1)/1;%mA
v5=ad5(:,2)-ocp(5)-I*r(5);

gap=1.19;

h=subplot(5,2,2);

set(h,'fontsize',fc,'FontName','arial')
g=plot(v1,I1,'-k');
ylim([0 0.33])
xlim([1.35 2])
set(h,'yTick',[0:0.1:0.33])
set(h,'xTicklabel','')
set(h,'yTicklabel','')
h_pos=get(h,'position');
set(h,'position',[h_pos(1)/gap h_pos(2) h_pos(3) sub_h])



h=subplot(5,2,4);

set(h,'fontsize',fc,'FontName','arial')
g=plot(v2,I2,'-k');
ylim([0 0.33])
xlim([1.35 2])
set(h,'yTick',[0:0.1:0.33])
set(h,'xTicklabel','')
set(h,'yTicklabel','')
h_pos=get(h,'position');
set(h,'position',[h_pos(1)/gap h_pos(2) h_pos(3) sub_h])


h=subplot(5,2,6);

set(h,'fontsize',fc,'FontName','arial')
g=plot(v3,I3,'-k');
ylim([0 0.33])
xlim([1.35 2])
set(h,'yTick',[0:0.1:0.33])
set(h,'xTicklabel','')
set(h,'yTicklabel','')
h_pos=get(h,'position');
set(h,'position',[h_pos(1)/gap h_pos(2) h_pos(3) sub_h])

h=subplot(5,2,8);

set(h,'fontsize',fc,'FontName','arial')
g=plot(v4,I4,'-k');
xlim([1.35 2])
ylim([0 0.35])
set(h,'yTick',[0:0.1:0.33])
set(h,'xTicklabel','')
set(h,'yTicklabel','')
h_pos=get(h,'position');
set(h,'position',[h_pos(1)/gap h_pos(2) h_pos(3) sub_h])



h=subplot(5,2,10);

set(h,'fontsize',fc,'FontName','arial')
g=plot(v5,I5,'-k');
ylim([0 0.33])
xlim([1.35 2])
set(h,'yTick',[0:0.1:0.33])
set(h,'yTicklabel','')
xlabel('\it\eta\rm_a (V)')
h_pos=get(h,'position');
set(h,'position',[h_pos(1)/gap h_pos(2) h_pos(3) sub_h])


print -r300 -dtiff figure4.tiff