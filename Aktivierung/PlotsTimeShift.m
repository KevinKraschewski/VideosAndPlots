%% Erzeugt den 3-D Plot ueber Frequenz/Aktivierung und resultierende Differenz der maximalen Amplituden

frequencies = [120:-5:95 90:-2.5:60];
% Die Aktivierungen fuer die simuliert wurden
activations = 1:-.05:.05;

[X,Y] = meshgrid(activations,frequencies);

TimeShifts = zeros(20,6+13);
for i = 1  : 6
    % Lade die Daten
    load(['SmallActivationChange120to60' num2str(i) '_12mm.mat'])
    
    
    for j = 1 : 20
        t = SimResults_Time{j};
        y = SimResults_Y{j};
        c = Config{j};
        
        [HelpTimeShifts,~,~,~] = c.getOutputOfInterest(t,y);
        
        
        % Sollte der Muskel noch nicht aktiviert worden sein wg Simulation
        % "entferne" diesen Wert aus den Daten zusammen mit der
        % Frequenz/Aktivierung
        
        if isnan(HelpTimeShifts)
            X(i,j) = NaN;
            Y(i,j) = NaN;
            
        end
        % Maximum der Maxima -> vermutlich immer die Mitte
        TimeShifts(j,i) = max(HelpTimeShifts);
    end
    
end

for i = 1  : 13
    % Lade die Daten
    load(['SmallActivationChange90to60' num2str(i) '_12mm.mat'])
    
    
    for j = 1 : 20
        t = SimResults_Time{j};
        y = SimResults_Y{j};
        c = Config{j};
        
        [~,~,~,HelpTimeShifts] = c.getOutputOfInterest(t,y);
        
        
        % Sollte der Muskel noch nicht aktiviert worden sein wg Simulation
        % "entferne" diesen Wert aus den Daten zusammen mit der
        % Frequenz/Aktivierung
        
        if isnan(HelpTimeShifts)
            X(i+6,j) = NaN;
            Y(i+6,j) = NaN;
            
        end
        % Maximum der Maxima -> vermutlich immer die Mitte
        TimeShifts(j,i+6) = max(HelpTimeShifts);
    end
    
end

%% Grid und Surfplot
surf(X,Y,TimeShifts')
title('Arithmetischer Mittelwert der Zeitdifferenz von Peaks in Abhaengigkeit von Frequenz und max Aktivierung');
ylabel('Frequenzen [Hz]');
xlabel('Aktivierung [%]');
zlabel('Arithmetischer Mittelwert der Zeitdifferenzen der Peaks [s]');