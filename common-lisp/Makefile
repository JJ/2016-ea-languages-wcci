all: onemax.fasl bitflip.fasl xover.fasl

%.fasl: %.lisp
	sbcl --noinform --eval "(compile-file \"$<\")" --eval "(quit)" > /dev/null

