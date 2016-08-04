function theta=adjustAngle(theta)
% ensures that the angle is between -pi and pi
% if numel(theta)==1
%    if isinf(theta)
%        return;
%    end
%    if(theta>pi)
%        theta=(theta-floor(theta/pi)*pi)-pi;
%    elseif theta<-pi
%        theta=pi-(-theta-floor(-theta/pi)*pi);
%    end    
% else
%     theta(~isinf(theta) && theta>pi)=(theta(~isinf(theta) && theta>pi)...
%         -floor(theta(~isinf(theta) && theta>pi)/pi)*pi)-pi;
%     
%     theta(~isinf(theta) && theta<-pi)=pi-(-theta(~isinf(theta) && theta<-pi)...
%         -floor(-theta(~isinf(theta) && theta<-pi)/pi)*pi);
    theta=theta+pi;
    theta=theta-(2*pi).*floor(theta./(2*pi));    
    theta=theta-pi;
    theta(isnan(theta))=-inf;    
% end
end