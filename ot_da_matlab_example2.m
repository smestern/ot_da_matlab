% Open optimal transport library 
reg_space = [1e-3, 0.1, 0.5, 1]
%load the data
x = rand(2,N)-.5;
theta = 2*pi*rand(1,N);
r = .8 + .2*rand(1,N);
y = [cos(theta).*r; sin(theta).*r];

%visualize
subplot(1,length(reg_space)+1,1)
hold on
plotp = @(x,col)plot(x(1,:)', x(2,:)', 'o', 'MarkerSize', 10, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', col, 'LineWidth', 2);
plotp(x, 'b');
plotp(y, 'r');
axis('off'); axis('equal');
title("baseline")


i=2
for reg = reg_space
    out_sample = sinkhornDa(x', y', reg)
    subplot(1,length(reg_space)+1,i)
    title("reg param " + reg) 
    hold on
    plotp = @(x,col)plot(x(1,:)', x(2,:)', 'o', 'MarkerSize', 10, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', col, 'LineWidth', 2);
    plotp(y, 'r');
    plotp(out_sample', 'b');

    axis('off'); axis('equal');
    i = i + 1;
end
hold on




