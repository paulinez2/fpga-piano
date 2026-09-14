module fpga_piano (
    input  logic        CLK100MHZ, BTNC,
    input  logic [15:0] SW,
    output logic        AUD_PWM );

    logic [31:0] inc_out, phase;
    logic [7:0]  val_out;

    note_selector ns0 (.SW,
                       .inc_out);

    phase_accumulator pa0 (.clk(CLK100MHZ),
                           .reset(BTNC),
                           .inc_out,
                           .phase);

    sine_rom sr0 (.addr(phase[31:24]),
                  .val_out);

    pwm_converter pc0 (.clk(CLK100MHZ),
                       .reset(BTNC),
                       .sine_value(val_out),
                       .data_out(AUD_PWM));

endmodule : fpga_piano