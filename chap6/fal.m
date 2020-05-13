function y=fal(epec,alfa,delta)
if abs(epec)>delta
    y=abs(epec)^alfa*sign(epec);
else
    y=epec/(delta^(1-alfa));
end