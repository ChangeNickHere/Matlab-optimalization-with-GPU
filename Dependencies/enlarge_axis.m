function ax_new=enlarge_axis(alpha1,alpha2,alpha3)
%works in both 2D/3D and in both linear and logarithmic scales    

ax=axis;
if numel(ax)==4          % 2D case
   is_2D=1; alpha3=0;      
   ax=[ax 1 1];
   if nargin==0
      alpha1=0.05; alpha2=0.05;
   end
else                     % 3D case
    is_2D=0; 
    if nargin==0
      alpha1=0.05; alpha2=0.05; alpha3=0.05; 
    end
end

if strcmp(get(gca,'XScale'),'log')     
    ax(1)=log10(ax(1));
    ax(2)=log10(ax(2));    
end
if strcmp(get(gca,'YScale'),'log')     
    ax(3)=log10(ax(3));
    ax(4)=log10(ax(4));    
end
if strcmp(get(gca,'ZScale'),'log')     
    ax(5)=log10(ax(5));
    ax(6)=log10(ax(6));    
end

ax_new=ax*[[1+alpha1 -alpha1; -alpha1 1+alpha1], zeros(2), zeros(2); ...
           zeros(2), [1+alpha2 -alpha2; -alpha2 1+alpha2], zeros(2); ...
           zeros(2), zeros(2), [1+alpha3 -alpha3; -alpha3 1+alpha3]  ...
           ];

if strcmp(get(gca,'XScale'),'log')
    ax_new(1)=10^ax_new(1);
    ax_new(2)=10^ax_new(2);       
end
if strcmp(get(gca,'YScale'),'log')
    ax_new(3)=10^ax_new(3);
    ax_new(4)=10^ax_new(4);       
end
if strcmp(get(gca,'ZScale'),'log')
    ax_new(3)=10^ax_new(5);
    ax_new(4)=10^ax_new(6);       
end

if is_2D
   ax_new=ax_new(1:4);
end

axis(ax_new);
end