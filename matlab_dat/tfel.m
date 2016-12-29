function tfel(data,row,ocp,dia,limt)

d=load(data);
d=sgolayfilt(d,1,21);
area=pi*((dia/(2*10))^2);
curr_den=-(d(:,1)/area);
ovp=d(:,2)-ocp;

ovp_neg=[curr_den(find(ovp<0)) ovp(find(ovp<0))];

ovp1=ovp(find(abs(ovp_neg(:,2))>limt));
curr_den1=curr_den(find(abs(ovp_neg(:,2))>limt));
    
d1=[log(curr_den1) ovp1];
d1=d1(row:end,:);
p=polyfit(d1(:,2),d1(:,1),1);
fit=polyval(p,ovp);    

subplot(2,2,1)

plot(d(:,2),d(:,1))
xlabel('V (mV)');ylabel('i (mA)');

title(['scan',' ',data(1:7),'-',data(9:13)]);

subplot(2,2,2)

plot(ovp,log(curr_den))

title(['Tafel plot OCP=' num2str(ocp) 'mV']);
xlabel('\mu (mV)');ylabel('i (mA)')

jo=exp(p(2));
em_alpha=abs((p(1)*8.314*283)/96500);

disp(['io',' = ', num2str(jo),' ', 'mA']);
disp(['alpha','=',num2str(em_alpha)]);

subplot(2,2,3)

plot(ovp_neg(:,2),log(ovp_neg(:,1)),ovp,fit);

title(['j_o =',' ',num2str(jo),',' ,'\alpha =',' ',num2str(em_alpha)]);
xlabel('\mu (mV)');ylabel('i (mA)')