clc
clear all
close all


xPos = 0;
x = zeros(1,1);
v = zeros(1,1);
t = zeros(1,1);%time
V = zeros(1,1);
Dt = 1; %Time step
 F = 1; %Force
 m = 1; %Mass

steps = 100;

rebound = 0; 

pr = 0.05; % Probability of scattering
Tau = 20;

for i = 2:steps
    
    t(:,i) = t(:,i-1) + Dt;
    v(:,i) = v(:,i-1) + F/m*Dt;
    x(:,i) = x(:,i-1) + v(:,i-1)*Dt + (F/m * Dt^2)/2; 
    
    pr = 1 - exp(-Dt/Tau);  % Scattering
    r = rand(1,1) < pr;    
    v(r,i) = rebound*v(r,i);
    V(i,:) = mean(v,2); %average mean of velocities
    
    %Plots
    % Plot Velocity vs Time
    subplot(3,1,1), plot(t,v,'m');
    hold on;
    subplot(3,1,1), plot(t,V,'k');
    hold off;
    xlabel('time') , ylabel('velocity')
    title(['Drift Velocity: ', num2str(V(i,:)/1e7), 'e7 m/s'])
    
    % Plot Velocity vs Position 
    subplot(3,1,2), plot(x(1,:),v,'r');
    hold on;
    subplot(3,1,2), plot(x(1,:),V,'y');
    hold off;    
    xlabel('position') , ylabel('velocity')
        
    % Plot Position vs Time
    subplot(3,1,3), plot(t,x,'b');
    xlabel('time') , ylabel('position')     
      
    pause(0.02)
end 

display('Drift Velocity:')
V(steps,:)
