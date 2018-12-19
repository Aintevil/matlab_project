function avgDelay = getAvgDelay( comeP,comeS,serveP,serveSingleS,k )
avgLength = getAvgLength( comeP,comeS,serveP,serveSingleS,k );
blockRatio = getBlockRatio( comeP,comeS,serveP,serveSingleS,k );
avgDelay = avgLength/(comeS-blockRatio);