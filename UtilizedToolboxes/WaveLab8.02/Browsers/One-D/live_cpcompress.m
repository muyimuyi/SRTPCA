function live_cpcompress(action)
% live_cpcompress -- Called by WLBrowser
%  Usage
%    live_cpcompress(action)
%
	global h_vertslider h_horizslider 
	global h_vertlin    h_horizline signal_name
	global wc wcsort n fig_hand3 fig_hand2 fig_hand1 Coarse QMF
	global cp bb nlevel

	% update controls
	if     strcmp(action,'vertslider'),
		f = get(h_vertslider,'value');
		thr = exp(f);
		i = max(find(wcsort > thr));
		i = max([min([n i]) 1]);
		frac = (i-1) / n;
	elseif strcmp(action,'horizslider'),
		frac = get(h_horizslider,'value');
		i = floor(1 + frac * n); 
		thr = wcsort(i);
		f   = log(thr);
	elseif strcmp(action,'halfnumber')
		frac = get(h_horizslider,'value') / 2;
		i = floor(1 + frac * n); 
		thr = wcsort(i); 
		f = log(thr);
	elseif strcmp(action,'doublenumber')
		frac = get(h_horizslider,'value') * 2;
		frac = min([frac 1]);
		i = floor(min([(1 + frac * n) n])); 
		thr = wcsort(i); 
		f = log(thr);
	elseif strcmp(action,'halfthresh')
		f = get(h_vertslider,'value');
		thr = exp(f)/2; 
		f = log(thr);
		i = max(find(wcsort > thr));
		i = max([min([n i]) 1]);
		frac = (i-1) / n;
	elseif strcmp(action,'doublethresh')
		f = get(h_vertslider,'value');
		thr = exp(f)*2;
		i = max(find(wcsort > thr));
		i = max([min([n i]) 1]);
		frac = (i-1) / n;
	end

	% update Auxiliary window

	set(h_horizslider,'value',frac);
	set(h_vertslider,'value',f);
	figure(fig_hand3);
	semilogy(wcsort); hold on;
	semilogy([i i],[wcsort(n) wcsort(1)],'r');
	semilogy([1 n],[wcsort(i) wcsort(i)],'r');
	hold off;
	title(sprintf('Sorted cp Coefficients; %s',signal_name));

	% update Transform Window	

	wct = HardThresh(wc,thr);
	figure(fig_hand2);
	subplot(212)
	plot(wct);
	title(sprintf('Coefficients above Threshold %g',thr))

	% update Reconstruction window	

	figure(fig_hand1);
	subplot(212)
	cpt   = PackBasisCoeff(bb,cp,wct);
	recon = CPSynthesis(bb,cpt,'Sine');
	plot(recon);
	title(sprintf('Reconstruction from N=%g Coefficients',i))
    
    
%   
% Part of WaveLab Version 802
% Built Sunday, October 3, 1999 8:52:27 AM
% This is Copyrighted Material
% For Copying permissions see COPYING.m
% Comments? e-mail wavelab@stat.stanford.edu
%   
    
