function skeletonplot(xdata,ydata,newtitle,newlabelx,newlabely)    
     
%  xdata:  vector of xaxis data
%  ydata:  vector of yaxis data; if no ydata use length(xdata) as ydata input

%  the default MatLab axis is aesthetically inferior because it plots points

%on the figure edges.  Here we will force the axes beyond all data points.

   xrange = max(xdata) - min(xdata)	%max( ) and min( ) are MatLab functions.
   yrange = max(ydata) - min(ydata)
   
todaysdate = date;			%date is MatLab command

%% Create figure
figure1 = figure('color',[1,1,1]);	%replace MatLab’s gray border with white
colormap gray 

%% Create axes
axes1 = axes('Parent',figure1);
axis(axes1,[min([xdata-0.05,0]) (max(xdata) + 0.025*xrange) min([ydata,0]) (max(ydata)+.025*yrange)]);
title(axes1,newtitle);
xlabel(axes1,newlabelx);
ylabel(axes1,newlabely);
box(axes1,'on');
hold(axes1,'all');
 
%% Create plot
plot1 = plot(xdata,ydata)
 
%% Create textbox
annotation1 = annotation(...
  figure1,'textbox',...
  'Position',[0.6643 0.9405 0.308 0.07024],...
  'LineStyle','none',...
  'String',{['Rachel Kay' todaysdate]},...		
  'FitHeightToText','on');
 
