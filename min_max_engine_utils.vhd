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

    function min_max_move(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); depth : natural; player : CELL_STATE)
    return MinMaxAnswer;

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

                if temp = 1 then
                    if game_board(coordinates(0), coordinates(1)) = AI_PLAYER then
                        if score = 1 then
                            score := 10;
                        elsif score = -1 then
                            return 0;
                        else
                            score := 1;
                        end if;
                    elsif game_board(coordinates(0), coordinates(1)) = HUMAN_PLAYER then
                        if score = -1 then
                            score := -10;
                        elsif score = 1 then
                            return 0;
                        else
                            score := -1;
                        end if;
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
                    elsif score > 1 then
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

    function min_max_move(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); depth : natural; player : CELL_STATE)
    return MinMaxAnswer is

        variable nextMoves : Available_Cells;
        variable move : Cell_Coordinates;

        variable bestScore : integer;

        variable bestRow : integer := -1;
        variable bestColumn : integer := -1;

        variable tempAnswer : MinMaxAnswer;
        variable answer : MinMaxAnswer;

        variable boardCopy : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1);

        begin
            nextMoves := generateMoves(game_board);

            if player = AI_PLAYER then
                bestScore := integer'low;
            else
                bestScore := integer'high;
            end if;

            if isCellsListEmpty(nextMoves) or depth = 0 then
                bestScore := evaluateBoard(game_board);
            else
                boardCopy := cloneGameBoard(game_board);
                for temp in 0 to (nextMoves'length - 1) loop
                    move := nextMoves(temp);
                    if move(0) = -1 and move(1) = -1 then
                        exit;
                    end if;
                    
                    boardCopy(move(0), move(1)) := player;
                    if player = AI_PLAYER then
                        tempAnswer := min_max_move(boardCopy, depth - 1, HUMAN_PLAYER);
                        if tempAnswer(0) > bestScore then
                            bestScore := tempAnswer(0);
                            bestRow := move(0);
                            bestColumn := move(1);
                        end if;
                    else
                        tempAnswer := min_max_move(boardCopy, depth - 1, AI_PLAYER);
                        if tempAnswer(0) < bestScore then
                            bestScore := tempAnswer(0);
                            bestRow := move(0);
                            bestColumn := move(1);
                        end if;
                    end if;
                    boardCopy(move(0), move(1)) := EMPTY;
                end loop;
            end if;

            answer(0) := bestScore;
            answer(1) := bestRow;
            answer(2) := bestColumn;
        return answer;
    end;

end package body min_max_engine_utils;