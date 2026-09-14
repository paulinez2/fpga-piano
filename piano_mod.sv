// base on switch detected select output frequency
module note_selector (
    input  logic [15:0] SW,
    output logic [31:0] inc_out);

    localparam logic [31:0] C4_INC = 32'd11231;
    localparam logic [31:0] D4_INC = 32'd12606;
    localparam logic [31:0] E4_INC = 32'd14145;
    localparam logic [31:0] F4_INC = 32'd14987;
    localparam logic [31:0] G4_INC = 32'd16822;
    localparam logic [31:0] A4_INC = 32'd18869;
    localparam logic [31:0] B4_INC = 32'd21200;
    localparam logic [31:0] C5_INC = 32'd22462;

    always_comb begin
        inc_out = 'd0;
        if (SW[0]) //C4
            inc_out = C4_INC;
        if (SW[1]) // D4
            inc_out = D4_INC;
        if (SW[2]) // E4
            inc_out = E4_INC;
        if (SW[3]) // F4
            inc_out = F4_INC;
        if (SW[4]) // G4
            inc_out = G4_INC;
        if (SW[5]) // A4
            inc_out = A4_INC;
        if (SW[6]) // B4
            inc_out = B4_INC;
        if (SW[7]) // C5
            inc_out = C5_INC;
    end
endmodule

