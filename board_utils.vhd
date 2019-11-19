library work;
use work.game_utils.all;

package board_utils is

    type Cell_Coordinates is array(0 to 1) of integer range -1 to (BOARD_SIZE - 1);

    type Available_Cells is array(0 to ((BOARD_SIZE * BOARD_SIZE) - 1)) of Cell_Coordinates;

    function checkColumn(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); column : natural; player : CELL_STATE)
    return boolean;

    function checkAllColumns(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); player : CELL_STATE)
    return boolean;

    function checkLine(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); row : natural; player : CELL_STATE)
    return boolean;

    function checkAllLines(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); player : CELL_STATE)
    return boolean;

    function checkLeftDiagonal(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); player : CELL_STATE)
    return boolean;

    function checkRightDiagonal(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); player : CELL_STATE)
    return boolean;

    function hasWon(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); player : CELL_STATE)
    return boolean;

    function generateMoves(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1))
    return Available_Cells;

    function isCellsListEmpty(cells : Available_Cells)
    return boolean;

    function cloneGameBoard(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1))
    return Board;

end package board_utils;

package body board_utils is

    function checkColumn(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); column : natural; player : CELL_STATE)
    return boolean is
        begin
            for row in 1 to (BOARD_SIZE - 1) loop
                if game_board(row, column) /= game_board((row - 1), column) then
                    return false;
                end if;

                if row = (BOARD_SIZE - 1) and game_board(row, column) = player then
                    return true;
                end if;
            end loop;
        return false;
    end;

    function checkAllColumns(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); player : CELL_STATE)
    return boolean is
        begin
            for column in 0 to (BOARD_SIZE - 1) loop
                if checkColumn(game_board, column, player) then
                    return true;
                end if;
            end loop;
        return false;
    end;

    function checkLine(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); row : natural; player : CELL_STATE)
    return boolean is
        begin
            for column in 1 to (BOARD_SIZE - 1) loop
                if game_board(row, column) /= game_board(row, (column - 1)) then
                    return false;
                end if;

                if column = (BOARD_SIZE - 1) and game_board(row, column) = player then
                    return true;
                end if;    
            end loop;
        return false;
    end;
    
    function checkAllLines(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); player : CELL_STATE)
    return boolean is
        begin
            for row in 0 to (BOARD_SIZE - 1) loop
                if checkLine(game_board, row, player) then
                    return true;
                end if;
            end loop;
        return false;
    end;

    function checkLeftDiagonal(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); player : CELL_STATE)
    return boolean is
        begin
            for temp in 1 to (BOARD_SIZE - 1) loop
                if game_board(temp, temp) /= game_board((temp - 1), (temp - 1)) then
                    return false;
                end if;

                if temp = (BOARD_SIZE - 1) and game_board(temp, temp) = player then
                    return true;
                end if;
            end loop;
        return false;
    end;

    function checkRightDiagonal(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); player : CELL_STATE)
    return boolean is
        begin
            for temp in 1 to (BOARD_SIZE - 1) loop
                if game_board((BOARD_SIZE - 1 - temp), temp) /= game_board((BOARD_SIZE - temp), (temp - 1)) then
                    return false;
                end if;

                if temp = (BOARD_SIZE - 1) and game_board((BOARD_SIZE - 1 - temp), temp) = player then
                    return true;
                end if;
            end loop;
        return false;
    end;

    function hasWon(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); player : CELL_STATE)
    return boolean is
        begin
        return checkAllColumns(game_board, player) or
               checkAllLines(game_board, player) or
               checkLeftDiagonal(game_board, player) or
               checkRightDiagonal(game_board, player);
    end;

    function generateMoves(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1))
    return Available_Cells is

        variable counter : natural := 0;
        variable cells : Available_Cells;

        begin
            if hasWon(game_board, HUMAN_PLAYER) or hasWon(game_board, AI_PLAYER) then
                report "someone won";
                return cells;
            end if;

            rows: for row in 0 to (BOARD_SIZE - 1) loop
                columns: for column in 0 to (BOARD_SIZE - 1) loop
                    if game_board(row, column) = EMPTY then
                        cells(counter) := (row, column);
                        counter := counter + 1;
                    end if;
                end loop columns;
            end loop rows;
        return cells;
    end;

    function isCellsListEmpty(cells : Available_Cells)
    return boolean is
        begin
            if cells(0)(0) = -1 and cells (0)(1) = -1 then
                return true;
            else
                return false;
            end if;
    end;

    function cloneGameBoard(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1))
    return Board is

        variable boardCopy : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1);

        begin
            for row in 0 to BOARD_SIZE - 1 loop
                for column in 0 to BOARD_SIZE - 1 loop
                    boardCopy(row, column) := game_board(row, column);
                end loop;
            end loop;
        return boardCopy;
    end;    

end package body board_utils;