# Filename: Makefile

NUKE := rm -rf

# Synopsys VCS
VCS := vcs
VCS_FLAGS := -sverilog

BLD_DIR := bld

default: test

$(BLD_DIR):
	@mkdir $@

$(BLD_DIR)/sudoku: sudoku/Sudoku.sv sudoku/main.sv | $(BLD_DIR)
	@cd $(BLD_DIR) && ( \
        $(VCS) $(VCS_FLAGS) -o $(notdir $@) $(addprefix ../,$^) \
    )

$(BLD_DIR)/magicsquare: magicsquare/MagicSquare.sv magicsquare/main.sv | $(BLD_DIR)
	@cd $(BLD_DIR) && ( \
        $(VCS) $(VCS_FLAGS) -o $(notdir $@) $(addprefix ../,$^) \
    )

.PHONY: test_sudoku
test_sudoku: $(BLD_DIR)/sudoku
	@cd $(BLD_DIR) && ( \
        ./$(notdir $<) +INPUT=../sudoku/test/input.0; \
        diff -w output ../sudoku/test/output.0 \
    )

.PHONY: test_magicsquare
test_magicsquare: $(BLD_DIR)/magicsquare
	@cd $(BLD_DIR) && ( \
        ./$(notdir $<) \
    )

.PHONY: clean
clean:
	@$(NUKE) $(BLD_DIR)
