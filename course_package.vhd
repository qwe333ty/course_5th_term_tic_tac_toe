package game_utils is

    constant BOARD_SIZE : natural := 3;

    type CELL_STATE is (EMPTY, CROSS, ZERO);

    type Board is array(natural range <>, natural range <>) of CELL_STATE;

    constant HUMAN_PLAYER : CELL_STATE := ZERO;

    constant AI_PLAYER : CELL_STATE := CROSS;

end package game_utils;
