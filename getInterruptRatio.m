function interruptRatio = getInterruptRatio( comeP,comeS,serveP,serveSingleS,k )
interruptRatio = 0;
pStatic = getPMatrix( comeP,comeS,serveP,serveSingleS,k );
for i=1:1:k+1
    interruptRatio = interruptRatio + comeP *pStatic(1,2*i) * (1-serveSingleS)*i;
end