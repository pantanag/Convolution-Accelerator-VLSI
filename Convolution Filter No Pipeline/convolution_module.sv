module convolution_module(
    input logic[71:0] filter,
    input logic[71:0] window,
    // input logic[8:0][7:0] window,  TO DO
    output logic[7:0] outputPixel
);

logic [8:0][7:0] pixels;
logic [8:0][7:0] weights;
logic [14:0] sum;
logic [8:0][15:0] mult;
logic [4:0][16:0] sum_1;
logic [2:0][17:0] sum_2;
always_comb begin
    //Unpack operator for pixels inside window and coefficients inside filter
    // {>>{p1,p2,p3,p4,p5,p6,p7,p8,p9}} = window;
    // {>>{w1,w2,w3,w4,w5,w6,w7,w8,w9}} = filter;
    int i,j,x;
    for(i=0;i<9;i++) begin
        pixels[i][7:0] = window[(71-8*i) -: 8];
        weights[i][7:0] = filter[(71-8*i) -: 8];
        //weights[i][7:0] = $signed(filter[(71-8*i) -: 8]);
        mult[i][15:0] = weights[i][7:0] * pixels[i][7:0];
    end
    
    //Calculating sums
    for(j=0;j<8;j+=2) begin
        sum_1[j>>1][16:0] = mult[j][15:0] + mult[j+1][15:0];
    end
    sum_1[4][16:0] = mult[8][15:0];

    for(x=0;x<4;x+=2) begin
        sum_2[x>>1] = sum_1[x][16:0] + sum_1[x+1][16:0];
    end
    sum_2[2][17:0] = sum_1[4][16:0];

    //Calculating sum of coefficients
    sum = weights[0][7:0]+weights[1][7:0]+weights[2][7:0]+weights[3][7:0]+weights[4][7:0]+weights[5][7:0]+weights[6][7:0]+weights[7][7:0]+weights[8][7:0];
    //If sum different than zero then divide else dont
    if(sum != 0) begin 
        outputPixel = (sum_2 [0][17:0] + sum_2[1][17:0] + sum_2 [2][17:0])/sum; 
    end
    else begin
        outputPixel = (sum_2 [0][17:0] + sum_2[1][17:0] + sum_2 [2][17:0]);
    end
end
endmodule