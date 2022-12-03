function dofsMinim_local = evaluate_dofsMinim_local(dofsMinim,nodesMinim,nbfn)

nodes=ceil(dofsMinim/nbfn);
directions = nbfn - (nbfn*nodes-dofsMinim);
[~,indices_local]=ismember(nodes,nodesMinim);
dofsMinim_local = nbfn*indices_local - (nbfn-directions);

end