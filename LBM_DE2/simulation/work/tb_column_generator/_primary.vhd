library verilog;
use verilog.vl_types.all;
entity tb_column_generator is
    generic(
        GRID_DIM        : integer := 16;
        ADDRESS_WIDTH   : vl_notype;
        CLK_PERIOD      : integer := 20
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of GRID_DIM : constant is 1;
    attribute mti_svvh_generic_type of ADDRESS_WIDTH : constant is 3;
    attribute mti_svvh_generic_type of CLK_PERIOD : constant is 1;
end tb_column_generator;
