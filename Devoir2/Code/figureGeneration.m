% figureGeneration.m
% PROTIP Run questions.m first and keep deltaResults and optResults in 
% your workspace or import it back.

deltaResults = gammaDeltaResults;
optResults = gammaOptResults;

figure
it = 1;
for keyN=deltaResults.keys
    n = keyN{1};
    deltaResult = deltaResults(n);
    optResult = optResults(n);
    
    m = length(deltaResults.keys);
    p = length(deltaResult.keys);
    
    for keyK = deltaResult.keys
        K = keyK{1};
        [yDelta,xDelta] = ksdensity(deltaResult(K));
        [yOpt,xOpt] = ksdensity(optResult(K));
        
        mu = [mean(deltaResult(K)), mean(optResult(K))];
        
        subplot(m,p,it);
        hold on
        plot(xDelta,yDelta,xOpt,yOpt);
        legend(strcat('Delta \mu=',sprintf('%0.2f',mu(1))) , strcat('Optimal \mu=',sprintf('%0.2f',mu(2))));
        title(sprintf('n=%d, K=%d',n,K));
        
        it = it+1;
    end
end