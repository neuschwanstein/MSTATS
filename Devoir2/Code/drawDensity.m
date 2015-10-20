function p = drawDensity(v)
hold on
h = histogram(v,'Normalization','pdf');
set(h,'Visible','off');
values = h.Values;
width = h.BinWidth;
x = h.BinLimits(1)+width/2:width:h.BinLimits(2)-width/2;
p = plot(x,values);
end