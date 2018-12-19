function pStatic = getPMatrix( comeP,comeS,serveP,serveSingleS,k )
%getPMatrix 本函数返回概率分布矩阵

% 转移概率矩阵
transferMatrix = cell(k+2);

%稳态概率
pStatic = zeros(1,2*k+3);

%阻塞率
blockRatio = 0;

%中断率
interruptRatio = 0;

%平均队长
avgLength = 0;

%平均延迟
avgDelay = 0;

%转移概率矩阵填充0元素
transferMatrix{1,1} = zeros(1);
for i=2:1:k+2
    transferMatrix{1,i} = zeros(1,2);
end
for i=2:1:k+2
    transferMatrix{i,1} = zeros(2,1);
    for j=2:1:k+2
        transferMatrix{i,j} = zeros(2,2);
    end
end


W00 = (1-comeP)*(1-comeS);
W01 =[ (1-comeP)*comeS,comeP*(1-comeS)];
W02 = [0,comeP*comeS];
W10 = [(1-comeP)*(1-comeS)*serveSingleS;(1-comeP)*(1-comeS)*serveP];
W11 = [(1-comeP)*((1-comeS)*(1-serveSingleS)+comeS*serveSingleS),comeP*(1-comeS);(1-comeP)*comeS*serveP,(1-comeS)*(comeP*serveP+(1-serveP))];
W12 = [(1-comeP)*comeS*(1-serveSingleS),comeP*comeS;0,comeS*(comeP*serveP+(1-serveP))];
transferMatrix{1,1} = W00;
transferMatrix{1,2} = W01;
transferMatrix{1,3} = W02;
transferMatrix{2,1} = W10; 
transferMatrix{2,2} = W11;
transferMatrix{2,3} = W12;

for m=2:1:k+1
    Wji = [(1-comeP)*(1-comeS)*m*serveSingleS,0;(1-comeP)*(1-comeS)*serveP,0];
    Wii = [(1-comeP)*((1-comeS)*(1-serveSingleS*m)+comeS*serveSingleS*m),comeP*(1-comeS);(1-comeP)*comeS*serveP,(1-comeS)*(comeP*serveP+(1-serveP))];
    Wij = [(1-comeP)*comeS*(1-m*serveSingleS),comeP*comeS;0,comeS*(comeP*serveP+(1-serveP))];
    
    if m ~= k+1
        transferMatrix{m+1,m} = Wji;
        transferMatrix{m+1,m+1} = Wii;
        transferMatrix{m+1,m+2} = Wij;
    else
        transferMatrix{m+1,m} = Wji;
        transferMatrix{m+1,m+1} = Wii + Wij;
    end
end

%转移概率矩阵构建完成
transferMatrix = cell2mat(transferMatrix);

%用迭代法构造稳态概率矩阵
pStatic(1,2*k+3) = 1;
diff =1;
while diff>0.0001
    temp = pStatic;
    pStatic = pStatic*transferMatrix;
    diff = max(abs(pStatic-temp));
end

%计算阻塞率
blockRatio = comeS*(pStatic(1,2*k+3)*((1-serveP)+serveP*comeP)+pStatic(1,2*k+2)*((1-serveSingleS*(k+1))+serveSingleS*(k+1)*comeS));

%计算中断率
interruptRatio = 0;
for i=1:1:k+1
    interruptRatio = interruptRatio + comeP *pStatic(1,2*i) * (1-serveSingleS)*i;
end
io = comeS - blockRatio - interruptRatio;

%计算平均队长
avgLength = 0;
for i=1:1:k+1
    avgLength = avgLength + i*pStatic(1,2*i) +(i-1)*pStatic(1,2*k+1);
end

%计算平均延迟
avgDelay = avgLength/(comeS-blockRatio);
