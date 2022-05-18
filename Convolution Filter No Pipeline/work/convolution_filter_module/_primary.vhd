library verilog;
use verilog.vl_types.all;
entity convolution_filter_module is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        data_load       : in     vl_logic;
        data_i          : in     vl_logic_vector(7 downto 0);
        coeff_load      : in     vl_logic;
        coeff_in        : in     vl_logic_vector(7 downto 0);
        data_o          : out    vl_logic_vector(7 downto 0);
        data_write      : out    vl_logic
    );
end convolution_filter_module;