// stores values of sine wave
module sine_rom (
    input  logic [7:0] addr,
    output logic [7:0] val_out);

    always_comb begin
        case (addr)
            8'd0:   val_out = 8'd128;
            8'd1:   val_out = 8'd131;
            8'd2:   val_out = 8'd134;
            8'd3:   val_out = 8'd137;
            8'd4:   val_out = 8'd140;
            8'd5:   val_out = 8'd143;
            8'd6:   val_out = 8'd146;
            8'd7:   val_out = 8'd149;
            8'd8:   val_out = 8'd152;
            8'd9:   val_out = 8'd155;
            8'd10:  val_out = 8'd159;
            8'd11:  val_out = 8'd162;
            8'd12:  val_out = 8'd165;
            8'd13:  val_out = 8'd168;
            8'd14:  val_out = 8'd171;
            8'd15:  val_out = 8'd174;
            8'd16:  val_out = 8'd177;
            8'd17:  val_out = 8'd180;
            8'd18:  val_out = 8'd183;
            8'd19:  val_out = 8'd186;
            8'd20:  val_out = 8'd188;
            8'd21:  val_out = 8'd191;
            8'd22:  val_out = 8'd194;
            8'd23:  val_out = 8'd196;
            8'd24:  val_out = 8'd198;
            8'd25:  val_out = 8'd201;
            8'd26:  val_out = 8'd203;
            8'd27:  val_out = 8'd205;
            8'd28:  val_out = 8'd208;
            8'd29:  val_out = 8'd210;
            8'd30:  val_out = 8'd212;
            8'd31:  val_out = 8'd214;
            8'd32:  val_out = 8'd218;
            8'd33:  val_out = 8'd219;
            8'd34:  val_out = 8'd221;
            8'd35:  val_out = 8'd223;
            8'd36:  val_out = 8'd225;
            8'd37:  val_out = 8'd227;
            8'd38:  val_out = 8'd229;
            8'd39:  val_out = 8'd231;
            8'd40:  val_out = 8'd233;
            8'd41:  val_out = 8'd235;
            8'd42:  val_out = 8'd237;
            8'd43:  val_out = 8'd239;
            8'd44:  val_out = 8'd241;
            8'd45:  val_out = 8'd243;
            8'd46:  val_out = 8'd244;
            8'd47:  val_out = 8'd246;
            8'd48:  val_out = 8'd247;
            8'd49:  val_out = 8'd249;
            8'd50:  val_out = 8'd250;
            8'd51:  val_out = 8'd251;
            8'd52:  val_out = 8'd252;
            8'd53:  val_out = 8'd253;
            8'd54:  val_out = 8'd254;
            8'd55:  val_out = 8'd254;
            8'd56:  val_out = 8'd255;
            8'd57:  val_out = 8'd255;
            8'd58:  val_out = 8'd255;
            8'd59:  val_out = 8'd255;
            8'd60:  val_out = 8'd255;
            8'd61:  val_out = 8'd255;
            8'd62:  val_out = 8'd255;
            8'd63:  val_out = 8'd255;
            8'd64:  val_out = 8'd255;
            8'd65:  val_out = 8'd255;
            8'd66:  val_out = 8'd255;
            8'd67:  val_out = 8'd255;
            8'd68:  val_out = 8'd255;
            8'd69:  val_out = 8'd255;
            8'd70:  val_out = 8'd255;
            8'd71:  val_out = 8'd255;
            8'd72:  val_out = 8'd255;
            8'd73:  val_out = 8'd255;
            8'd74:  val_out = 8'd254;
            8'd75:  val_out = 8'd254;
            8'd76:  val_out = 8'd254;
            8'd77:  val_out = 8'd253;
            8'd78:  val_out = 8'd252;
            8'd79:  val_out = 8'd251;
            8'd80:  val_out = 8'd250;
            8'd81:  val_out = 8'd249;
            8'd82:  val_out = 8'd247;
            8'd83:  val_out = 8'd246;
            8'd84:  val_out = 8'd244;
            8'd85:  val_out = 8'd243;
            8'd86:  val_out = 8'd241;
            8'd87:  val_out = 8'd239;
            8'd88:  val_out = 8'd237;
            8'd89:  val_out = 8'd235;
            8'd90:  val_out = 8'd233;
            8'd91:  val_out = 8'd231;
            8'd92:  val_out = 8'd229;
            8'd93:  val_out = 8'd227;
            8'd94:  val_out = 8'd225;
            8'd95:  val_out = 8'd223;
            8'd96:  val_out = 8'd221;
            8'd97:  val_out = 8'd219;
            8'd98:  val_out = 8'd216;
            8'd99:  val_out = 8'd214;
            8'd100: val_out = 8'd212;
            8'd101: val_out = 8'd210;
            8'd102: val_out = 8'd208;
            8'd103: val_out = 8'd205;
            8'd104: val_out = 8'd203;
            8'd105: val_out = 8'd201;
            8'd106: val_out = 8'd198;
            8'd107: val_out = 8'd196;
            8'd108: val_out = 8'd194;
            8'd109: val_out = 8'd191;
            8'd110: val_out = 8'd188;
            8'd111: val_out = 8'd186;
            8'd112: val_out = 8'd183;
            8'd113: val_out = 8'd180;
            8'd114: val_out = 8'd177;
            8'd115: val_out = 8'd174;
            8'd116: val_out = 8'd171;
            8'd117: val_out = 8'd168;
            8'd118: val_out = 8'd165;
            8'd119: val_out = 8'd162;
            8'd120: val_out = 8'd159;
            8'd121: val_out = 8'd155;
            8'd122: val_out = 8'd152;
            8'd123: val_out = 8'd149;
            8'd124: val_out = 8'd146;
            8'd125: val_out = 8'd143;
            8'd126: val_out = 8'd140;
            8'd127: val_out = 8'd137;
            8'd128: val_out = 8'd128;
            8'd129: val_out = 8'd125;
            8'd130: val_out = 8'd122;
            8'd131: val_out = 8'd119;
            8'd132: val_out = 8'd116;
            8'd133: val_out = 8'd113;
            8'd134: val_out = 8'd110;
            8'd135: val_out = 8'd107;
            8'd136: val_out = 8'd104;
            8'd137: val_out = 8'd101;
            8'd138: val_out = 8'd97;
            8'd139: val_out = 8'd94;
            8'd140: val_out = 8'd91;
            8'd141: val_out = 8'd88;
            8'd142: val_out = 8'd85;
            8'd143: val_out = 8'd82;
            8'd144: val_out = 8'd79;
            8'd145: val_out = 8'd76;
            8'd146: val_out = 8'd73;
            8'd147: val_out = 8'd70;
            8'd148: val_out = 8'd68;
            8'd149: val_out = 8'd65;
            8'd150: val_out = 8'd62;
            8'd151: val_out = 8'd60;
            8'd152: val_out = 8'd58;
            8'd153: val_out = 8'd55;
            8'd154: val_out = 8'd53;
            8'd155: val_out = 8'd51;
            8'd156: val_out = 8'd48;
            8'd157: val_out = 8'd46;
            8'd158: val_out = 8'd44;
            8'd159: val_out = 8'd42;
            8'd160: val_out = 8'd38;
            8'd161: val_out = 8'd37;
            8'd162: val_out = 8'd35;
            8'd163: val_out = 8'd33;
            8'd164: val_out = 8'd31;
            8'd165: val_out = 8'd29;
            8'd166: val_out = 8'd27;
            8'd167: val_out = 8'd25;
            8'd168: val_out = 8'd23;
            8'd169: val_out = 8'd21;
            8'd170: val_out = 8'd19;
            8'd171: val_out = 8'd17;
            8'd172: val_out = 8'd15;
            8'd173: val_out = 8'd13;
            8'd174: val_out = 8'd12;
            8'd175: val_out = 8'd10;
            8'd176: val_out = 8'd9;
            8'd177: val_out = 8'd7;
            8'd178: val_out = 8'd6;
            8'd179: val_out = 8'd5;
            8'd180: val_out = 8'd4;
            8'd181: val_out = 8'd3;
            8'd182: val_out = 8'd2;
            8'd183: val_out = 8'd2;
            8'd184: val_out = 8'd1;
            8'd185: val_out = 8'd1;
            8'd186: val_out = 8'd1;
            8'd187: val_out = 8'd1;
            8'd188: val_out = 8'd1;
            8'd189: val_out = 8'd1;
            8'd190: val_out = 8'd1;
            8'd191: val_out = 8'd1;
            8'd192: val_out = 8'd0;
            8'd193: val_out = 8'd1;
            8'd194: val_out = 8'd1;
            8'd195: val_out = 8'd1;
            8'd196: val_out = 8'd1;
            8'd197: val_out = 8'd1;
            8'd198: val_out = 8'd1;
            8'd199: val_out = 8'd1;
            8'd200: val_out = 8'd1;
            8'd201: val_out = 8'd2;
            8'd202: val_out = 8'd2;
            8'd203: val_out = 8'd3;
            8'd204: val_out = 8'd4;
            8'd205: val_out = 8'd5;
            8'd206: val_out = 8'd6;
            8'd207: val_out = 8'd7;
            8'd208: val_out = 8'd9;
            8'd209: val_out = 8'd10;
            8'd210: val_out = 8'd12;
            8'd211: val_out = 8'd13;
            8'd212: val_out = 8'd15;
            8'd213: val_out = 8'd17;
            8'd214: val_out = 8'd19;
            8'd215: val_out = 8'd21;
            8'd216: val_out = 8'd23;
            8'd217: val_out = 8'd25;
            8'd218: val_out = 8'd27;
            8'd219: val_out = 8'd29;
            8'd220: val_out = 8'd31;
            8'd221: val_out = 8'd33;
            8'd222: val_out = 8'd35;
            8'd223: val_out = 8'd37;
            8'd224: val_out = 8'd38;
            8'd225: val_out = 8'd42;
            8'd226: val_out = 8'd44;
            8'd227: val_out = 8'd46;
            8'd228: val_out = 8'd48;
            8'd229: val_out = 8'd51;
            8'd230: val_out = 8'd53;
            8'd231: val_out = 8'd55;
            8'd232: val_out = 8'd58;
            8'd233: val_out = 8'd60;
            8'd234: val_out = 8'd62;
            8'd235: val_out = 8'd65;
            8'd236: val_out = 8'd68;
            8'd237: val_out = 8'd70;
            8'd238: val_out = 8'd73;
            8'd239: val_out = 8'd76;
            8'd240: val_out = 8'd79;
            8'd241: val_out = 8'd82;
            8'd242: val_out = 8'd85;
            8'd243: val_out = 8'd88;
            8'd244: val_out = 8'd91;
            8'd245: val_out = 8'd94;
            8'd246: val_out = 8'd97;
            8'd247: val_out = 8'd101;
            8'd248: val_out = 8'd104;
            8'd249: val_out = 8'd107;
            8'd250: val_out = 8'd110;
            8'd251: val_out = 8'd113;
            8'd252: val_out = 8'd116;
            8'd253: val_out = 8'd119;
            8'd254: val_out = 8'd122;
            8'd255: val_out = 8'd125;
            default: val_out = 8'd128;
        endcase
    end
endmodule 

module phase_accumulator (
    input  logic        clk,
    input  logic        reset,
    input  logic [31:0] inc_out,
    output logic [31:0] phase);

    always_ff @(posedge clk) begin
        if (reset)
            phase <= 32'd0;
        else
            phase <= phase + inc_out;
    end

endmodule

module pwm_converter (
    input  logic       clk,
    input  logic       reset,
    input  logic [7:0] sine_value,
    output logic       data_out );

    logic [7:0] pwm_counter;

    always_ff @(posedge clk) begin
        if (reset)
            pwm_counter <= 8'd0;
        else
            pwm_counter <= pwm_counter + 1'b1;
    end

    always_comb begin
        if (pwm_counter < sine_value)
            data_out = 1'b1;
        else
            data_out = 1'b0;
    end

endmodule