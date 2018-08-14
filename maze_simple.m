function mazeBeyond
 main(12);
function main(sz)
hold on; axis([0 sz 0 sz]); axis square;
for i = (1:sz)-.5
    plot([i i], [1 sz]-.5, 'b');
    plot([1 sz]-.5, [i i], 'b');
end
plot([.5 1.5], [.5 .5], 'w'); plot([sz sz]-.5, [sz-1 sz]-.5, 'w');
tree = []; x0 = 1; y0 = 1;
tree = [tree; [x0 y0]]; cnt = 1;
while 1
    [x1, y1] = move(x0, y0, sz);
    if ismember([x1 y1], tree, 'rows')
    else
        tree = [tree; [x1 y1]];
        breakWall(x0, y0, x1, y1); 
        cnt = cnt + 1;
%         drawnow;
    end
    [nrow, ncol] = size(tree);
    if nrow == (sz-1) * (sz-1), break; end
    x0 = x1; y0 = y1;
end
function [x, y] = move(x, y, sz)
p = [x y]; dice = rand;
if isequal(p, [1, 1])
    if dice <= 1/2, y = y + 1;
    else x = x + 1; end
elseif isequal(p, [1, sz-1])
    if dice <= 1/2, y = y - 1;
    else x = x + 1; end
elseif isequal(p, [sz-1, 1])
    if dice <= 1/2, y = y + 1;
    else x = x - 1; end
elseif isequal(p, [sz, sz]-1)
    if dice <= 1/2, y = y - 1;
    else x = x - 1; end
elseif x == 1
    if dice <= 1/3, y = y + 1;
    elseif dice <= 2/3, y = y - 1;
    else x = x + 1; end
elseif x == sz-1
    if dice <= 1/3, y = y + 1;
    elseif dice <= 2/3, y = y - 1;
    else x = x - 1; end
elseif y == 1
    if dice <= 1/3, x = x + 1;
    elseif dice <= 2/3, x = x - 1;
    else y = y + 1; end
elseif y == sz-1
    if dice <= 1/3, x = x + 1;
    elseif dice <= 2/3, x = x - 1;
    else y = y - 1; end
else
    if dice <= 1/4, x = x - 1;
    elseif dice <= 2/4, x = x + 1;
    elseif dice <= 3/4, y = y + 1;
    else
        y = y - 1;
    end
end
function breakWall(x1, y1, x2, y2)
if x1 == x2
    plot([x1-.5 x1+.5], [mean([y1, y2]), mean([y1, y2])], 'w');
else
    plot([mean([x1, x2]), mean([x1, x2])], [y1-.5 y1+.5], 'w');
end
