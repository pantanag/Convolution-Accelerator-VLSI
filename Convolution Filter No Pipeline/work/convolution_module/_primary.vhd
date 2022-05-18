library verilog;
use verilog.vl_types.all;
entity convolution_module is
    port(
        filter          : in     vl_logic_vector(71 downto 0);
        window          : in     vl_logic_vector(71 downto 0);
        outputPixel     : out    vl_logic_vector(7 downto 0)
    );
end convolution_module;
