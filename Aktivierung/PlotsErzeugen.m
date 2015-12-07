%% Erzeugt den 3-D Plot ueber Frequenz/Aktivierung und resultierende max.Amplitude

% Die Frequenzen fuer die simuliert wurden
frequencies = 50:-5:15;
% Die Aktivierungen fuer die simuliert wurden
activations = 1:-.05:.05;

Amp = zeros(20,8);
% Rueckwaerts wegen komischer Speicherung zuvor...
for i = 4  : 11
    % Lade die Daten
    load(['C:\Users\Kevin Kraschewski\Documents\MATLAB\HiWi\SmallActivationChange' num2str(i) '_12mm.mat'])
    
    
    for j = 1 : 20
        t = SimResults_Time{j};
        y = SimResults_Y{j};
        c = Config{j};
              
        [~,~,~,HelpAmpMaxima] = c.getOutputOfInterest(t,y);

        
        % Sollte der Muskel noch nicht aktiviert worden sein wg Simulation
        % entferne diesen aus den Daten zusammen mit der
        % Frequenz/Aktivierung
        
        if HelpAmpMaxima == 0
            frequencies(i,j) = NaN;
            activations(i,j) = NaN;
            HelpAmpMaxima = NaN;
        end
        % Maximum der Maxima -> vermutlich immer die Mitte
        Amp(j,i-3) = max(HelpAmpMaxima);
    end
    
end


% Keine Ahnung wo die anderen herkamen?!
Amp = Amp(1:20,1:8);
%% Grid und Surfplot
[X,Y] = meshgrid(activations,frequencies);
surf(X,Y,Amp')
title('maximalen Amplituden Differenz in Abhaengigkeit von Frequenz und maximaler Aktivierung');
ylabel('Frequenzen [Hz]');
xlabel('maximale Aktivierung [%]');
zlabel('maximale Amplitudendifferenz [mm]');