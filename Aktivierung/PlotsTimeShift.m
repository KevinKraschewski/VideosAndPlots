%% Erzeugt den 3-D Plot ueber Frequenz/Aktivierung und resultierende Differenz der maximalen Amplituden

% Die Frequenzen fuer die simuliert wurden
frequencies = 50:-5:15;
% Die Aktivierungen fuer die simuliert wurden
activations = 1:-.05:.05;

[X,Y] = meshgrid(activations,frequencies);

TimeShifts = zeros(20,8);
for i = 4  : 11
    % Lade die Daten
    load(['C:\Users\Kevin Kraschewski\Documents\MATLAB\HiWi\SmallActivationChange' num2str(i) '_12mm.mat'])
    
    
    for j = 1 : 20
        t = SimResults_Time{j};
        y = SimResults_Y{j};
        c = Config{j};
              
        [TimeShift,~,~,~] = c.getOutputOfInterest(t,y);

        
        % Sollte der Muskel noch nicht aktiviert worden sein wg Simulation
        % "entferne" diesen Wert aus den Daten zusammen mit der
        % Frequenz/Aktivierung
        
        if isnan(TimeShift)
            X(i-3,j) = NaN;
            Y(i-3,j) = NaN;
            
        end
        % Maximum der Maxima -> vermutlich immer die Mitte
        TimeShifts(j,i-3) = TimeShift;
    end
    
end


% Keine Ahnung wo die anderen herkamen?!
TimeShifts = TimeShifts(1:20,1:8);
%% Grid und Surfplot
surf(X,Y,TimeShifts')
title('Arithmetischer Mittelwert der Zeitdifferenz von Peaks in Abhaengigkeit von Frequenz und max Aktivierung');
ylabel('Frequenzen [Hz]');
xlabel('Aktivierung [%]');
zlabel('Arithmetischer Mittelwert der Zeitdifferenzen der Peaks [s]');