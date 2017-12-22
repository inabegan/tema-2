P=40; %Perioada semnalului triunghiular
N=50; % Numarul de coeficienti  
D=2; %Durata semnalului 
t1=0:0.2:80; 
syms t;
W0=(2*pi)/P; %Pulsatia semnalului triunghiular
x1=t/36;%Dreapta cu panta crescatoare 
x2=1-(t-36)/4; %Dreapta cu panta descrescatoare
xi=0.5*sawtooth(t1*2*pi*1/P,0.5)+0.5 %Semnalul initial
x0=1/P*int(x1,t,0,P-D)+1/P*int(x2,t,P-D,P); %Componenta continua a semnalului
disp('x0=');
disp(x0);
a=zeros(1,N); %Intitializare cu 0 a variabilei a  
frecv=zeros(1,N);   % Initializare cu 0 a frecventei 
y=0; %Initializare a semnalului reconstruit
for k=1:N
  f1=x1*exp(-1j*W0*k*t); %Functia de integrat pentru dreapta cu panta crescatoare
  f2=x2*exp(-1j*W0*k*t); %Functia de integrat pentru dreapta cu panta descrescatoare
  xk=1/P*int(f1,t,0,P-D)+1/P*int(f2,t,P-D,P); %Calculul coeficientilor 
  a(k)=sqrt((imag(xk))^2+(real(xk))^2);  %Calculul amplitudinii
  frecv(k)=k/P;
  S=['x',num2str(k),'='];
  disp (S);
  disp(xk);
  y=y+2*(xk*exp(1j*k*W0*t1)); %Reconstruirea semnalului initial
end
y1=y+x0; %Adaugarea componentei continue
figure(1);
stem(0,x0,'-b') %Reprezentarea amplituidinii componentei continue 
hold on
stem(frecv, a,'-b') %Reprezentarea spectrului de amplitudini la frecvente pozitive
hold on 
stem(-frecv,a,'-b')%Reprezentarea spectrului de amplitudini la frecvente negative
title('Reprezentarea spectrului de amplitudini ')
xlim([-N/P N/P])
figure(2)
plot (t1,xi,'-g') %Reprezentarea semnalului initial 
hold on
plot(t1,y1,'--r') %Reprezentarea semnalului reconstruit
title('Reprezentarea semnalului initial si cel reconstruit')
legend('semnalul initial', 'semnalul reconstruit')
axis([0 80 -2 2])