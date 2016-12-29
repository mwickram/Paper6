function figure6(data)


data=load('cas_model/m011313_1.dat');
curr=data(:,5);
v=data(:,2);
currd=data(:,6);


fc=16;
lw=1.1;

h=subplot(2,2,1);
set(h,'fontsize',fc)
plot(v,curr,'-k','linewidth',lw);
xlim([-15 0])
ylim([-2 6])


xlabel('\itV','fontname','times new roman');
ylabel('\itI','fontname','times new roman');


wf=81;
currd=sgolayfilt(currd,2,81);
v=sgolayfilt(v,2,81);

dri=diff(currd)./diff(v);
dr=1./dri;


iset=-1;
ndata=0;

for k=1:length(dr)
    if currd(k) < 0
        ndata=ndata+1;
   A(ndata)=iset./currd(k);
   R(ndata)=dr(k)/A(ndata);
    end
end



h=subplot(2,2,4);
set(h,'fontsize',fc)
plot(log10(A),R,'-k','linewidth',lw);

xlabel('Log_1_0(\itA\rm)','fontname','times new roman');
ylabel('\itR\rm _F','fontname','times new roman');
xlim([1 2])
ylim([-1 50])

h=subplot(2,2,2);

set(h,'fontsize',fc)
plot(v(1:end-1,1),dr,'-k','linewidth',lw)
ylabel('\itR\rm _F','fontname','times new roman')
xlabel('\itV','fontname','times new roman')
xlim([-15 0])
ylim([-20 1000])

h=subplot(2,2,3);

set(h,'fontsize',fc)
plot(curr(1:end-1,1),dr,'-k','linewidth',lw)

ylabel('\itR\rm _F','fontname','times new roman')
xlabel('\itI','fontname','times new roman')
ylim([-20 1000])
xlim([-2 0])

print -r300 -dtiff figure6.tiff


