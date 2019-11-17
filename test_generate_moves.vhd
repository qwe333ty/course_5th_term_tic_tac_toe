library work;
use work.board_utils.all;

library work;
use work.game_utils.all;

entity Test123 is
    port(game_board : in Board(0 to BOARD_SIZE - 1, 0 to BOARD_SIZE - 1) := ((EMPTY, EMPTY, EMPTY), (EMPTY, CROSS, EMPTY), (EMPTY, EMPTY, EMPTY));
         cells : out Available_Cells);
end Test123;

architecture qwe of Test123 is

    begin
        cells <= generateMoves(game_board);
end qwe;