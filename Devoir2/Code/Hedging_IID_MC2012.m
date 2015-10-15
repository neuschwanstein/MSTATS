%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                                              
%                                                                    
% Generates functions   C and a at points S. 
% See document hedging_formulas.pdf 
%                                          
%                                                                    
%
%
%      Inputs  
%               R: vector of length N of excess returns for the simulation
%               T: time (years) to maturity ; 1 year = 252 days ; 1 month  = 21 days 
%               K: strike price                  
%               r: annual  interest rate 
%               n: number of hedging periods
%               put: 1 if put, 0 if call
%               minS: minimum value of asset price for the grid
%               maxS: maximum value of asset price for the grid
%               m: number of points in the grid
%
%                 
%               
%      Output  
%              S: points of interpolation of asset price
%              C: discounted value of the options at discounted prices S (C check)
%              a: discounted value of a at discounted prices S  
%              c1: constant necessary for optimal hedging
%     
%
% Bruno Remillard, November 2nd, 2010 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
function [S,C,a,c1,phi1] = Hedging_IID_MC2012(R,T,K,r,n,put,minS,maxS,m)
 
    [S,C,a,c1] = Hedging_IID_MC_m2012(R,T,K,r,n,put,minS,maxS,m);
    phi1 = (a(1,:) - C(1,:)*c1)'./S;


      
     