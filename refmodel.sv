
// Code your design here
module CCLU_REF (command, addres_in, target_in, counter_in, reset, clk, valid, isFull, error, target_out);
input logic [1:0] command;
input logic [31:0] addres_in ;
input logic [31:0] counter_in;
input logic [31:0] target_in;
input logic reset;
input logic clk;
output logic valid=0;
output logic isFull=0;
output logic error=0;
  output logic [31:0] target_out=0;
logic [31:0] address[$:15];
logic [31:0]  counter [$:15];
  logic [31:0] counter_temp;
int tarf = 0;
  int erf=0;
always @(posedge clk) begin 
if (tarf) begin
    target_out <= target_in;
tarf = 0;
end
  if (erf) begin
    error <= 1;
erf = 0;
end
if (reset) begin

  if (command == 2'b00 || command == 2'b10 || command == 2'b01 ) 
        error <= 1; 
    else begin
        foreach (address[i])
            address.pop_front ();
foreach (counter[i])
    counter.pop_front();
end
end

else if ( command == 2'b11) begin
    error<=1;
  valid <= 0;
end else if( command == 2'b01) begin
  if (addres_in == address[0]) begin
    if (counter[0] == 1) begin
            address.pop_front();
counter.pop_front();
   
  end
    else begin
      counter[0]=counter[0]-1;
      
     
    end

valid <= 1;
tarf = 1;
    error<=0;
end
  else begin
    if(counter_in == 0) begin
      error<=1;
    valid <= 0;end
    else if(counter_in == 1)begin
      valid<=1;
	tarf=1;
      error<=0;
    end else if(address.size ()==16 ||counter.size ()==16) begin
      erf=1;
      valid<=1;
    end
     else begin
       counter_temp=counter_in-1;
       address.push_front(counter_temp);
       counter.push_front(addres_in);
       tarf=1;
       valid<=1;
       error<=0;
     end
      
  end

end else if ( command == 2'b10) begin
    address.pop_front ();
	counter.pop_front ();
	valid<=1;
	tarf=1;
  error<=0;
end else if( command == 2'b00) begin
  $display("do nothing");
  
    end
if(address.size ()==16 ||counter.size ()==16) begin
      isFull<=1;
    end
  
  if(address.size ()==0 ||counter.size ()==0) begin
     valid <= 0;
    end
    end

    endmodule
