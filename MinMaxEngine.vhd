library ieee;
use ieee.std_logic_1164.all;

library work;
use work.game_utils.all;

entity MinMaxEngine is
    port(game_board : in Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1);
         answer : out Engine_Answer := Engine_Answer_const);
end MinMaxEngine;

architecture MinMaxEngine_behaviour of MinMaxEngine is

    begin
end MinMaxEngine_behaviour;