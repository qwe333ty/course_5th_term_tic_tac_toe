library ieee;
use ieee.std_logic_1164.all;

library work;
use work.game_utils.all;
use work.board_utils.all;
use work.min_max_engine_utils.all;

entity Test123 is
end Test123;

architecture beh of Test123 is
    component AI 
        port(X : in natural;
             Y : in natural;
             current_board : out Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1));
    end component;

    signal game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1);
    signal X : natural;
    signal Y : natural;

    begin
        qwe: AI port map(current_board => game_board, X => X, Y => Y);

end beh;