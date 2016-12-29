
data=load('lpr.dat');

figure(1)

subplot(2,2,1)

plot(data(:,1),data(:,2),'-')
xlabel('Area (Cm^2)');ylabel('R (\Omega)')
xlim([0 30]);

subplot(2,2,2)

plot(data(:,1),data(:,2),'-')
xlim([0 10]);
xlabel('Area (Cm^2)');ylabel('R (\Omega)')

subplot(2,2,3)

plot(data(:,1),data(:,2),'-')
xlim([0 1])
xlabel('Area (Cm^2)');ylabel('R (\Omega)')

subplot(2,2,4)

plot(data(:,1),data(:,2),'-')
xlim([10 32])
xlabel('Area (Cm^2)');ylabel('R (\Omega)')

Rt=5000;%ohms

sigma=2*data(:,2)./((Rt- 2*(data(:,2)))*Rt);

    

figure(2)

subplot(2,2,1)

plot(data(:,2),sigma,'-');
xlabel('R (\Omega)');ylabel('k')

subplot(2,2,2)

plot(data(:,2),1./log10(1./sigma),'-')
xlabel('R (\Omega)');ylabel('1/log(1/k)')

subplot(2,2,3)

plot(data(:,1),sigma,'-')
xlabel('Area (Cm^2)');ylabel('k')
xlim([0 6]);
subplot(2,2,4)

plot(data(:,1),1./log10(1./sigma),'-')
xlabel('Area (Cm^2)');ylabel('1/log(1/k)')
xlim([0 15])



