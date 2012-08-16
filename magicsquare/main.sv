// Filename: main.sv

typedef class MagicSquare;

program test();

    initial
    begin
        MagicSquare square = new();

        for (int i = 0; i < 10; i++)
            if (square.randomize() == 0)
                $write("Magic square is unsolvable!\n");
            else
                $write("%s\n", square.to_string());
    end

endprogram : test
