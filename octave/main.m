ITERATIONS = 100000;
MAXLENGTH = 32768;


disp('Mutation');
mutationBitFlip(ITERATIONS, MAXLENGTH);

disp('onemax')
onemax(ITERATIONS, MAXLENGTH);

disp('xover')
xover(ITERATIONS, MAXLENGTH);
