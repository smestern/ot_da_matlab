% Open optimal transport library 
colormap winter

%load the data
data = readtable('web_data.csv');
%Split by species
marm_idx = data.Species_num == 1;
macaque_idx = data.Species_num == 2;
marm_data = normalize(data{marm_idx,{'APHalfwidth', 'APAmplitude', 'Rheobase'}});
macaque_data = normalize(data{macaque_idx,{'APHalfwidth', 'APAmplitude', 'Rheobase'}});

%visualize
subplot(1,2,1);
scatter3([marm_data(:,1); macaque_data(:,1)], [marm_data(:,2); macaque_data(:,2)], [marm_data(:,3); macaque_data(:,3)], [], marm_idx)

out_sample = sinkhornDa(marm_data, macaque_data)

subplot(1,2,2);
scatter3([out_sample(:,1); macaque_data(:,1)], [out_sample(:,2); macaque_data(:,2)], [out_sample(:,3); macaque_data(:,3)], [], marm_idx)





