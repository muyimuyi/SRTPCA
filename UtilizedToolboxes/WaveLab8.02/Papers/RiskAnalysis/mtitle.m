function [ax,h]=mtitle(text)
%
%Centers a title over a group of subplots.
%Returns a handle to the title and the handle to an axis.
% [ax,h]=mtitle(text)
%           returns handles to both the axis and the title.
% ax=mtitle(text)
%           returns a handle to the axis only.

ax=axes('Units','Normal','Position',[.1 .1 .85 .85],'Visible','off');
set(get(ax,'Title'),'Visible','on')
title(text,'FontSize',18);
if (nargout < 2)
  return
end
h=get(ax,'Title');

    
    
%   
% Part of WaveLab Version 802
% Built Sunday, October 3, 1999 8:52:27 AM
% This is Copyrighted Material
% For Copying permissions see COPYING.m
% Comments? e-mail wavelab@stat.stanford.edu
%   
    
