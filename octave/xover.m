function [] = xover (ITERATIONS, MAXLENGTH)

for len=16:MAXLENGTH,
	sol1 = rand(1, len)>.5;
	sol2 = rand(1, len)>.5;
	tic;
	for i=1:ITERATIONS,
		j = randi(len);
		h1 = [sol1(1:j),sol2((j+1):len)];
		h2 = [sol2(1:j),sol1((j+1):len)];
	end
	t = toc;
	fprintf (1, '%d\t%f\n', len, t/ITERATIONS);
end

 
