library ieee;
use ieee.std_logic_1164.all;

library work;
use work.game_utils.all;
use work.board_utils.all;
use work.min_max_engine_utils.all;

entity MinMaxEngine is
    port(game_board : in Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1);
         human_x : in natural;
         human_y : in natural;
         answer : out MinMaxAnswer := (0, -1, -1);
         output_board : out Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1));
end MinMaxEngine;

architecture MinMaxEngine_behaviour of MinMaxEngine is
    
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

    begin
        answer <= min_max_move(game_board, BOARD_SIZE - 1, AI_PLAYER);
end MinMaxEngine_behaviour;