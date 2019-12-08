library ieee;
use ieee.std_logic_1164.all;

library work;
use work.game_utils.all;
use work.board_utils.all;
use work.min_max_engine_utils.all;

entity AI is
    port(X : in natural;
         Y : in natural;
         isHuman: in boolean;
         current_board : out Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1);
         humanWon : out boolean;
         aiWon : out boolean;
         nooneWon : out boolean);
end AI;

architecture AI_behaviour of AI is

    signal game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1);
    signal isHumanInternal : boolean := true;

    begin
        main_process : process (X, Y, game_board, isHumanInternal, isHuman)
            variable answer : MinMaxAnswer;
            variable cellList : Available_Cells;
            begin
                
                if isHuman = isHumanInternal then
                    if isHuman then
                        game_board(Y, X) <= HUMAN_PLAYER;
                        current_board <= game_board;
                    else
                        answer := min_max_move(game_board, (BOARD_SIZE - 1), AI_PLAYER);
                        if answer(1) = -1 or answer(2) = -1 then
                            null;
                        else
                            game_board(answer(1), answer(2)) <= AI_PLAYER;     
                        end if;

                        current_board <= game_board;
                    end if;

                    isHumanInternal <= not isHumanInternal;
                else
                    if hasWon(game_board, AI_PLAYER) then
                        aiWon <= true;
                        humanWon <= false;
                        nooneWon <= false;
                        report "AI player won";
                    elsif hasWon(game_board, HUMAN_PLAYER) then
                        aiWon <= false;
                        humanWon <= true;
                        nooneWon <= false;
                        report "Human player won";
                    else
                        cellList := generateMoves(game_board);
                        if isCellsListEmpty(cellList) then
                            aiWon <= false;
                            humanWon <= false;
                            nooneWon <= true;
                            report "No one won";
                        else
                            aiWon <= false;
                            humanWon <= false;
                            nooneWon <= false;
                        end if;
                    end if;
                    current_board <= game_board;
                end if;
        end process main_process;
end AI_behaviour;