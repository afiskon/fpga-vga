/* vim: set ai et ts=4 sw=4: */

`default_nettype none

module top(
    input logic clkin, // input clock: 12 Mhz
    output logic hsync,
    output logic vsync,
    output logic [0:2] r,
    output logic [0:2] g,
    output logic [0:1] b,
    output logic D5 // green diode
    );

logic clk;

// 800x600 @ 56Hz

// 38.250 Mhz, see `icepll -i 12 -o 38`
SB_PLL40_CORE #(
    .FEEDBACK_PATH("SIMPLE"),
    .PLLOUT_SELECT("GENCLK"),
    .DIVR(4'b0000),
    .DIVF(7'b0110010),
    .DIVQ(3'b100),
    .FILTER_RANGE(3'b001),
) uut (
    .REFERENCECLK(clkin),
    .PLLOUTCORE(clk),
    .LOCK(D5), // keep this!
    .RESETB(1'b1),
    .BYPASS(1'b0)
);

parameter horiz_sync_pulse = 128;
parameter horiz_back_porch = 128;
parameter horiz_active_pixels = 800;
parameter horiz_front_porch = 32;

parameter vert_sync_pulse = 4;
parameter vert_back_porch = 14;
parameter vert_active_pixels = 600;
parameter vert_front_porch = 1;

parameter horiz_pixels = (horiz_sync_pulse + horiz_back_porch +
                          horiz_active_pixels + horiz_front_porch);
parameter horiz_vis_begin = (horiz_sync_pulse + horiz_back_porch);
parameter horiz_vis_end = (horiz_pixels - horiz_front_porch);

parameter vert_pixels = (vert_sync_pulse + vert_back_porch +
                         vert_active_pixels + vert_front_porch);
parameter vert_vis_begin = (vert_sync_pulse + vert_back_porch);
parameter vert_vis_end = (vert_pixels - vert_front_porch);

logic [11:0] hctr; // 12 bits will be enough for <= 1920x1080
logic [10:0] vctr; // 10 bits will be enough for <= 1920x1080

always_ff @(posedge clk)
begin
    if(hctr < horiz_pixels - 1)
    begin
        hctr <= hctr + 1;
    end
    else
    begin
        hctr <= 0;
        if(vctr < vert_pixels - 1)
        begin
            vctr <= vctr + 1;
        end
        else
        begin
            vctr <= 0;
        end
    end
end

assign hsync = (hctr < horiz_sync_pulse) ? 0 : 1;
assign vsync = (vctr < vert_sync_pulse) ? 0 : 1;

always_ff @(hctr, vctr)
begin
    if(hctr >= horiz_vis_begin && hctr < horiz_vis_end &&
       vctr >= vert_vis_begin  && vctr < vert_vis_end)
    begin
        // vvv generated code begin, see gen.py vvv

        if(hctr < (horiz_vis_begin + (horiz_active_pixels/16)*1))
        begin
            r[0] <= 0;
            r[1] <= 0;
            r[2] <= 0;
            g[0] <= 0;
        end
        else
        if(hctr < (horiz_vis_begin + (horiz_active_pixels/16)*2))
        begin
            r[0] <= 1;
            r[1] <= 0;
            r[2] <= 0;
            g[0] <= 0;
        end
        else
        if(hctr < (horiz_vis_begin + (horiz_active_pixels/16)*3))
        begin
            r[0] <= 0;
            r[1] <= 1;
            r[2] <= 0;
            g[0] <= 0;
        end
        else
        if(hctr < (horiz_vis_begin + (horiz_active_pixels/16)*4))
        begin
            r[0] <= 1;
            r[1] <= 1;
            r[2] <= 0;
            g[0] <= 0;
        end
        else
        if(hctr < (horiz_vis_begin + (horiz_active_pixels/16)*5))
        begin
            r[0] <= 0;
            r[1] <= 0;
            r[2] <= 1;
            g[0] <= 0;
        end
        else
        if(hctr < (horiz_vis_begin + (horiz_active_pixels/16)*6))
        begin
            r[0] <= 1;
            r[1] <= 0;
            r[2] <= 1;
            g[0] <= 0;
        end
        else
        if(hctr < (horiz_vis_begin + (horiz_active_pixels/16)*7))
        begin
            r[0] <= 0;
            r[1] <= 1;
            r[2] <= 1;
            g[0] <= 0;
        end
        else
        if(hctr < (horiz_vis_begin + (horiz_active_pixels/16)*8))
        begin
            r[0] <= 1;
            r[1] <= 1;
            r[2] <= 1;
            g[0] <= 0;
        end
        else
        if(hctr < (horiz_vis_begin + (horiz_active_pixels/16)*9))
        begin
            r[0] <= 0;
            r[1] <= 0;
            r[2] <= 0;
            g[0] <= 1;
        end
        else
        if(hctr < (horiz_vis_begin + (horiz_active_pixels/16)*10))
        begin
            r[0] <= 1;
            r[1] <= 0;
            r[2] <= 0;
            g[0] <= 1;
        end
        else
        if(hctr < (horiz_vis_begin + (horiz_active_pixels/16)*11))
        begin
            r[0] <= 0;
            r[1] <= 1;
            r[2] <= 0;
            g[0] <= 1;
        end
        else
        if(hctr < (horiz_vis_begin + (horiz_active_pixels/16)*12))
        begin
            r[0] <= 1;
            r[1] <= 1;
            r[2] <= 0;
            g[0] <= 1;
        end
        else
        if(hctr < (horiz_vis_begin + (horiz_active_pixels/16)*13))
        begin
            r[0] <= 0;
            r[1] <= 0;
            r[2] <= 1;
            g[0] <= 1;
        end
        else
        if(hctr < (horiz_vis_begin + (horiz_active_pixels/16)*14))
        begin
            r[0] <= 1;
            r[1] <= 0;
            r[2] <= 1;
            g[0] <= 1;
        end
        else
        if(hctr < (horiz_vis_begin + (horiz_active_pixels/16)*15))
        begin
            r[0] <= 0;
            r[1] <= 1;
            r[2] <= 1;
            g[0] <= 1;
        end
        else
        begin
            r[0] <= 1;
            r[1] <= 1;
            r[2] <= 1;
            g[0] <= 1;
        end
        if(vctr < (vert_vis_begin + (vert_active_pixels/16)*1))
        begin
            g[1] <= 0;
            g[2] <= 0;
            b[0] <= 0;
            b[1] <= 0;
        end
        else
        if(vctr < (vert_vis_begin + (vert_active_pixels/16)*2))
        begin
            g[1] <= 1;
            g[2] <= 0;
            b[0] <= 0;
            b[1] <= 0;
        end
        else
        if(vctr < (vert_vis_begin + (vert_active_pixels/16)*3))
        begin
            g[1] <= 0;
            g[2] <= 1;
            b[0] <= 0;
            b[1] <= 0;
        end
        else
        if(vctr < (vert_vis_begin + (vert_active_pixels/16)*4))
        begin
            g[1] <= 1;
            g[2] <= 1;
            b[0] <= 0;
            b[1] <= 0;
        end
        else
        if(vctr < (vert_vis_begin + (vert_active_pixels/16)*5))
        begin
            g[1] <= 0;
            g[2] <= 0;
            b[0] <= 1;
            b[1] <= 0;
        end
        else
        if(vctr < (vert_vis_begin + (vert_active_pixels/16)*6))
        begin
            g[1] <= 1;
            g[2] <= 0;
            b[0] <= 1;
            b[1] <= 0;
        end
        else
        if(vctr < (vert_vis_begin + (vert_active_pixels/16)*7))
        begin
            g[1] <= 0;
            g[2] <= 1;
            b[0] <= 1;
            b[1] <= 0;
        end
        else
        if(vctr < (vert_vis_begin + (vert_active_pixels/16)*8))
        begin
            g[1] <= 1;
            g[2] <= 1;
            b[0] <= 1;
            b[1] <= 0;
        end
        else
        if(vctr < (vert_vis_begin + (vert_active_pixels/16)*9))
        begin
            g[1] <= 0;
            g[2] <= 0;
            b[0] <= 0;
            b[1] <= 1;
        end
        else
        if(vctr < (vert_vis_begin + (vert_active_pixels/16)*10))
        begin
            g[1] <= 1;
            g[2] <= 0;
            b[0] <= 0;
            b[1] <= 1;
        end
        else
        if(vctr < (vert_vis_begin + (vert_active_pixels/16)*11))
        begin
            g[1] <= 0;
            g[2] <= 1;
            b[0] <= 0;
            b[1] <= 1;
        end
        else
        if(vctr < (vert_vis_begin + (vert_active_pixels/16)*12))
        begin
            g[1] <= 1;
            g[2] <= 1;
            b[0] <= 0;
            b[1] <= 1;
        end
        else
        if(vctr < (vert_vis_begin + (vert_active_pixels/16)*13))
        begin
            g[1] <= 0;
            g[2] <= 0;
            b[0] <= 1;
            b[1] <= 1;
        end
        else
        if(vctr < (vert_vis_begin + (vert_active_pixels/16)*14))
        begin
            g[1] <= 1;
            g[2] <= 0;
            b[0] <= 1;
            b[1] <= 1;
        end
        else
        if(vctr < (vert_vis_begin + (vert_active_pixels/16)*15))
        begin
            g[1] <= 0;
            g[2] <= 1;
            b[0] <= 1;
            b[1] <= 1;
        end
        else
        begin
            g[1] <= 1;
            g[2] <= 1;
            b[0] <= 1;
            b[1] <= 1;
        end

        // ^^^ generated code end, see gen.py ^^^
    end
    // currently no color will be displayed anyway
    else
    begin
        r[0:2] <= 0;
        g[0:2] <= 0;
        b[0:1] <= 0;
    end
end

endmodule
