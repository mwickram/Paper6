function figure1



ad0=load('K061510_3.dat');%0
ad0=sgolayfilt(ad0,1,11);
ad0=ad0(150:end-243,:);

I0=ad0(:,2)*1000;%mA
v0=ad0(:,1);


ad4=load('m062210_6.lvm');%923
ad4=ad4(300:end-1540,:);
I4=ad4(:,1)/10;%mA
v4=ad4(:,2);


ad5=load('m080510_15.lvm');%96
ad5=ad5(50:end-590,:);
I5=ad5(:,1)/1;%mA
v5=ad5(:,2);


fc=16;
gap=1.27;

h=subplot(3,3,1);

set(h,'fontsize',fc,'FontName','arial')
h_pos=get(h,'position');
h_pos(1)=h_pos(1)/gap;
set(h,'position',h_pos)
g=plot(v0,I0,'-k');
ylim([-0.044 0.35])
xlim([0.87 1.47])

%xlabel('\itV\rm (V)')
ylabel('Current (mA)')



h=subplot(3,3,2);

set(h,'fontsize',fc,'FontName','arial')
h_pos=get(h,'position');
h_pos(1)=h_pos(1)/gap;
set(h,'position',h_pos)
g=plot(v5,I5,'-k');

xlim([0.87 1.47])
ylim([-0.044 0.35])
set(h,'yTicklabel','')
xlabel('\itV\rm (V)')

h=subplot(3,3,3);

set(h,'fontsize',fc,'FontName','arial')
h_pos=get(h,'position');
h_pos(1)=h_pos(1)/gap;
set(h,'position',h_pos)
g=plot(v4,I4,'-k');
xlim([0.87 1.47])
ylim([-0.044 0.35])

%ylabel('Current (mA)')
set(h,'yTicklabel','')



print -r300 -dtiff figure1.tiff