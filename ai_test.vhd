library ieee;
use ieee.std_logic_1164.all;

library work;
use work.game_utils.all;
use work.board_utils.all;
use work.min_max_engine_utils.all;

entity Test_Func is
    port (game_board : in Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); 
          depth : in natural;
          player : in CELL_STATE;
          ai_answer : out MinMaxAnswer);
end Test_Func;

architecture Test_Func_Behaviour of Test_Func is
    begin
        ai_answer <= min_max_move(game_board, depth, player);
end Test_Func_Behaviour;

---
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.game_utils.all;
use work.board_utils.all;
use work.min_max_engine_utils.all;

entity Test_Entity is
end Test_Entity;

architecture Test_Entity_Behaviour of Test_Entity is
    component Test_Func
        port (game_board : in Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1); 
              depth : in natural;
              player : in CELL_STATE;
              ai_answer : out MinMaxAnswer);
    end component;

    signal depth : natural;
    signal player : CELL_STATE;
    signal ai_answer : MinMaxAnswer;
    signal game_board : Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1);


    begin
        Function_check: Test_Func port map(
            game_board => game_board,
            depth => depth,
            player => player,
            ai_answer => ai_answer);
        
        depth <= (BOARD_SIZE - 1);

        player <= AI_PLAYER;

        game_board <= ((ZERO, ZERO, CROSS), 
                       (EMPTY, CROSS, EMPTY),
                       (EMPTY, EMPTY, ZERO)),

                      ((EMPTY, EMPTY, EMPTY),
                       (CROSS, ZERO, EMPTY),
                       (ZERO, EMPTY, EMPTY)) after 100 ns,

                      ((EMPTY, EMPTY, CROSS),
                       (CROSS, ZERO, EMPTY),
                       (ZERO, EMPTY, ZERO)) after 200 ns,

                      ((EMPTY, ZERO, EMPTY),
                       (EMPTY, ZERO, EMPTY),
                       (ZERO, CROSS, CROSS)) after 300 ns;

end Test_Entity_Behaviour;