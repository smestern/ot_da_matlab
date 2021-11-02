
%% Requires domain adaptation toolbox: 
%https://www.mathworks.com/matlabcentral/fileexchange/56704-a-domain-adaptation-toolbox
%%load the data
colormap winter
data = readtable('web_data.csv');
%Split by species
marm_idx = data.Species_num == 1;
macaque_idx = data.Species_num == 2;
marm_data = normalize(data{marm_idx,{'APHalfwidth', 'APAmplitude'}});
macaque_data = normalize(data{macaque_idx,{'APHalfwidth','APAmplitude'}});

%visualize
subplot(1,2,1);
scatter([marm_data(:,1); macaque_data(:,1)], [marm_data(:,2); macaque_data(:,2)], [], marm_idx)

%% try domain adapt toolbox
subplot(1,2,2);
matlab_domain = vertcat(marm_data, macaque_data);
%These are from the domain adaptation toolbox.
%First argument is the matrix of features, second argument defines the
%source, and target samples (1 = source, 0= target). third argument is the
%labels ([] is unsupervised). Fourth argument is a mask for the labels (in
%unsupervised its the same as the second). Final argument is custom params,
%but default seems to work.
param = []; param.dr = 0;
new_data = ftTrans_gfk(matlab_domain, marm_idx, [], marm_idx, param);
scatter(new_data(:,1), new_data(:,2), [], marm_idx);




