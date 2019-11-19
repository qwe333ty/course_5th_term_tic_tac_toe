library work;
use work.board_utils.all;
use work.game_utils.all;

package min_max_engine_utils is

    type MinMaxAnswer is array(0 to 2) of integer;

    function getRowPoints(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); row : natural)
    return Available_Cells;

    function getColumnPoints(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); column : natural)
    return Available_Cells;

    function getLeftDiagonalPoints(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1))
    return Available_Cells;

    function getRightDiagonalPoints(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1))
    return Available_Cells;

    function evaluateAvailableCells(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); cells : Available_Cells)
    return integer;

    function evaluateBoard(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1))
    return integer;

end package min_max_engine_utils;

package body min_max_engine_utils is

    function getRowPoints(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); row : natural)
    return Available_Cells is

        variable cells : Available_Cells;

        begin
            for column in 0 to (BOARD_SIZE - 1) loop
                cells(column) := (row, column);
            end loop;
        return cells;
    end;

    function getColumnPoints(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); column : natural)
    return Available_Cells is

        variable cells : Available_Cells;

        begin
            for row in 0 to (BOARD_SIZE - 1) loop
                cells(row) := (row, column);
            end loop;
        return cells;
    end;

    function getLeftDiagonalPoints(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1))
    return Available_Cells is

        variable cells : Available_Cells;
        
        begin
            for temp in 0 to (BOARD_SIZE - 1) loop
                cells(temp) := (temp, temp);
            end loop;
        return cells;
    end;

    function getRightDiagonalPoints(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1))
    return Available_Cells is

        variable cells : Available_Cells;

        begin
            for temp in 0 to (BOARD_SIZE - 1) loop
                cells(temp) := (temp, (BOARD_SIZE - 1) - temp);
            end loop;
        return cells;
    end;

    function evaluateAvailableCells(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); cells : Available_Cells)
    return integer is

        variable score : integer := 0;
        variable coordinates : Cell_Coordinates;

        begin
            evaluation_loop: for temp in 0 to (BOARD_SIZE - 1) loop
                coordinates := cells(temp);

                if temp = 0 then
                    if game_board(coordinates(0), coordinates(1)) = AI_PLAYER then
                        score := 1;
                    elsif game_board(coordinates(0), coordinates(1)) = HUMAN_PLAYER then
                        score := -1;
                    end if;

                    next evaluation_loop;
                end if;

                if game_board(coordinates(0), coordinates(1)) = AI_PLAYER then
                    if score > 0 then
                        score := score * 10;
                    elsif score < 0 then
                        return 0;
                    else
                        score := 1;
                    end if;
                elsif game_board(coordinates(0), coordinates(1)) = HUMAN_PLAYER then
                    if score < 0 then
                        score := score * 10;
                    elsif score >= 1 then
                        return 0;
                    else
                        score := -1;
                    end if;
                end if;
            end loop evaluation_loop;
        return score;
    end;        

    function evaluateBoard(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1))
    return integer is

        variable score : integer := 0;
        variable cells : Available_Cells;

        begin
            for row in 0 to (BOARD_SIZE - 1) loop
                cells := getRowPoints(game_board, row);
                score := score + evaluateAvailableCells(game_board, cells);
            end loop;

            for column in 0 to (BOARD_SIZE - 1) loop
                cells := getColumnPoints(game_board, column);
                score := score + evaluateAvailableCells(game_board, cells);
            end loop;

            cells := getLeftDiagonalPoints(game_board);
            score := score + evaluateAvailableCells(game_board, cells);

            cells := getRightDiagonalPoints(game_board);
            score := score + evaluateAvailableCells(game_board, cells);
        return score;
    end;

end package body min_max_engine_utils;