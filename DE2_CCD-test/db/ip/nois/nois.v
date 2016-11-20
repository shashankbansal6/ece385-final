// nois.v

// Generated using ACDS version 15.0 145

`timescale 1 ps / 1 ps
module nois (
		input  wire        clk_clk,           //    clk.clk
		output wire        clk_27_clk,        // clk_27.clk
		input  wire        reset_reset_n,     //  reset.reset_n
		input  wire        rgb_startofpacket, //    rgb.startofpacket
		input  wire        rgb_endofpacket,   //       .endofpacket
		input  wire        rgb_valid,         //       .valid
		output wire        rgb_ready,         //       .ready
		input  wire [23:0] rgb_data,          //       .data
		input  wire        y_ready,           //      y.ready
		output wire        y_startofpacket,   //       .startofpacket
		output wire        y_endofpacket,     //       .endofpacket
		output wire        y_valid,           //       .valid
		output wire [7:0]  y_data             //       .data
	);

	wire    rst_controller_reset_out_reset; // rst_controller:reset_out -> [altpll_0:reset, video_chroma_resampler_0:reset]

	nois_altpll_0 altpll_0 (
		.clk       (clk_clk),                        //       inclk_interface.clk
		.reset     (rst_controller_reset_out_reset), // inclk_interface_reset.reset
		.read      (),                               //             pll_slave.read
		.write     (),                               //                      .write
		.address   (),                               //                      .address
		.readdata  (),                               //                      .readdata
		.writedata (),                               //                      .writedata
		.c0        (clk_27_clk),                     //                    c0.clk
		.areset    (),                               //        areset_conduit.export
		.locked    (),                               //        locked_conduit.export
		.phasedone ()                                //     phasedone_conduit.export
	);

	nois_video_chroma_resampler_0 video_chroma_resampler_0 (
		.clk                      (clk_clk),                        //                  clk.clk
		.reset                    (rst_controller_reset_out_reset), //                reset.reset
		.stream_in_startofpacket  (rgb_startofpacket),              //   avalon_chroma_sink.startofpacket
		.stream_in_endofpacket    (rgb_endofpacket),                //                     .endofpacket
		.stream_in_valid          (rgb_valid),                      //                     .valid
		.stream_in_ready          (rgb_ready),                      //                     .ready
		.stream_in_data           (rgb_data),                       //                     .data
		.stream_out_ready         (y_ready),                        // avalon_chroma_source.ready
		.stream_out_startofpacket (y_startofpacket),                //                     .startofpacket
		.stream_out_endofpacket   (y_endofpacket),                  //                     .endofpacket
		.stream_out_valid         (y_valid),                        //                     .valid
		.stream_out_data          (y_data)                          //                     .data
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                 // reset_in0.reset
		.clk            (clk_clk),                        //       clk.clk
		.reset_out      (rst_controller_reset_out_reset), // reset_out.reset
		.reset_req      (),                               // (terminated)
		.reset_req_in0  (1'b0),                           // (terminated)
		.reset_in1      (1'b0),                           // (terminated)
		.reset_req_in1  (1'b0),                           // (terminated)
		.reset_in2      (1'b0),                           // (terminated)
		.reset_req_in2  (1'b0),                           // (terminated)
		.reset_in3      (1'b0),                           // (terminated)
		.reset_req_in3  (1'b0),                           // (terminated)
		.reset_in4      (1'b0),                           // (terminated)
		.reset_req_in4  (1'b0),                           // (terminated)
		.reset_in5      (1'b0),                           // (terminated)
		.reset_req_in5  (1'b0),                           // (terminated)
		.reset_in6      (1'b0),                           // (terminated)
		.reset_req_in6  (1'b0),                           // (terminated)
		.reset_in7      (1'b0),                           // (terminated)
		.reset_req_in7  (1'b0),                           // (terminated)
		.reset_in8      (1'b0),                           // (terminated)
		.reset_req_in8  (1'b0),                           // (terminated)
		.reset_in9      (1'b0),                           // (terminated)
		.reset_req_in9  (1'b0),                           // (terminated)
		.reset_in10     (1'b0),                           // (terminated)
		.reset_req_in10 (1'b0),                           // (terminated)
		.reset_in11     (1'b0),                           // (terminated)
		.reset_req_in11 (1'b0),                           // (terminated)
		.reset_in12     (1'b0),                           // (terminated)
		.reset_req_in12 (1'b0),                           // (terminated)
		.reset_in13     (1'b0),                           // (terminated)
		.reset_req_in13 (1'b0),                           // (terminated)
		.reset_in14     (1'b0),                           // (terminated)
		.reset_req_in14 (1'b0),                           // (terminated)
		.reset_in15     (1'b0),                           // (terminated)
		.reset_req_in15 (1'b0)                            // (terminated)
	);

endmodule