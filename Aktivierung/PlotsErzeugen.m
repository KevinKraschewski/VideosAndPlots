%% Erzeugt den 3-D Plot ueber Frequenz/Aktivierung und resultierende Differenz der maximalen Amplituden

% Die Frequenzen fuer die simuliert wurden
frequencies = 50:-5:15;
% Die Aktivierungen fuer die simuliert wurden
activations = 1:-.05:.05;

[X,Y] = meshgrid(activations,frequencies);

Amp = zeros(20,8);
for i = 4  : 11
    % Lade die Daten
    load(['C:\Users\Kevin Kraschewski\Documents\MATLAB\HiWi\SmallActivationChange' num2str(i) '_12mm.mat'])
    
    
    for j = 1 : 20
        t = SimResults_Time{j};
        y = SimResults_Y{j};
        c = Config{j};
              
        [~,~,~,HelpAmpMaxima] = c.getOutputOfInterest(t,y);

        
        % Sollte der Muskel noch nicht aktiviert worden sein wg Simulation
        % "entferne" diesen Wert aus den Daten zusammen mit der
        % Frequenz/Aktivierung
        
        if isnan(HelpAmpMaxima)
            X(i-3,j) = NaN;
            Y(i-3,j) = NaN;
            
        end
        % Maximum der Maxima -> vermutlich immer die Mitte
        Amp(j,i-3) = max(HelpAmpMaxima);
    end
    
end


% Keine Ahnung wo die anderen herkamen?!
Amp = Amp(1:20,1:8);
%% Grid und Surfplot
surf(X,Y,Amp')
title('Differenz der maximalen Amplituden in Abhaengigkeit von Frequenz und maximaler Aktivierung');
ylabel('Frequenzen [Hz]');
xlabel('maximale Aktivierung [%]');
zlabel('maximale Amplitudendifferenz [mm]');