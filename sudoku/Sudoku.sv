// Filename: Sudoku.sv

class Sudoku #(int N = 3);

    // The random Sudoku table
    rand int rtab[N**2][N**2];

    // Helper arrays
    local int box[N-1];

    // Find the solution
    function int xsolve(int tab[N**2][N**2]);
        return randomize() with {
                   foreach (rtab[i,j])
                       (tab[i][j] != 0) -> (rtab[i][j] == tab[i][j]);
               };
    endfunction: xsolve

    // Convert the solution to a string
    function string to_string(int tab[N**2][N**2]);
        string s = { {N{"+", {N{"-"}} }}, "+ ", {N{"+", {N{"-"}} }}, "+\n" };
        for (int i = 0; i < N**2; i++)
        begin
            s = { s, "|" };
            for (int j = 0; j < N**2; j++)
            begin
                s = { s, $psprintf("%1d", tab[i][j]) };
                if (j % N == (N-1)) s = { s, "|" };
                if (j == (N**2-1))  s = { s, " " };
            end

            s = { s, "|" };
            for (int j = 0; j < N**2; j++)
            begin
                s = { s, $psprintf("%1d", rtab[i][j]) };
                if (j % N == (N-1)) s = { s, "|" };
                if (j == (N**2-1))  s = { s, "\n" };
            end
            if (i % N == (N-1))
                s = { s, { {N{"+", {N{"-"}} }}, "+ "}, { {N{"+", {N{"-"}} }}, "+\n"} };
        end
        return s;
    endfunction: to_string

    // Random table constraints
    constraint con_rtab
    {
        // All entries between 1 and N^2
        foreach (rtab[i,j])
            rtab[i][j] inside { [1:N**2] };

        // Unique rows
        foreach (rtab[i,j])
        foreach (rtab[,k])
            if (j < k)
                rtab[i][j] != rtab[i][k];

        // Unique colums
        foreach (rtab[i,j])
        foreach (rtab[k,])
            if (i < k)
                rtab[i][j] != rtab[k][j];

        // Unique NxN
        foreach (rtab[i,j])
        foreach (box[x])
        foreach (box[y])
            rtab[i][j] != rtab[i-i%N+(i+x+1)%N][j-j%N+(j+y+1)%N];
    }

endclass: Sudoku
