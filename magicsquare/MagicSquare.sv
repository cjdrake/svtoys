// Filename: MagicSquare.sv

class MagicSquare;

    // The random Magic table
    rand int rtab[3][3];

    // The "magic sum"
    local int N = 3;
    local int M = ((N*N*N)+N)/2;

    // Convert the solution to a string
    function string to_string();
        string s = "";
        for (int i = 0; i < N; i++)
        begin
            for (int j = 0; j < N; j++)
                s = { s, $psprintf("%1d", rtab[i][j]) };
            s = { s, "\n" };
        end
        return s;
    endfunction : to_string

    // Random table constraints
    constraint rtab_con
    {
        // All entries between 1 and 9
        foreach (rtab[x,y])
            rtab[x][y] inside { [1:N*N] };

        // Unique entries
        foreach (rtab[x,y])
        foreach (rtab[i,j])
            if ((x < i) || (y < j))
                rtab[x][y] != rtab[i][j];

        // Row sums
        foreach (rtab[x,])
            (rtab[x][0] + rtab[x][1] + rtab[x][2]) == M;

        // Column sums
        foreach (rtab[,y])
            (rtab[0][y] + rtab[1][y] + rtab[2][y]) == M;

        // Diagonal sums
        (rtab[0][0] + rtab[1][1] + rtab[2][2]) == M;
        (rtab[0][2] + rtab[1][1] + rtab[2][0]) == M;
    }

endclass: MagicSquare
