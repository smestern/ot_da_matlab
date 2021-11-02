% Open optimal transport library 
% Have to install it to python with "python -m pip install POT"

colormap winter
optimal = py.importlib.import_module('ot');

%load the data
data = readtable('web_data.csv');
%Split by species
marm_idx = data.Species_num == 1;
macaque_idx = data.Species_num == 2;
marm_data = data{marm_idx,{'APHalfwidth', 'APAmplitude'}};
macaque_data = data{macaque_idx,{'APHalfwidth', 'APAmplitude'}};

%make them into numpy arrays
marm_np = py.numpy.array(marm_data);
macaque_np = py.numpy.array(macaque_data);
%visualize
subplot(1,2,1);
scatter([marm_data(:,1); macaque_data(:,1)], [marm_data(:,2); macaque_data(:,2)], [], marm_idx)

%Create the domain adaptation object view the functions here 
%https://pythonot.github.io/gen_modules/ot.da.html#examples-using-ot-da-basetransport
da = optimal.da.EMDLaplaceTransport();
%pass in the data and transform
%Pyargs allow you to use keyword arguments
%Xs specifies the source samples, Xt specificies the samples to be used to
%map
da.fit(pyargs('Xs',marm_np,'Xt', macaque_np));
out = da.transform(pyargs('Xs',marm_np));

%move the data back into matlab
marm_matlab = double(out);


%shifted data viz
subplot(1,2,2);

scatter([marm_matlab(:,1); macaque_data(:,1)], [marm_matlab(:,2); macaque_data(:,2)], [], marm_idx);



