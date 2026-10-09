// Black-box declaration for the MachXO2 internal oscillator used by archived S3C RTL.
// The implementation is supplied by the target device during place and route.
(* blackbox *)
module OSCH #(parameter NOM_FREQ = "2.08") (
    input STDBY,
    output OSC,
    output SEDSTDBY
);
endmodule
