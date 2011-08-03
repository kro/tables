install:
	cabal install --prefix=$(HOME) --user
.PHONY: install

clean:
	cabal clean
.PHONY: clean
