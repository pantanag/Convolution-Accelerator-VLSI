module convolution_module_tb;
logic [71:0] windowTest;
logic [71:0] filter; 
logic [7:0] outputP;
convolution_module convolution_module_test(
    .window(windowTest),
    .filter(filter),
    .outputPixel(outputP)
);
initial begin
    filter = 72'b00000001_00000010_00000011_00000100_00000101_00000110_00000111_00001000_00001001;
    windowTest = 72'b00000001_00000001_00000001_00000001_00000001_00000001_00000001_00000001_00000001;
end
endmodule