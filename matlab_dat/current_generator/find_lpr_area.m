function find_lpr_area (file,isy,relu,fix_area,area_lo,ran_area,area_up)

%load the file rm102709_1
d=load(file);%Pt electrode immersed 2 cm  1st column: current 2nd: potential
d=sgolayfilt(d,1,61);

cud=d(:,1)/fix_area;

area=area_lo:ran_area:area_up;


for k=1:length(area)
    
d1(:,k)=area(k)*cud(:,1);


end

d=[d1 d(:,2)];%The last column is potential

Range=zeros(length(d),1); %a dummy vector
fitt=zeros(length(d),1); %a dummy vector

for k=1:length(area)
    
    
[row]=find((isy-relu)<(d1(:,k)) & (isy+relu)>(d(:,k)));

res(:,k)=abs(diff(d(:,end)))./abs(diff(d(:,k)));

Ra=res(row);

LPR(k,1)=mean(res(row)); % The value of LPR calulated from entire selected range

lg(k,1)=length(Ra);
ml=min(lg);

Range=Range(1:ml,:);
Range(:,k)=Ra(1:ml,:);% Not entire selected values may not be in this vector

% disp('Range');
% disp([num2str(Range(,:))]) ;
% disp([num2str(Range(end,1:2))]);
% disp('Data fitting') ;
% disp([num2str(length(Range))]);


p_res= polyfit(d(row,end),d(row,k),1);

fit =polyval(p_res,d(row,end));

lfg(k,1)=length(fit);

mfl=min(lfg);

fit=fitt(1:mfl,:);
fit(:,k)=fit(1:mfl,:);



LPR_cf(k,1)=1/p_res(1);


end

%Range
LPR;
disp('From Curve Fitting');
LPR_cf

figure(1)

subplot(3,2,1)

g=plot(d(:,end),d1(:,1),'--k')

ylabel('i (mA)'); xlabel( 'V (mV)');
%ylim([d(end,1) 0]);
%de=d(find(d(:,1)<0),1);
%text(d(end,2),de(4),metal,'FontSize',15);
%set(g(2),'linewidth',2);

title(['scan',' ',file(1:7),'\_',file(9:13)]);

subplot(3,2,2)

plot(d(:,end),d1(:,end),'-');

subplot(3,2,3)
    
g2=plot(d1(1:end-1,1),res(:,1));
set(g2(1),'linewidth',2);
xlabel('i (mA)');
ylabel('R (\Omega)');
%xlim([d(end,1)  (relu+Range(1,1))]);
%title(['LPR',  '=' , num2str(LPR_cf), '\Omega','  ','@',' ', num2str(isy),' ','mA']);


%disp('j_o mA/cm^2     Alpha     Current mA     LPR_cf');
%disp(num2str([exp(p(2)) em_alpha isy LPR_cf]));

subplot(3,2,4)

plot(d(1:end-1,end-1),res(:,end-1),'--','Linewidth',2.5);

subplot(3,2,5)
    

g2=plot(area,log(LPR_cf),'o-');
xlabel('Area Cm^2');
ylabel('R (\Omega)');
%xlim([cud(end,1)  (relu+Range(1,1))/area]);
%title(['LPR',  '=' , num2str(LPR_cf), '\Omega','  ','@',' ', num2str(isy/area),' ','mA/cm^2']);


%disp('Current mA/cm^2  LPR_cf');
%disp(num2str([isy/area  LPR_cf]));


subplot(3,2,6)

R_p=5000;%ohms

sigma=2*LPR_cf(:,1)./(R_p*(2*LPR_cf(:,1)+ R_p));
sigma=1./log10(1./sigma(:,1))
    
g2=plot(LPR_cf(:,1),sigma(:,1),'-');
set(g2(1),'linewidth',2);
xlabel('R (\Omega)');
ylabel('k')
%xlim([d(end,1)  (relu+Range(1,1))]);
%title(['LPR',  '=' , num2str(LPR_cf), '\Omega','  ','@',' ', num2str(isy),' ','mA']);

data=[area' LPR_cf];

%save -ascii lpf.dat data
end





