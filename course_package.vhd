package game_utils is

    constant BOARD_SIZE : natural := 3;

    type CELL_STATE is (EMPTY, CROSS, ZERO);

    type Board is array(natural range <>, natural range <>) of CELL_STATE;

    constant HUMAN_PLAYER : CELL_STATE := ZERO;

    constant AI_PLAYER : CELL_STATE := CROSS;

    type Engine_Answer is record
        Y : natural;
        X : natural;
    end record Engine_Answer;

    constant Engine_Answer_const : Engine_Answer := (Y => 0, X => 0);

end package game_utils;
