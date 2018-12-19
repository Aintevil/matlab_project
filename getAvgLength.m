function avgLength = getAvgLength( comeP,comeS,serveP,serveSingleS,k )
pStatic = getPMatrix( comeP,comeS,serveP,serveSingleS,k );
avgLength = 0;
for i=1:1:k+1
    avgLength = avgLength + i*pStatic(1,2*i) +(i-1)*pStatic(1,2*k+1);
end