function current_density


figure(1)

subplot(2,2,1)
% 0.008
%data1=load('m060210_111.dat');
%data1=sgolayfilt(data1,1,61);
%plot(data1(:,2),data1(:,1)/0.008,'b-');

%0.05

%data2=load('m060910_101.dat');
%data2=sgolayfilt(data2,1,61);
%plot(data2(:,2),data2(:,1)/0.05,'k-','linewidth',2);

%0.135

%data3=load('m060210_110.dat');
%data3=sgolayfilt(data3,1,61);
%plot(data3(:,2),data3(:,1)/0.135,'k--');


%0.5

data4=load('m060210_109.dat');
data4=sgolayfilt(data4,1,61);
plot(data4(:,2),data4(:,1)/0.5,'k--','linewidth',2);
hold on
%0.75

%data5=load('m060210_114.dat');
%data5=sgolayfilt(data5,1,61);
%plot(data5(:,2),data5(:,1)/0.75,'k-.');

%1

data6=load('m060210_108.dat');
data6=sgolayfilt(data6,1,61);
plot(data6(:,2),data6(:,1)/1,'k-','linewidth',2);


%1.5

%data7=load('m060210_115.dat');
%data7=sgolayfilt(data7,1,61);
%plot(data7(:,2),data7(:,1)/1.5,'r-');

%2
%data8=load('m060210_107.dat');
%data8=sgolayfilt(data8,1,61);
%plot(data8(:,2),data8(:,1)/2,'r-','linewidth',2);

%3
%data9=load('m060210_106.dat');
%data9=sgolayfilt(data9,1,61);
%plot(data9(:,2),data9(:,1)/3,'r--');

%6
%data10=load('m060210_113.dat');
%data10=sgolayfilt(data10,1,61);
%plot(data10(:,2),data10(:,1)/6,'r--','linewidth',2);

%16
%data11=load('m062210_402.dat');
%data11=sgolayfilt(data11,1,61);
%plot(data11(:,2),data11(:,1)/16,'r-.');

%30
%data12=load('m062210_502.dat');
%data12=sgolayfilt(data12,1,61);
%plot(data12(:,2),data12(:,1)/30,'r-.','linewidth',2);

xlabel('V (mV)');
ylabel('j (mA/cm^2)');
legend('0.5','1','Location','best')

xlim([-895 -585]);
ylim([-0.4 0])


subplot(2,2,2)


% 0.008
%data1=load('m060210_111.dat');
%data1=sgolayfilt(data1,1,61);
%plot(data1(:,2),log(abs(data1(:,1)/0.008)),'k-');

%0.05

%data2=load('m060910_101.dat');
%data2=sgolayfilt(data2,1,61);
%plot(data2(:,2),log(abs(data2(:,1)/0.05)),'k-','linewidth',2);

%0.135

%data3=load('m060210_110.dat');
%data3=sgolayfilt(data3,1,61);
%plot(data3(:,2),log(abs(data3(:,1)/0.135)),'k--');


%0.5

data4=load('m060210_109.dat');
data4=sgolayfilt(data4,1,61);
plot(data4(:,2),log(abs(data4(:,1)/0.5)),'k--','linewidth',2);
hold on
%0.75

%data5=load('m060210_114.dat');
%data5=sgolayfilt(data5,1,61);
%plot(data5(:,2),log(abs(data5(:,1)/0.75)),'k-.');

%1

data6=load('m060210_108.dat');
data6=sgolayfilt(data6,1,61);
plot(data6(:,2),log(abs(data6(:,1)/1)),'k-','linewidth',2);


xlabel('V (mV)');
ylabel('ln(j)' );

xlim([-900 -590]);
ylim([-5 -0.9])
%1.5

%data7=load('m060210_115.dat');
%data7=sgolayfilt(data7,1,61);
%plot(data7(:,2),log(abs(data7(:,1)/1.5)),'r-');

%2
%data8=load('m060210_107.dat');
%data8=sgolayfilt(data8,1,61);
%plot(data8(:,2),log(abs(data8(:,1)/2)),'r-','linewidth',2);

%3
%data9=load('m060210_106.dat');
%data9=sgolayfilt(data9,1,61);
%plot(data9(:,2),log(abs(data9(:,1)/3)),'r--');

%6
%data10=load('m060210_113.dat');
%data10=sgolayfilt(data10,1,61);
%plot(data10(:,2),log(abs(data10(:,1)/6)),'r--','linewidth',2);

%16
%data11=load('m062210_402.dat');
%data11=sgolayfilt(data11,1,61);
%plot(data11(:,2),log(abs(data11(:,1)/16)),'r-.');

%30
%data12=load('m062210_502.dat');
%data12=sgolayfilt(data12,1,61);
%plot(data12(:,2),log(abs(data12(:,1)/30)),'r-.','linewidth',2);

area1=[0.008 0.05 0.135 0.5 0.75 1 1.5 2 3 6 16 30];
area2= [0.008 0.135 0.5 1 2 3 6 16 30];
Rf1=[433 393 460 658 732 1108 923 727 309 96 82 27];
Rf2=[420 425 615 1300 595 300 90 70 28];
%gRf=[433 446 606 718 280 115 86 62 36 17 7 3];
gRf=[452 352 342 504 725 1513 518 274 111 56 21 11];
subplot(2,2,3)

g1=plot(log(area1),Rf1,'k-o',log(area2),Rf2,'k-^');
set(g1,'linewidth',2,'markerfacecolor','k');
xlabel('ln(Area)');ylabel('R (\Omega)')
legend('trial 1','trial 2')
title ('Fradiac Resistance vs Area')
ylim([0 1570]);


subplot(2,2,4)
plot(log(area1), gRf,'k-o','linewidth',2,'markerfacecolor','k');
xlabel('ln(Area)');ylabel('R (\Omega)')
title ('Area determined from 1 cm^2 electrode')
ylim([0 1570]);

end



