function densities = densityGradientVector_2D_linear(F,params)
eNormSquare = (F{1,1}-1).^2 + (F{2,2}-1).^2 + (1/2)*(F{1,2}+F{2,1}).^2;
eTraceSquare = (F{1,1}+F{2,2}-2).^2;
densities = (params.mus).*eNormSquare + (params.lambdas/2).*eTraceSquare;
end
