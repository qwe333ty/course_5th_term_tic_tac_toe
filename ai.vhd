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
    component MinMaxEngine
        port(game_board : in Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1);
             answer : out Engine_Answer := Engine_Answer_const);
    end component;

    signal game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1);
    signal answer : Engine_Answer;

    begin

        call_engine: MinMaxEngine port map(
            game_board => game_board,
            answer => answer);
        game_board(answer.Y, answer.X) <= AI_PLAYER;

        current_board <= game_board;
end AI_behaviour;