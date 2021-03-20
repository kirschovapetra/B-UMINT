function [ans_fit,ans_b1,ans_b2,ans_b3,ans_b4] = count_debug(x1,x2,x3,x4,x5)
    ans_fit = 0.04*x1+0.07*x2+0.11*x3+0.06*x4+0.05*x5;
    ans_b1 = x1+x2+x3+x4+x5-10;
    ans_b2 = x1+x2-2.5;
    ans_b3 = -x4+x5;
    ans_b4 = -0.5*x1-0.5*x2+0.5*x3+0.5*x4-0.5*x5;
end

