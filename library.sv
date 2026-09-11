//`default_nettype none

// checks if A & B are equal
module Comparator
#(parameter WIDTH = 4)
  (input logic [WIDTH-1:0] A, B,
   output logic AeqB);

   assign AeqB = (A == B);

endmodule : Comparator

// compares A & B with magnitude 
module MagComp 
#(parameter WIDTH = 8)
  (input logic [WIDTH-1:0] A, B,
   output logic AltB, AeqB, AgtB);

   always_comb begin
     AltB = 1'b0;
     AeqB = 1'b0;
     AgtB = 1'b0;
     if (A == B)
       AeqB = 1'b1;
    else if (A < B)
      AltB = 1'b1;
    else if (A > B)
      AgtB = 1'b1;

   end 
endmodule : MagComp

// adds A & B 
module Adder
#(parameter WIDTH = 5)
  (input logic [WIDTH-1:0] A, B,
   input logic cin,
   output logic cout,
   output logic [WIDTH-1:0] sum);

   assign {cout, sum} = A + B + cin;

endmodule : Adder

// subtracts A-B 
module Subtracter
#(parameter WIDTH = 5)
  (input logic [WIDTH-1:0] A, B,
   input logic bin,
   output logic bout,
   output logic [WIDTH-1:0] diff);

   assign {bout, diff} = A - B - bin;

endmodule : Subtracter

// multiplexer with width parameter
module Multiplexer
#(parameter WIDTH = 8,
            SEL = $clog2(WIDTH))
  (input logic [WIDTH-1:0] I, 
   input logic [SEL-1:0] S,
   output logic Y);

   assign Y = I[S];

endmodule : Multiplexer

// multiplexer with 2 inputs 
module Mux2to1
#(parameter WIDTH = 7)
  (input logic S,
   input logic [WIDTH-1:0] I0, I1,
   output logic [WIDTH-1:0] Y);
  always_comb begin
    Y = (S) ? I1 : I0;
  end 

endmodule : Mux2to1

