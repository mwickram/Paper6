function figure2


d1=load('m061110_3.lvm');%0.05
d1=d1(400:end-390,:);
I1=d1(:,1)/1;%mAV
v1=d1(:,2);%

d4=load('m061110_8.lvm');%1.5
d4=d4(400:end-890,:);
I4=d4(:,1)/1;%mAV
v4=d4(:,2);%


d5=load('m061110_11.lvm');%6
d5=d5(1:end-432,:);
I5=d5(:,1)/1;%mAV
v5=d5(:,2);%


fc=16;
gap=1.27;

h=subplot(3,3,1);

set(h,'fontsize',fc)
h_pos=get(h,'position');
h_pos(1)=h_pos(1)/gap;
set(h,'position',h_pos)


g=plot(v5,I5,'-k');

ylim([0 0.33])
xlim([1.4 2])
%xlim([1.5 1.9])

ylabel('Current (mA)','fontname', 'times new roman')

h=subplot(3,3,2);

set(h,'fontsize',fc)
h_pos=get(h,'position');
h_pos(1)=h_pos(1)/gap;
set(h,'position',h_pos)


g=plot(v4,I4,'-k');
xlim([1.4 2.2])
ylim([0 0.33])
xlabel('\itV\rm (V)', 'fontname', 'times new roman')
set(h,'yTicklabel','')

h=subplot(3,3,3);

set(h,'fontsize',fc)
h_pos=get(h,'position');
h_pos(1)=h_pos(1)/gap;
set(h,'position',h_pos)


g=plot(v1,I1,'-k');
ylim([0 0.33])
xlim([1.66 2.28])
set(h,'yTicklabel','')



print -r300 -dtiff figure2.tiff