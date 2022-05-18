module  convolution_filter_module_tb;
logic clk,rst;
logic[7:0] data_i_temp,data_o_temp,coeff_in_temp;
logic data_load_temp,coeff_load_temp,data_write_temp;
//MEM_SIZE Parameter must be set to N*N where N is dimension of the image
parameter IM_SIZE = 32;
parameter MEM_SIZE = IM_SIZE * IM_SIZE;
integer i,fileout;
logic[7:0] test_mem[0:MEM_SIZE-1];
//logic[$clog2(512*512):0] write_counter;
convolution_filter_module convolution_tb(
    .rst(rst),
    .clk(clk),
    .data_i(data_i_temp),
    .data_o(data_o_temp),
    .coeff_in(coeff_in_temp),
    .data_load(data_load_temp),
    .coeff_load(coeff_load_temp),
    .data_write(data_write_temp)
);
always begin
	clk = 0;
	#10ns;
	clk = 1;
	#10ns;
end
initial begin
    //Reset circuit
    @(negedge clk);
    rst = 1;
    //write_counter = 0;
    @(negedge clk);
    rst = 0;
    #10
    //Load coefficients of the filter (Sobel Gx in our case)
    data_load_temp = 0;
    coeff_load_temp = 1;
    @(negedge clk);
    @(negedge clk);
    coeff_in_temp = 1;
    @(negedge clk);
    coeff_in_temp = 1;
    @(negedge clk);
    coeff_in_temp = 1;
    @(negedge clk);
    coeff_in_temp = 1;
    @(negedge clk);
    coeff_in_temp = 1;
    @(negedge clk);
    coeff_in_temp = 1;
    @(negedge clk);
    coeff_in_temp = 1;
    @(negedge clk);
    coeff_in_temp = 1;
    @(negedge clk);
    coeff_in_temp = 1;
    coeff_load_temp = 0;


    @(posedge clk);
    @(posedge clk);
    //Open file for writing new image
    fileout = $fopen("Filtered Images/new_image_32_pipeline.txt");
    //Read old image
    $readmemb("Images/image_32.txt",test_mem);
	for(i=0;i<MEM_SIZE;i = i+1) begin
        {data_i_temp} = test_mem[i];
        data_load_temp = 1;
        @(posedge clk);
        //If a new pixel is calculated, write it to the new image
        if(data_write_temp) begin
            $fdisplay(fileout,"%b",data_o_temp);
            //write_counter = write_counter + 1;
        end
    end
    //Rest Cycles needed to finish convolution
    //If a new pixel is calculated, write it to the new image
    while (data_write_temp) begin
        @(posedge clk);
        $fdisplay(fileout,"%b",data_o_temp);
        //write_counter = write_counter + 1;
        @(negedge clk);
    end
    $fclose(fileout);
    $stop;
end    
endmodule