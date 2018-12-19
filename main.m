clear
clc
comeP = 0.5;
comeS = 0.5;
serveP = 0.5;
serveSingleS = 0.1;
k = 5;
blockRatio = getBlockRatio(comeP,comeS,serveP,serveSingleS,k);
interruptRatio = getInterruptRatio(comeP,comeS,serveP,serveSingleS,k);
avgLength = getAvgLength(comeP,comeS,serveP,serveSingleS,k);
avgDelay = getAvgDelay(comeP,comeS,serveP,serveSingleS,k);

x = [1:1:10];
y = zeros(1,10);
for i = 1:10
    y(1,i) = getAvgLength(comeP,comeS,serveP,serveSingleS,i);
end
plot(x,y)
