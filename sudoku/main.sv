// Filename: main.sv

typedef class Sudoku;

program main();

    initial
    begin
        string fname;
        int r, file;
        int tab[9][9] = '{default:0};

        Sudoku solver = new();

        if (!$value$plusargs("INPUT=%s", fname)) begin
            $write("ERROR: no input table given\n");
            $finish();
        end

        file = $fopen(fname, "r");

        if (file)
            foreach (tab[i,j])
                r = $fscanf(file, "%1d", tab[i][j]);
        else begin
            $write("ERROR: could not open input table\n");
            $finish();
        end

        if (solver.xsolve(tab) == 0) begin
            $write("ERROR: Sudoku table is unsolvable!\n");
            $finish();
        end
        else begin
            $write(solver.to_string(tab));
            file = $fopen("output", "w");
            for (int i = 0; i < 9; i++) begin
                for (int j = 0; j < 9; j++) begin
                    $fwrite(file, "%1d", solver.rtab[i][j]);
                end
            end
        end

        $finish();
    end

endprogram: main
