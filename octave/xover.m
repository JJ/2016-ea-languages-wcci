function [] = xover (ITERATIONS, MAXLENGTH)
len=16
while ( len<= MAXLENGTH )
	sol1 = rand(1, len)>.5;
	sol2 = rand(1, len)>.5;
	tic;
	for i=1:ITERATIONS,
		j = randi(len);
		h1 = [sol1(1:j),sol2((j+1):len)];
		h2 = [sol2(1:j),sol1((j+1):len)];
	end
	t = toc;
	fprintf (1, 'Octave-Vector,%d,%f\n', len, t);
        len = len*2;
endwhile

 
