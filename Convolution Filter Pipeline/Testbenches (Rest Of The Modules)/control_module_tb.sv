module control_module_tb;

logic clk;
logic rst;
logic data_load;
logic coeff_load;
logic [7:0] coeff_in;
logic data_write;
logic[71:0] filterTemp;
logic enable;
control_module control_module_test(
    .rst(rst),
    .clk(clk),
    .data_load(data_load),
    .coeff_load(coeff_load),
    .coeff_in(coeff_in),
    .data_write(data_write),
    .filter(filterTemp),
    .enable(enable)
);

initial begin
  clk =0;
  forever #5 clk = ~clk;
end

initial begin
    $monitor($time,"    %b",filterTemp);
     @(negedge clk);
    rst = 1;
    @(negedge clk);
    rst = 0;
    #10
    data_load = 0;
    coeff_load = 1;
    @(negedge clk);
    @(negedge clk);
    coeff_in = 8'b00000001;
    @(negedge clk);
    coeff_in = 8'b00000011;
    @(negedge clk);
    coeff_in = 8'b00000111;
    @(negedge clk);
    coeff_in = 8'b00001111;
    @(negedge clk);
    coeff_in = 8'b00011111;
    @(negedge clk);
    coeff_in = 8'b00111111;
    @(negedge clk);
    coeff_in = 8'b01111111;
    @(negedge clk);
    coeff_in = 8'b11111111;
    @(negedge clk);
    coeff_in = 8'b10000011;
    coeff_load = 0;
    @(negedge clk);
    data_load = 1;
    //@(negedge clk);
    //@(negedge clk);
    #50
    $stop;
end
endmodule