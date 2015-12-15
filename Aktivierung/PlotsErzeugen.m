%% Erzeugt den 3-D Plot ueber Frequenz/Aktivierung und resultierende Differenz der maximalen Amplituden
% Die Frequenzen fuer die simuliert wurden
frequencies = [120:-5:95 90:-2.5:60];
% Die Aktivierungen fuer die simuliert wurden
activations = 1:-.05:.05;

[X,Y] = meshgrid(activations,frequencies);

Amp = zeros(20,6+13);
for i = 1  : 6
    % Lade die Daten
    load(['SmallActivationChange120to60' num2str(i) '_12mm.mat'])
    
    
    for j = 1 : 20
        t = SimResults_Time{j};
        y = SimResults_Y{j};
        c = Config{j};
        
        [~,~,~,HelpAmpMaxima] = c.getOutputOfInterest(t,y);
        
        
        % Sollte der Muskel noch nicht aktiviert worden sein wg Simulation
        % "entferne" diesen Wert aus den Daten zusammen mit der
        % Frequenz/Aktivierung
        
        if isnan(HelpAmpMaxima)
            X(i,j) = NaN;
            Y(i,j) = NaN;
            
        end
        % Maximum der Maxima -> vermutlich immer die Mitte
        Amp(j,i) = max(HelpAmpMaxima);
    end
    
end

for i = 1  : 13
    % Lade die Daten
    load(['SmallActivationChange90to60' num2str(i) '_12mm.mat'])
    
    
    for j = 1 : 20
        t = SimResults_Time{j};
        y = SimResults_Y{j};
        c = Config{j};
        
        [~,~,~,HelpAmpMaxima] = c.getOutputOfInterest(t,y);
        
        
        % Sollte der Muskel noch nicht aktiviert worden sein wg Simulation
        % "entferne" diesen Wert aus den Daten zusammen mit der
        % Frequenz/Aktivierung
        
        if isnan(HelpAmpMaxima)
            X(i+6,j) = NaN;
            Y(i+6,j) = NaN;
            
        end
        % Maximum der Maxima -> vermutlich immer die Mitte
        Amp(j,i+6) = max(HelpAmpMaxima);
    end
    
end

%% Grid und Surfplot
close all
figure
surf(X,Y,Amp')
title('Differenz der maximalen Amplituden in Abhaengigkeit von Frequenz und maximaler Aktivierung');
ylabel('Frequenzen [Hz]');
xlabel('maximale Aktivierung [%]');
zlabel('maximale Amplitudenverstärkung [%]');

figure
[maxAmpsPerActivation,Indices] = max(Amp');
Resonanzfrequenz = frequencies(Indices);
plot(activations,Resonanzfrequenz);
xlabel('maximale Aktivierung [%]');
ylabel('Resonanzfrequenz [Hz]');
title('Resonanzfrequenzen über Aktivierung');