//  decoder module
module Decoder
#(parameter WIDTH = 8,
            SEL = $clog2(WIDTH))
  (input logic en, [SEL-1:0] I,
   output logic [WIDTH-1:0] D);

   always_comb begin
    D = 0;
    if (en === 1'b1)
      D[I] = 1'b1;
    // if (en) begin
    //   D = (1 << I);
    // end else begin
    //   D = {WIDTH{1'b0}}; 
    // end
  end
    
endmodule : Decoder

// d flip flop
module DFlipFlop
   (input logic D, clock, reset_L, preset_L,
    output logic Q);

    always_ff @(posedge clock, negedge reset_L, negedge preset_L)
        if (~preset_L & ~reset_L)
            Q <= 1'bX;
        else if (~reset_L)
            Q <= 1'b0;
        else if (~preset_L)
            Q <= 1'b1;
        else
            Q <= D;

endmodule : DFlipFlop

// register
module Register
#(parameter WIDTH = 4)
   (input logic en, clear, clock, [WIDTH-1:0] D,
    output logic [WIDTH-1:0] Q);

    always_ff @(posedge clock)
        if (en)
            Q <= D;
        else if (clear)
            Q <= '0;

endmodule : Register

// Counter
module Counter
#(parameter WIDTH = 4)
   (input logic en, clear, clock, load, up,
    input logic [WIDTH-1:0] D,
    output logic [WIDTH-1:0] Q);

    always_ff @(posedge clock)
        if (clear)
            Q <= 0;
        else if (load)
            Q <= D;
        else if (en & up)
            Q <= Q + 1;
        else if (en & ~up)
            Q <= Q - 1;

endmodule : Counter 

// ShiftRegisterSIPO
// serial input, parallel output
module ShiftRegisterSIPO
#(parameter WIDTH = 4)
   (input logic en, left, serial, clock,
    output logic [WIDTH-1:0] Q);
    
    always_ff @(posedge clock)
      if (en) begin
        if (left)
          Q <= {Q[WIDTH-2:0], serial};
        else if (~left)
          Q <= {serial, Q[WIDTH-1:1]};
      end 
endmodule : ShiftRegisterSIPO 

// ShiftRegisterPIPO
module ShiftRegisterPIPO
#(parameter WIDTH = 4)
   (input logic en, left, load, clock, 
    input logic [WIDTH-1:0] D,
    output logic [WIDTH-1:0] Q);

    always_ff @(posedge clock)
      if (load)
        Q <= D;
      else if (en & ~load) begin
        if (left)
          Q <= (Q << 1);
        else if (~left)
          Q <= Q >> 1;
      end 
      // else if (load)

endmodule : ShiftRegisterPIPO 

// BarrelshiftRegister
module BarrelShiftRegister
#(parameter WIDTH = 4)
   (input logic en, load, clock, 
    input logic [WIDTH-1:0] D,
    input logic [1:0] by,
    output logic [WIDTH-1:0] Q);

    always_ff @(posedge clock)
        if (load)
            Q <= D;
        else if (en & by >= 2'b00)
            Q <= D << by; 

endmodule : BarrelShiftRegister 

// Synchronizer 
module Synchronizer
   (input logic async, clock,
    output logic sync);

    logic pressed;

    DFlipFlop FF0(.D(async), .Q(pressed), .preset_L(1'b1), .reset_L(1'b1), .*);
    DFlipFlop FF1(.D(pressed), .Q(sync), .preset_L(1'b1), .reset_L(1'b1), .*);

endmodule : Synchronizer 

// BusDrivers 
module BusDriver
#(parameter WIDTH = 4)
   (input logic en, 
    input logic [WIDTH-1:0] data, 
    output logic [WIDTH-1:0] buff,
    inout tri [WIDTH-1:0] bus);

    assign bus = (en) ? data: 'bz;
    assign buff = bus; 

endmodule : BusDriver 

// Memory  
module Memory
#(parameter DW = 16, W = 256, AW = $clog2(W))
    (input logic re, we, clock,
     input logic [AW-1:0] addr,
     inout tri [DW-1:0] data);
     
    logic [DW-1:0] M[W];
    logic [DW-1:0] rData;
    assign data = (re) ? rData: 'bz;
    always_ff @(posedge clock)
        if (we)
            M[addr] <= data;
    always_comb
        rData = M[addr];

endmodule : Memory 

module Clock_Divider #(
    parameter int INPUT_FREQ  = 100_000_000,
    parameter int OUTPUT_FREQ = 1_000_000
)(
    input  logic clk,
    input  logic rst,
    output logic clk_out
);

    localparam int DIVISOR = INPUT_FREQ / (2 * OUTPUT_FREQ);

    logic [$clog2(DIVISOR)-1:0] count;

    always_ff @(posedge clk) begin
        if (rst) begin
            count   <= '0;
            clk_out <= 1'b0;
        end else if (count == DIVISOR - 1) begin
            count   <= '0;
            clk_out <= ~clk_out;
        end else begin
            count <= count + 1'b1;
        end
    end

endmodule : Clock_Divider

module Edge_Detector (
    input  logic clk,
    input  logic rst,
    input  logic signal_in,
    output logic edge_detected
);

    logic signal_prev;

    always_ff @(posedge clk) begin
        if (rst) begin
            signal_prev   <= 1'b0;
            edge_detected <= 1'b0;
        end else begin
            edge_detected <= signal_in & ~signal_prev;
            signal_prev   <= signal_in;
        end
    end

endmodule : Edge_Detector

// ============================================================
//  vga_timing.sv
//  Standard 640x480 @ 60 Hz  (25.175 MHz pixel clock)
//
//  Horizontal totals  (pixels):
//    Visible: 640   Front porch: 16   Sync: 96   Back porch: 48  → 800
//  Vertical totals  (lines):
//    Visible: 480   Front porch: 10   Sync: 2    Back porch: 33  → 525
// 
//  hsync / vsync are active-LOW (standard VGA polarity)
// ============================================================
module vga_timing (
    input  logic        clk,        // 25.175 MHz pixel clock
    input  logic        rst_n,

    output logic [9:0]  px,         // current pixel x  (0..639 in visible area)
    output logic [9:0]  py,         // current pixel y  (0..479 in visible area)
    output logic        visible,    // high when px/py are in the active region
    output logic        hsync,      // active-low horizontal sync
    output logic        vsync       // active-low vertical sync
);

    localparam H_VISIBLE    = 10'd640;
    localparam H_FP         = 10'd16;
    localparam H_SYNC       = 10'd96;
    localparam H_BP         = 10'd48;
    localparam H_TOTAL      = H_VISIBLE + H_FP + H_SYNC + H_BP; // 800

    localparam H_SYNC_START = H_VISIBLE + H_FP;           // 656
    localparam H_SYNC_END   = H_VISIBLE + H_FP + H_SYNC;  // 752

    localparam V_VISIBLE    = 10'd480;
    localparam V_FP         = 10'd10;
    localparam V_SYNC       = 10'd2;
    localparam V_BP         = 10'd33;
    localparam V_TOTAL      = V_VISIBLE + V_FP + V_SYNC + V_BP; // 525

    localparam V_SYNC_START = V_VISIBLE + V_FP;           // 490
    localparam V_SYNC_END   = V_VISIBLE + V_FP + V_SYNC;  // 492

    // -------------------------------------------------------
    logic [9:0] h_cnt, v_cnt;

    always_ff @(posedge clk) begin
        if (rst_n)
            h_cnt <= '0;
        else if (h_cnt == H_TOTAL - 1)
            h_cnt <= '0;
        else
            h_cnt <= h_cnt + 1'b1;
    end

    always_ff @(posedge clk) begin
        if (rst_n)
            v_cnt <= 'd0;
        else if (h_cnt == H_TOTAL - 1) begin
            if (v_cnt == V_TOTAL - 1)
                v_cnt <= '0;
            else
                v_cnt <= v_cnt + 1'b1;
        end
    end

    always_ff @(posedge clk) begin
        if (rst_n) begin
            px      <= '0;
            py      <= '0;
            visible <= 1'b0;
            hsync   <= 1'b1;
            vsync   <= 1'b1;
        end else begin
            px      <= h_cnt;
            py      <= v_cnt;
            visible <= (h_cnt < H_VISIBLE) && (v_cnt < V_VISIBLE);
            hsync   <= ~((h_cnt >= H_SYNC_START) && (h_cnt < H_SYNC_END));
            vsync   <= ~((v_cnt >= V_SYNC_START) && (v_cnt < V_SYNC_END));
        end
    end

endmodule

module clock_divider4(
    input logic clk100,
    input logic reset,
    output logic clk25 );


    logic [1:0] counter;

    always_ff@(posedge clk100) begin
        if (reset)
            counter <= 'd0;
        else 
            counter <= counter + 1;
    end

    assign clk25 = counter[1]; // bit 1 is high means a 4 on 2 bits

endmodule: clock_divider4

module lfsr (
    input logic clock,
    input logic reset,
    input  logic enable,
    input logic [7:0] seed,
    output logic [7:0] random
);
    logic feedback;
    assign feedback = random[7] ^ random[5] ^ random[4] ^ random[3];

    always_ff @(posedge clock) begin
        if (reset) begin
            random <= seed;
        end
        else if (enable) begin
            random <= {random[6:0], feedback};
        end
    end

endmodule