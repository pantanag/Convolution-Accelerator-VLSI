library verilog;
use verilog.vl_types.all;
entity control_module is
    generic(
        N               : integer := 32
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        data_load       : in     vl_logic;
        coeff_load      : in     vl_logic;
        coeff_in        : in     vl_logic_vector(7 downto 0);
        data_write      : out    vl_logic;
        filter          : out    vl_logic_vector(71 downto 0);
        enable          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end control_module;
