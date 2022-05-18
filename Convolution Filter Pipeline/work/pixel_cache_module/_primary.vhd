library verilog;
use verilog.vl_types.all;
entity pixel_cache_module is
    generic(
        N               : integer := 32
    );
    port(
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        data_load       : in     vl_logic;
        data_i          : in     vl_logic_vector(7 downto 0);
        window          : out    vl_logic_vector(8 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end pixel_cache_module;
