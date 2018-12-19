function blockRatio = getBlockRatio( comeP,comeS,serveP,serveSingleS,k )
pStatic = getPMatrix( comeP,comeS,serveP,serveSingleS,k );
blockRatio = comeS*(pStatic(1,2*k+3)*((1-serveP)+serveP*comeP)+pStatic(1,2*k+2)*((1-serveSingleS*(k+1))+serveSingleS*(k+1)*comeS));
