module convolution_module(
    input logic clk,
    input logic rst,
    input logic[71:0] filter,
    input logic[8:0][7:0] window,
    output logic[7:0] outputPixel
);
logic [8:0][7:0] weights;
logic [8:0][7:0] pixels;
logic [15:0] sum;
logic [8:0][15:0] mult;
logic [4:0][16:0] sum_1;
logic [2:0][17:0] sum_2;
integer i;
//Unpack operator for pixels inside window and coefficients inside filter
// {>>{p1,p2,p3,p4,p5,p6,p7,p8,p9}} = window;
// {>>{w1,w2,w3,w4,w5,w6,w7,w8,w9}} = filter;
always_comb begin
    for(i=0;i<9;i++) begin
        pixels[i][7:0] = window[8-i][7:0];
        weights[i][7:0] = filter[(71-8*i) -:8];
        //weights[i][7:0] = $signed(filter[(71-8*i) -:8]);
    end
end
always_ff @(posedge clk) begin
    if(rst) begin
        mult <=0;
        sum_1 <=0;
        sum_2 <=0;
    end
    else begin
        //Calculating multiplications
        mult[0][15:0] <=  weights[0][7:0] * pixels[0][7:0];
        mult[1][15:0] <= weights[1][7:0] * pixels[1][7:0];
        mult[2][15:0] <= weights[2][7:0] * pixels[2][7:0];
        mult[3][15:0] <= weights[3][7:0] * pixels[3][7:0];
        mult[4][15:0] <= weights[4][7:0] * pixels[4][7:0];
        mult[5][15:0] <= weights[5][7:0] * pixels[5][7:0];
        mult[6][15:0] <= weights[6][7:0] * pixels[6][7:0];
        mult[7][15:0] <= weights[7][7:0] * pixels[7][7:0];
        mult[8][15:0] <= weights[8][7:0] * pixels[8][7:0];

        //Calculating sums
        sum_1 [0][16:0] <= mult[0][15:0] + mult[1][15:0];
        sum_1 [1][16:0] <= mult[2][15:0] + mult[3][15:0];
        sum_1 [2][16:0] <= mult[4][15:0] + mult[5][15:0];
        sum_1 [3][16:0] <= mult[6][15:0] + mult[7][15:0];
        sum_1 [4][15:0] <= mult[8][15:0];
        sum_2 [0][17:0] <= sum_1[0][16:0] + sum_1[1][16:0];
        sum_2 [1][17:0] <= sum_1[2][16:0] + sum_1[3][16:0];
        sum_2 [2][15:0] <= sum_1[4][15:0];
end
end

always_comb begin
    //Sum of weights
    sum = weights[0][7:0] + weights[1][7:0] + weights[2][7:0] + weights[3][7:0] + weights[4][7:0] + weights[5][7:0] + weights[6][7:0] + weights[7][7:0] + weights[8][7:0];
    //Based on filter calculate output
    if(sum != 0) begin 
        outputPixel = (sum_2 [0][17:0] + sum_2[1][17:0] + sum_2 [2][17:0])/sum;
    end
    else begin
        outputPixel = sum_2 [0][17:0] + sum_2[1][17:0] + sum_2 [2][17:0];
    end
end

endmodule