function histbar(range_min,range_max,newdata,numbins,newtitle)

% histbar() will produce a histogram with number of bins 
%   equal to numbin and using newdata
% also prints current date  
% range_min and range_max are the left and right edge of the smallest and 
% largest bin on the figure
% newdata is a vector
% numbins is an integer greater than one
% newtitle is a string
% example call from command line:
%   >> histbar(-.005,1.005,data,20,'The Title')
% where data is a vector and 20 specifies the number of bins

%% Create figure and color the surround white
figure1 = figure('color',[1,1,1]);  % both the colormap and the color [1,1,1]
colormap gray                       % must be specified

%% Create axes and labels

axes1 = axes(...
  'FontName','lucida',...
  'FontWeight','bold',...
              'Parent',figure1);
title(axes1,newtitle);
xlabel(axes1,'Bin Location');
ylabel(axes1,'Bin Count');
box(axes1,'on');
hold(axes1,'all');
 
%% Create histogram and get some facts about the bins

  [all_bin_values,jtt] = hist(newdata,numbins);
  largest_bin_value = max(all_bin_values);
  
  bar(jtt,all_bin_values)             

% move vertical edges of fig away from end bars

fullrange=range_max-range_min;         % find out where the smallest and
leftvert=range_min-.02*fullrange;      % possible values could be and 
rightvert=range_max+.02*fullrange;     % move 2 percent of the range away

% adjust the top of the box to be 10 percent above largest bin value

axis(axes1,...
    [leftvert,rightvert, 0, 1.1 * largest_bin_value]);   

%% Create textbox of name and date
annotation1 = annotation(...
  figure1,'textbox',...
  'Position',[0.6643 0.9405 0.308 0.07024],...
  'LineStyle','none',...
  'String',{['Rachel Kay ' date]},...   
  'FitHeightToText','on');

%% shade the bars using the current colormap

caxis([0.2,1.2])          
