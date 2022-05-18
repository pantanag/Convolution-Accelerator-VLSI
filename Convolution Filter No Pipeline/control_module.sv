module control_module #(parameter N=32)(
    input logic clk,
    input logic rst,
    input logic data_load,
    input logic coeff_load,
    input logic[7:0] coeff_in,
    output logic data_write,
    output logic [71:0] filter,
    output logic enable
);
//Declaring 4 states for our fsm
typedef enum logic[3:0] {sRESET = 4'b0001, sIDLE = 4'b0010, sLOADC = 4'b0100, sWAIT = 4'b1000} fsm_state;
fsm_state state;
//Counter to keep track of the number of coefficients of the filter
logic[3:0] counter;
//Counter for the number of pixels of the image we have read
logic[$clog2(N*(N+1)+2)-1:0] total_counter;
//Temp variable for our filter
logic[71:0] temp;
//Row and Column counter to use in conditions later
always_ff @(posedge clk) begin
    if(rst) begin
        state <= sRESET;
    end
    else begin
        case(state)
            //RESET STATE -> EVERYTHING ZERO
            sRESET: begin
                temp <= 0;
                counter <=0;
                total_counter <= 0;
                state <= sIDLE;
            end
            //IDLE STATE -> WAITING FOR SIGNAL
            sIDLE: begin
                if (coeff_load) begin
                   state <= sLOADC; 
                end          
            end
            //LOADC STATE -> LOAD COEFFICIENT 
            sLOADC: begin
                if(counter < 9) begin
                    temp <= temp << 8;
                    temp[7:0] <= coeff_in;
                    counter <= counter + 1;
                    state <= sLOADC;
                end
                else begin
                    state <= sWAIT;
                end
            end
            //WAIT STATE -> FOR DETERMINING CONTROL SIGNALS LATER
            sWAIT: begin
                if(data_load) begin
                    total_counter <= total_counter + 1;
                end
            end
        endcase
    end
end
//Assign values to output variables
assign filter = (state == sWAIT) ? temp :0;
assign data_write = (state == sWAIT && total_counter >= N+2  && total_counter <= N*(N+1)+1) ? 1 : 0;
assign enable = (state == sWAIT && (total_counter%N != 1  && total_counter%N != 2) && total_counter >= 2*N+3 && total_counter <= N*N+1) ? 1 : 0;
endmodule