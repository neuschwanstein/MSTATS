function [] = statsGeneration(filename,deltaResults,optResults)

% statsGeneration.m
% filename = '../Tables/GammaTable.tex';
% PROTIP Run questions.m first and keep deltaResults and optResults in 
% your workspace or import it back.
% Basically, t is the table of the results, filled with below defined
% functions, for delta and opt results, respectively. 


stats_name = {'Moyenne','Médiane','Volatilité'};
stats_name2 = {'Asymétrie','Kurtose','Max.','Min.'};

functions = {@mean,@median,@std};
functions2 = {@skewness,@kurtosis,@max,@min};

%% Table 1
t1 = ones(12,2 + 2*length(stats_name));
i = 0;
for keyN=deltaResults.keys
    n = keyN{1};
    deltaResult = deltaResults(n);
    optResult = optResults(n);
    
    for keyK = deltaResult.keys
        K = keyK{1};
        i = i+1;
        t1(i,1) = n;
        t1(i,2) = K;
        j = 3;
        for fct=functions
            f = fct{1};
            t1(i,j) = f(deltaResult(K));
            t1(i,j+1) = f(optResult(K));
            j = j+2;
        end
    end
end

%% Table 2
t2 = ones(12,2 + 2*length(stats_name2));
i = 0;
for keyN=deltaResults.keys
    n = keyN{1};
    deltaResult = deltaResults(n);
    optResult = optResults(n);

    for keyK = deltaResult.keys
        K = keyK{1};
        i = i+1;
        t2(i,1) = n;
        t2(i,2) = K;
        j = 3;
        for fct=functions2
            f = fct{1};
            t2(i,j) = f(deltaResult(K));
            t2(i,j+1) = f(optResult(K));
            j = j+2;
        end
    end
end

%% LateX Writeout
f = fopen(filename,'wt','n','UTF-8');

%% First Table
fprintf(f, sprintf('\\\\begin{tabular}{%s}\n',repmat('l',1,1 + 2*length(stats_name))));
fprintf(f, '\\toprule\n');
fprintf(f, strcat('& \\multicolumn{2}{c}{', strjoin(stats_name, '} & \\\\multicolumn{2}{c}{'), '}\\\\\n'));
fprintf(f, strcat('$(n,K)$',repmat('& Delta & Optimal ',1,length(stats_name)),'\\\\\n'));
fprintf(f, '\\midrule\n');

%% Data1
for i=1:12
    data = t1(i,:);
    key = sprintf('$(%d,%d)$',data(1),data(2));
    data = data(3:end);
    data = arrayfun(@(x) sprintf(qm(abs(x) < 1e-2,'%2.3e','%2.3f'),x),data,'UniformOutput',0);
    vals = strcat(' & \\num{', strjoin(data, '} & \\\\num{'), '}\\\\\n');
    fprintf(f,strcat(key,vals));
end
%% Bottom1
fprintf(f, '\\bottomrule\n');
fprintf(f, '\\end{tabular}\n');
fprintf(f, '\\\\[3em]\n');

%% Table2
fprintf(f, sprintf('\\\\begin{tabular}{%s}\n',repmat('l',1,1 + 2*length(stats_name2))));
fprintf(f, '\\toprule\n');
fprintf(f, strcat('& \\multicolumn{2}{c}{', strjoin(stats_name2, '} & \\\\multicolumn{2}{c}{'), '}\\\\\n'));
fprintf(f, strcat('$(n,K)$',repmat('& Delta & Optimal ',1,length(stats_name2)),'\\\\\n'));
fprintf(f, '\\midrule\n');

%% Data2
for i=1:12
    data = t2(i,:);
    key = sprintf('$(%d,%d)$',data(1),data(2));
    data = data(3:end);
    data = arrayfun(@(x) sprintf('%2.3f',x),data,'UniformOutput',0);
    vals = strcat(' & \\num{', strjoin(data, '} & \\\\num{'), '}\\\\\n');
    fprintf(f,strcat(key,vals));
end
%% Bottom
fprintf(f, '\\bottomrule\n');
fprintf(f, '\\end{tabular}');

fclose(f);

end