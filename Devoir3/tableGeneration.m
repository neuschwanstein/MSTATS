function [] = tableGeneration(price,delta)

price_filename = 'Redaction/price%d.tex';
delta_filename = 'Redaction/delta%d.tex';

T=[30,90,180];

for i=1:3
    price_file = fopen(sprintf(price_filename,T(i)),'wt','n','UTF-8');
    delta_file = fopen(sprintf(delta_filename,T(i)),'wt','n','UTF-8');
    
    for j=7*(i-1)+1:7*i
        price_row = sprintf('& %0.2f',price(j,1));
        delta_row = sprintf('& %0.2f',delta(j,1));
        
        for k=2:11
            price_row = strcat(price_row, sprintf(' & %4.4f',price(j,k)));
            delta_row = strcat(delta_row, sprintf(' & %4.4f',delta(j,k)));
        end
        price_row = strcat(price_row, '\\\\ \n');
        delta_row = strcat(delta_row, '\\\\ \n');
        
        fprintf(price_file, price_row);
        fprintf(delta_file, delta_row);
    end
    
    fclose(price_file);
    fclose(delta_file);
end