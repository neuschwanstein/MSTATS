%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                                              
%                                                                    
% Linear interpolation of F at point S. 
%  
%                                          
%                                                                    
%
%
%      Inputs  
%               S: points of interpolation (n x 1 vector)
%               F: values of function F at grid points (m x 1 vector)
%               minS: minimum value of asset price for the grid
%               maxS: maximum value of asset price for the grid
%
%                 
%               
%      Output  
%              Fint: F interpolated at S
%     
%
% Bruno Remillard, November 2nd, 2010 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
function Fint = interpolation_1d(S,F,minS,maxS)
 
    Fint = interpolation_1d_m(S,F,minS,maxS);


      
     
