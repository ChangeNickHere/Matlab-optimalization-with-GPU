function [lambda, mu, K]=convert_from_E_nu(E,nu)
lambda=E*nu/(1+nu)/(1-2*nu);  
mu= E/2/(1+nu); 
K=E/(1-2*nu)/3;     %or K=lambda+2*mu/3
end 
