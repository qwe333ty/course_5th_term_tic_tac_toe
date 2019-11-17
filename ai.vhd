library ieee;
use ieee.std_logic_1164.all;

library work;
use work.game_utils.all;

entity AI is
    port(X : in natural;
         Y : in natural;
         current_board : out Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1));
end AI;

architecture AI_behaviour of AI is

    signal game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1) := (
        (EMPTY, EMPTY, EMPTY),
        (EMPTY, EMPTY, EMPTY),
        (EMPTY, EMPTY, EMPTY)
    );

    begin
        game_board(Y, X) <= HUMAN_PLAYER;
        current_board <= game_board;
end AI_behaviour;