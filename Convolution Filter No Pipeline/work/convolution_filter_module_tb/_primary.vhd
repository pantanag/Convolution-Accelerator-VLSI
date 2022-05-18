library verilog;
use verilog.vl_types.all;
entity convolution_filter_module_tb is
    generic(
        IM_SIZE         : integer := 32;
        MEM_SIZE        : vl_notype
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IM_SIZE : constant is 1;
    attribute mti_svvh_generic_type of MEM_SIZE : constant is 3;
end convolution_filter_module_tb;
