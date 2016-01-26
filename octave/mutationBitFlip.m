function [] = mutationBitFlip (ITERATIONS, MAXLENGTH)

for len=16:MAXLENGTH,
	sol = rand(1, len)>.5;
	tic;
	for i=1:ITERATIONS,
		j = randi(len);
		sol(j) = 1 - sol(j);
	end
	t = toc;
	fprintf (1, '%d\t%f\n', len, t/ITERATIONS);
end

 
