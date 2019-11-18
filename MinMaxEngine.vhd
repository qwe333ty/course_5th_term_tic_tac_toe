library ieee;
use ieee.std_logic_1164.all;

library work;
use work.game_utils.all;
use work.board_utils.all;
use work.min_max_engine_utils.all;

entity MinMaxEngine is
    port(game_board : in Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1);
         answer : out Engine_Answer := Engine_Answer_const);
end MinMaxEngine;

architecture MinMaxEngine_behaviour of MinMaxEngine is
    
    function min_max_step(game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); depth : natural; player : CELL_STATE)
    return Cell_Coordinates is
        begin
    end;

    begin
end MinMaxEngine_behaviour;