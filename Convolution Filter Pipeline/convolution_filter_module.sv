module convolution_filter_module(
    input logic clk,
    input logic rst,
    input logic data_load,
    input logic[7:0] data_i,
    input logic coeff_load,
    input logic[7:0] coeff_in,
    output logic[7:0] data_o,
    output logic data_write
);
logic[71:0] filterTemp;
logic[8:0][7:0] windowTemp;
logic[7:0] outputP;
logic enableTemp;
//Connecting the three modules
control_module control(
    .rst(rst),
    .clk(clk),
    .data_load(data_load),
    .coeff_load(coeff_load),
    .coeff_in(coeff_in),
    .data_write(data_write),
    .filter(filterTemp),
    .enable(enableTemp)
);
pixel_cache_module pixel_cache(
    .clk(clk),
    .rst(rst),
    .data_load(data_load),
    .data_i(data_i),
    .window(windowTemp)
);
convolution_module convolution(
    .clk(clk),
    .rst(rst),
    .window(windowTemp),
    .filter(filterTemp),
    .outputPixel(outputP)
);
logic[23:0] middle;

always_ff @(posedge clk) begin
    if(rst) begin
        middle <= 0;
    end
    else begin
        //Shift first 2 bytes for delay
        middle <= {middle[15:0],windowTemp[4][7:0]};
    end
end
//If data_write then give output data according to condition
assign data_o = (enableTemp && data_write) ? outputP :middle[23:16];

endmodule