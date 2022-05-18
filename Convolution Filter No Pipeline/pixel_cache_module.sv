module pixel_cache_module #(parameter N = 32)(
    input logic rst,
    input logic clk,
    input logic data_load,
    input logic[7:0] data_i,
    output logic[71:0] window
);
logic[N-1:0][7:0] row_buffer_1,row_buffer_2;
always_ff @(posedge clk) begin
    //Reset
    if(rst) begin
        row_buffer_1 <= 0;
        row_buffer_2 <= 0;
        window <= 0;
    end
    else begin
        if(data_load) begin
            //Assigning values to the row buffers (Update them)
            //Second Buffer
            row_buffer_2 <= {row_buffer_2[N-2:0],row_buffer_1[N-1]};
            //First Buffer
            row_buffer_1 <= {row_buffer_1[N-2:0],data_i};
            //Assigning values to each pixel of the window (Update it)
            //Window First Row
            window[23:0] <= {window[15:0],data_i};
            //Window Second Row
            window[47:24] <= {window[39:24],row_buffer_1[N-1]};
            //Window Third Row
            window[71:48] <= {window[63:48],row_buffer_2[N-1]};
        end   
    end
end
endmodule