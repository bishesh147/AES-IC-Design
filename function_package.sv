package function_package;
    function logic [31:0] rot_word(input logic[31:0] a);
        rot_word = {a[23:0], a[31:24]};
    endfunction

    function logic [31:0] sub_word(input logic[31:0] a);
        sub_word[31:24] = sub_byte(a[31:24]);
        sub_word[23:16] = sub_byte(a[23:16]);
        sub_word[15:8] = sub_byte(a[15:8]);
        sub_word[7:0] = sub_byte(a[7:0]);
    endfunction

    function logic [31:0] inverse_sub_word(input logic[31:0] a);
        inverse_sub_word[31:24] = inverse_sub_byte(a[31:24]);
        inverse_sub_word[23:16] = inverse_sub_byte(a[23:16]);
        inverse_sub_word[15:8] = inverse_sub_byte(a[15:8]);
        inverse_sub_word[7:0] = inverse_sub_byte(a[7:0]);
    endfunction

    function logic [7:0] galois_mult_2(input logic[7:0] a);
        galois_mult_2 = a[7] ? ((a << 1) ^ 8'b00011011) : (a << 1);
    endfunction

    function logic [7:0] galois_mult_3(input logic[7:0] a);
        galois_mult_3 = a ^ galois_mult_2(a);
    endfunction

    function logic [7:0] galois_mult_9(input logic[7:0] a);
        galois_mult_9 = a ^ galois_mult_2(galois_mult_2((galois_mult_2(a))));
    endfunction

    function logic [7:0] galois_mult_11(input logic[7:0] a);
        galois_mult_11 = a ^ galois_mult_2(a ^ galois_mult_2(galois_mult_2(a)));
    endfunction

    function logic [7:0] galois_mult_13(input logic[7:0] a);
        galois_mult_13 = a ^ galois_mult_2(galois_mult_2(a ^ galois_mult_2(a)));
    endfunction

    function logic [7:0] galois_mult_14(input logic[7:0] a);
        galois_mult_14 = galois_mult_2(a ^ galois_mult_2(a ^ galois_mult_2(a)));
    endfunction

    function logic [7:0] sub_byte(input logic[7:0] a);
        case (a)
            8'h00: sub_byte=8'h63;
            8'h01: sub_byte=8'h7c;
            8'h02: sub_byte=8'h77;
            8'h03: sub_byte=8'h7b;
            8'h04: sub_byte=8'hf2;
            8'h05: sub_byte=8'h6b;
            8'h06: sub_byte=8'h6f;
            8'h07: sub_byte=8'hc5;
            8'h08: sub_byte=8'h30;
            8'h09: sub_byte=8'h01;
            8'h0a: sub_byte=8'h67;
            8'h0b: sub_byte=8'h2b;
            8'h0c: sub_byte=8'hfe;
            8'h0d: sub_byte=8'hd7;
            8'h0e: sub_byte=8'hab;
            8'h0f: sub_byte=8'h76;
            8'h10: sub_byte=8'hca;
            8'h11: sub_byte=8'h82;
            8'h12: sub_byte=8'hc9;
            8'h13: sub_byte=8'h7d;
            8'h14: sub_byte=8'hfa;
            8'h15: sub_byte=8'h59;
            8'h16: sub_byte=8'h47;
            8'h17: sub_byte=8'hf0;
            8'h18: sub_byte=8'had;
            8'h19: sub_byte=8'hd4;
            8'h1a: sub_byte=8'ha2;
            8'h1b: sub_byte=8'haf;
            8'h1c: sub_byte=8'h9c;
            8'h1d: sub_byte=8'ha4;
            8'h1e: sub_byte=8'h72;
            8'h1f: sub_byte=8'hc0;
            8'h20: sub_byte=8'hb7;
            8'h21: sub_byte=8'hfd;
            8'h22: sub_byte=8'h93;
            8'h23: sub_byte=8'h26;
            8'h24: sub_byte=8'h36;
            8'h25: sub_byte=8'h3f;
            8'h26: sub_byte=8'hf7;
            8'h27: sub_byte=8'hcc;
            8'h28: sub_byte=8'h34;
            8'h29: sub_byte=8'ha5;
            8'h2a: sub_byte=8'he5;
            8'h2b: sub_byte=8'hf1;
            8'h2c: sub_byte=8'h71;
            8'h2d: sub_byte=8'hd8;
            8'h2e: sub_byte=8'h31;
            8'h2f: sub_byte=8'h15;
            8'h30: sub_byte=8'h04;
            8'h31: sub_byte=8'hc7;
            8'h32: sub_byte=8'h23;
            8'h33: sub_byte=8'hc3;
            8'h34: sub_byte=8'h18;
            8'h35: sub_byte=8'h96;
            8'h36: sub_byte=8'h05;
            8'h37: sub_byte=8'h9a;
            8'h38: sub_byte=8'h07;
            8'h39: sub_byte=8'h12;
            8'h3a: sub_byte=8'h80;
            8'h3b: sub_byte=8'he2;
            8'h3c: sub_byte=8'heb;
            8'h3d: sub_byte=8'h27;
            8'h3e: sub_byte=8'hb2;
            8'h3f: sub_byte=8'h75;
            8'h40: sub_byte=8'h09;
            8'h41: sub_byte=8'h83;
            8'h42: sub_byte=8'h2c;
            8'h43: sub_byte=8'h1a;
            8'h44: sub_byte=8'h1b;
            8'h45: sub_byte=8'h6e;
            8'h46: sub_byte=8'h5a;
            8'h47: sub_byte=8'ha0;
            8'h48: sub_byte=8'h52;
            8'h49: sub_byte=8'h3b;
            8'h4a: sub_byte=8'hd6;
            8'h4b: sub_byte=8'hb3;
            8'h4c: sub_byte=8'h29;
            8'h4d: sub_byte=8'he3;
            8'h4e: sub_byte=8'h2f;
            8'h4f: sub_byte=8'h84;
            8'h50: sub_byte=8'h53;
            8'h51: sub_byte=8'hd1;
            8'h52: sub_byte=8'h00;
            8'h53: sub_byte=8'hed;
            8'h54: sub_byte=8'h20;
            8'h55: sub_byte=8'hfc;
            8'h56: sub_byte=8'hb1;
            8'h57: sub_byte=8'h5b;
            8'h58: sub_byte=8'h6a;
            8'h59: sub_byte=8'hcb;
            8'h5a: sub_byte=8'hbe;
            8'h5b: sub_byte=8'h39;
            8'h5c: sub_byte=8'h4a;
            8'h5d: sub_byte=8'h4c;
            8'h5e: sub_byte=8'h58;
            8'h5f: sub_byte=8'hcf;
            8'h60: sub_byte=8'hd0;
            8'h61: sub_byte=8'hef;
            8'h62: sub_byte=8'haa;
            8'h63: sub_byte=8'hfb;
            8'h64: sub_byte=8'h43;
            8'h65: sub_byte=8'h4d;
            8'h66: sub_byte=8'h33;
            8'h67: sub_byte=8'h85;
            8'h68: sub_byte=8'h45;
            8'h69: sub_byte=8'hf9;
            8'h6a: sub_byte=8'h02;
            8'h6b: sub_byte=8'h7f;
            8'h6c: sub_byte=8'h50;
            8'h6d: sub_byte=8'h3c;
            8'h6e: sub_byte=8'h9f;
            8'h6f: sub_byte=8'ha8;
            8'h70: sub_byte=8'h51;
            8'h71: sub_byte=8'ha3;
            8'h72: sub_byte=8'h40;
            8'h73: sub_byte=8'h8f;
            8'h74: sub_byte=8'h92;
            8'h75: sub_byte=8'h9d;
            8'h76: sub_byte=8'h38;
            8'h77: sub_byte=8'hf5;
            8'h78: sub_byte=8'hbc;
            8'h79: sub_byte=8'hb6;
            8'h7a: sub_byte=8'hda;
            8'h7b: sub_byte=8'h21;
            8'h7c: sub_byte=8'h10;
            8'h7d: sub_byte=8'hff;
            8'h7e: sub_byte=8'hf3;
            8'h7f: sub_byte=8'hd2;
            8'h80: sub_byte=8'hcd;
            8'h81: sub_byte=8'h0c;
            8'h82: sub_byte=8'h13;
            8'h83: sub_byte=8'hec;
            8'h84: sub_byte=8'h5f;
            8'h85: sub_byte=8'h97;
            8'h86: sub_byte=8'h44;
            8'h87: sub_byte=8'h17;
            8'h88: sub_byte=8'hc4;
            8'h89: sub_byte=8'ha7;
            8'h8a: sub_byte=8'h7e;
            8'h8b: sub_byte=8'h3d;
            8'h8c: sub_byte=8'h64;
            8'h8d: sub_byte=8'h5d;
            8'h8e: sub_byte=8'h19;
            8'h8f: sub_byte=8'h73;
            8'h90: sub_byte=8'h60;
            8'h91: sub_byte=8'h81;
            8'h92: sub_byte=8'h4f;
            8'h93: sub_byte=8'hdc;
            8'h94: sub_byte=8'h22;
            8'h95: sub_byte=8'h2a;
            8'h96: sub_byte=8'h90;
            8'h97: sub_byte=8'h88;
            8'h98: sub_byte=8'h46;
            8'h99: sub_byte=8'hee;
            8'h9a: sub_byte=8'hb8;
            8'h9b: sub_byte=8'h14;
            8'h9c: sub_byte=8'hde;
            8'h9d: sub_byte=8'h5e;
            8'h9e: sub_byte=8'h0b;
            8'h9f: sub_byte=8'hdb;
            8'ha0: sub_byte=8'he0;
            8'ha1: sub_byte=8'h32;
            8'ha2: sub_byte=8'h3a;
            8'ha3: sub_byte=8'h0a;
            8'ha4: sub_byte=8'h49;
            8'ha5: sub_byte=8'h06;
            8'ha6: sub_byte=8'h24;
            8'ha7: sub_byte=8'h5c;
            8'ha8: sub_byte=8'hc2;
            8'ha9: sub_byte=8'hd3;
            8'haa: sub_byte=8'hac;
            8'hab: sub_byte=8'h62;
            8'hac: sub_byte=8'h91;
            8'had: sub_byte=8'h95;
            8'hae: sub_byte=8'he4;
            8'haf: sub_byte=8'h79;
            8'hb0: sub_byte=8'he7;
            8'hb1: sub_byte=8'hc8;
            8'hb2: sub_byte=8'h37;
            8'hb3: sub_byte=8'h6d;
            8'hb4: sub_byte=8'h8d;
            8'hb5: sub_byte=8'hd5;
            8'hb6: sub_byte=8'h4e;
            8'hb7: sub_byte=8'ha9;
            8'hb8: sub_byte=8'h6c;
            8'hb9: sub_byte=8'h56;
            8'hba: sub_byte=8'hf4;
            8'hbb: sub_byte=8'hea;
            8'hbc: sub_byte=8'h65;
            8'hbd: sub_byte=8'h7a;
            8'hbe: sub_byte=8'hae;
            8'hbf: sub_byte=8'h08;
            8'hc0: sub_byte=8'hba;
            8'hc1: sub_byte=8'h78;
            8'hc2: sub_byte=8'h25;
            8'hc3: sub_byte=8'h2e;
            8'hc4: sub_byte=8'h1c;
            8'hc5: sub_byte=8'ha6;
            8'hc6: sub_byte=8'hb4;
            8'hc7: sub_byte=8'hc6;
            8'hc8: sub_byte=8'he8;
            8'hc9: sub_byte=8'hdd;
            8'hca: sub_byte=8'h74;
            8'hcb: sub_byte=8'h1f;
            8'hcc: sub_byte=8'h4b;
            8'hcd: sub_byte=8'hbd;
            8'hce: sub_byte=8'h8b;
            8'hcf: sub_byte=8'h8a;
            8'hd0: sub_byte=8'h70;
            8'hd1: sub_byte=8'h3e;
            8'hd2: sub_byte=8'hb5;
            8'hd3: sub_byte=8'h66;
            8'hd4: sub_byte=8'h48;
            8'hd5: sub_byte=8'h03;
            8'hd6: sub_byte=8'hf6;
            8'hd7: sub_byte=8'h0e;
            8'hd8: sub_byte=8'h61;
            8'hd9: sub_byte=8'h35;
            8'hda: sub_byte=8'h57;
            8'hdb: sub_byte=8'hb9;
            8'hdc: sub_byte=8'h86;
            8'hdd: sub_byte=8'hc1;
            8'hde: sub_byte=8'h1d;
            8'hdf: sub_byte=8'h9e;
            8'he0: sub_byte=8'he1;
            8'he1: sub_byte=8'hf8;
            8'he2: sub_byte=8'h98;
            8'he3: sub_byte=8'h11;
            8'he4: sub_byte=8'h69;
            8'he5: sub_byte=8'hd9;
            8'he6: sub_byte=8'h8e;
            8'he7: sub_byte=8'h94;
            8'he8: sub_byte=8'h9b;
            8'he9: sub_byte=8'h1e;
            8'hea: sub_byte=8'h87;
            8'heb: sub_byte=8'he9;
            8'hec: sub_byte=8'hce;
            8'hed: sub_byte=8'h55;
            8'hee: sub_byte=8'h28;
            8'hef: sub_byte=8'hdf;
            8'hf0: sub_byte=8'h8c;
            8'hf1: sub_byte=8'ha1;
            8'hf2: sub_byte=8'h89;
            8'hf3: sub_byte=8'h0d;
            8'hf4: sub_byte=8'hbf;
            8'hf5: sub_byte=8'he6;
            8'hf6: sub_byte=8'h42;
            8'hf7: sub_byte=8'h68;
            8'hf8: sub_byte=8'h41;
            8'hf9: sub_byte=8'h99;
            8'hfa: sub_byte=8'h2d;
            8'hfb: sub_byte=8'h0f;
            8'hfc: sub_byte=8'hb0;
            8'hfd: sub_byte=8'h54;
            8'hfe: sub_byte=8'hbb;
            8'hff: sub_byte=8'h16;
	    endcase
    endfunction

    function logic [7:0] inverse_sub_byte(input logic[7:0] a);
        case (a)
            8'h63: inverse_sub_byte=8'h00;
            8'h7c: inverse_sub_byte=8'h01;
            8'h77: inverse_sub_byte=8'h02;
            8'h7b: inverse_sub_byte=8'h03;
            8'hf2: inverse_sub_byte=8'h04;
            8'h6b: inverse_sub_byte=8'h05;
            8'h6f: inverse_sub_byte=8'h06;
            8'hc5: inverse_sub_byte=8'h07;
            8'h30: inverse_sub_byte=8'h08;
            8'h01: inverse_sub_byte=8'h09;
            8'h67: inverse_sub_byte=8'h0a;
            8'h2b: inverse_sub_byte=8'h0b;
            8'hfe: inverse_sub_byte=8'h0c;
            8'hd7: inverse_sub_byte=8'h0d;
            8'hab: inverse_sub_byte=8'h0e;
            8'h76: inverse_sub_byte=8'h0f;
            8'hca: inverse_sub_byte=8'h10;
            8'h82: inverse_sub_byte=8'h11;
            8'hc9: inverse_sub_byte=8'h12;
            8'h7d: inverse_sub_byte=8'h13;
            8'hfa: inverse_sub_byte=8'h14;
            8'h59: inverse_sub_byte=8'h15;
            8'h47: inverse_sub_byte=8'h16;
            8'hf0: inverse_sub_byte=8'h17;
            8'had: inverse_sub_byte=8'h18;
            8'hd4: inverse_sub_byte=8'h19;
            8'ha2: inverse_sub_byte=8'h1a;
            8'haf: inverse_sub_byte=8'h1b;
            8'h9c: inverse_sub_byte=8'h1c;
            8'ha4: inverse_sub_byte=8'h1d;
            8'h72: inverse_sub_byte=8'h1e;
            8'hc0: inverse_sub_byte=8'h1f;
            8'hb7: inverse_sub_byte=8'h20;
            8'hfd: inverse_sub_byte=8'h21;
            8'h93: inverse_sub_byte=8'h22;
            8'h26: inverse_sub_byte=8'h23;
            8'h36: inverse_sub_byte=8'h24;
            8'h3f: inverse_sub_byte=8'h25;
            8'hf7: inverse_sub_byte=8'h26;
            8'hcc: inverse_sub_byte=8'h27;
            8'h34: inverse_sub_byte=8'h28;
            8'ha5: inverse_sub_byte=8'h29;
            8'he5: inverse_sub_byte=8'h2a;
            8'hf1: inverse_sub_byte=8'h2b;
            8'h71: inverse_sub_byte=8'h2c;
            8'hd8: inverse_sub_byte=8'h2d;
            8'h31: inverse_sub_byte=8'h2e;
            8'h15: inverse_sub_byte=8'h2f;
            8'h04: inverse_sub_byte=8'h30;
            8'hc7: inverse_sub_byte=8'h31;
            8'h23: inverse_sub_byte=8'h32;
            8'hc3: inverse_sub_byte=8'h33;
            8'h18: inverse_sub_byte=8'h34;
            8'h96: inverse_sub_byte=8'h35;
            8'h05: inverse_sub_byte=8'h36;
            8'h9a: inverse_sub_byte=8'h37;
            8'h07: inverse_sub_byte=8'h38;
            8'h12: inverse_sub_byte=8'h39;
            8'h80: inverse_sub_byte=8'h3a;
            8'he2: inverse_sub_byte=8'h3b;
            8'heb: inverse_sub_byte=8'h3c;
            8'h27: inverse_sub_byte=8'h3d;
            8'hb2: inverse_sub_byte=8'h3e;
            8'h75: inverse_sub_byte=8'h3f;
            8'h09: inverse_sub_byte=8'h40;
            8'h83: inverse_sub_byte=8'h41;
            8'h2c: inverse_sub_byte=8'h42;
            8'h1a: inverse_sub_byte=8'h43;
            8'h1b: inverse_sub_byte=8'h44;
            8'h6e: inverse_sub_byte=8'h45;
            8'h5a: inverse_sub_byte=8'h46;
            8'ha0: inverse_sub_byte=8'h47;
            8'h52: inverse_sub_byte=8'h48;
            8'h3b: inverse_sub_byte=8'h49;
            8'hd6: inverse_sub_byte=8'h4a;
            8'hb3: inverse_sub_byte=8'h4b;
            8'h29: inverse_sub_byte=8'h4c;
            8'he3: inverse_sub_byte=8'h4d;
            8'h2f: inverse_sub_byte=8'h4e;
            8'h84: inverse_sub_byte=8'h4f;
            8'h53: inverse_sub_byte=8'h50;
            8'hd1: inverse_sub_byte=8'h51;
            8'h00: inverse_sub_byte=8'h52;
            8'hed: inverse_sub_byte=8'h53;
            8'h20: inverse_sub_byte=8'h54;
            8'hfc: inverse_sub_byte=8'h55;
            8'hb1: inverse_sub_byte=8'h56;
            8'h5b: inverse_sub_byte=8'h57;
            8'h6a: inverse_sub_byte=8'h58;
            8'hcb: inverse_sub_byte=8'h59;
            8'hbe: inverse_sub_byte=8'h5a;
            8'h39: inverse_sub_byte=8'h5b;
            8'h4a: inverse_sub_byte=8'h5c;
            8'h4c: inverse_sub_byte=8'h5d;
            8'h58: inverse_sub_byte=8'h5e;
            8'hcf: inverse_sub_byte=8'h5f;
            8'hd0: inverse_sub_byte=8'h60;
            8'hef: inverse_sub_byte=8'h61;
            8'haa: inverse_sub_byte=8'h62;
            8'hfb: inverse_sub_byte=8'h63;
            8'h43: inverse_sub_byte=8'h64;
            8'h4d: inverse_sub_byte=8'h65;
            8'h33: inverse_sub_byte=8'h66;
            8'h85: inverse_sub_byte=8'h67;
            8'h45: inverse_sub_byte=8'h68;
            8'hf9: inverse_sub_byte=8'h69;
            8'h02: inverse_sub_byte=8'h6a;
            8'h7f: inverse_sub_byte=8'h6b;
            8'h50: inverse_sub_byte=8'h6c;
            8'h3c: inverse_sub_byte=8'h6d;
            8'h9f: inverse_sub_byte=8'h6e;
            8'ha8: inverse_sub_byte=8'h6f;
            8'h51: inverse_sub_byte=8'h70;
            8'ha3: inverse_sub_byte=8'h71;
            8'h40: inverse_sub_byte=8'h72;
            8'h8f: inverse_sub_byte=8'h73;
            8'h92: inverse_sub_byte=8'h74;
            8'h9d: inverse_sub_byte=8'h75;
            8'h38: inverse_sub_byte=8'h76;
            8'hf5: inverse_sub_byte=8'h77;
            8'hbc: inverse_sub_byte=8'h78;
            8'hb6: inverse_sub_byte=8'h79;
            8'hda: inverse_sub_byte=8'h7a;
            8'h21: inverse_sub_byte=8'h7b;
            8'h10: inverse_sub_byte=8'h7c;
            8'hff: inverse_sub_byte=8'h7d;
            8'hf3: inverse_sub_byte=8'h7e;
            8'hd2: inverse_sub_byte=8'h7f;
            8'hcd: inverse_sub_byte=8'h80;
            8'h0c: inverse_sub_byte=8'h81;
            8'h13: inverse_sub_byte=8'h82;
            8'hec: inverse_sub_byte=8'h83;
            8'h5f: inverse_sub_byte=8'h84;
            8'h97: inverse_sub_byte=8'h85;
            8'h44: inverse_sub_byte=8'h86;
            8'h17: inverse_sub_byte=8'h87;
            8'hc4: inverse_sub_byte=8'h88;
            8'ha7: inverse_sub_byte=8'h89;
            8'h7e: inverse_sub_byte=8'h8a;
            8'h3d: inverse_sub_byte=8'h8b;
            8'h64: inverse_sub_byte=8'h8c;
            8'h5d: inverse_sub_byte=8'h8d;
            8'h19: inverse_sub_byte=8'h8e;
            8'h73: inverse_sub_byte=8'h8f;
            8'h60: inverse_sub_byte=8'h90;
            8'h81: inverse_sub_byte=8'h91;
            8'h4f: inverse_sub_byte=8'h92;
            8'hdc: inverse_sub_byte=8'h93;
            8'h22: inverse_sub_byte=8'h94;
            8'h2a: inverse_sub_byte=8'h95;
            8'h90: inverse_sub_byte=8'h96;
            8'h88: inverse_sub_byte=8'h97;
            8'h46: inverse_sub_byte=8'h98;
            8'hee: inverse_sub_byte=8'h99;
            8'hb8: inverse_sub_byte=8'h9a;
            8'h14: inverse_sub_byte=8'h9b;
            8'hde: inverse_sub_byte=8'h9c;
            8'h5e: inverse_sub_byte=8'h9d;
            8'h0b: inverse_sub_byte=8'h9e;
            8'hdb: inverse_sub_byte=8'h9f;
            8'he0: inverse_sub_byte=8'ha0;
            8'h32: inverse_sub_byte=8'ha1;
            8'h3a: inverse_sub_byte=8'ha2;
            8'h0a: inverse_sub_byte=8'ha3;
            8'h49: inverse_sub_byte=8'ha4;
            8'h06: inverse_sub_byte=8'ha5;
            8'h24: inverse_sub_byte=8'ha6;
            8'h5c: inverse_sub_byte=8'ha7;
            8'hc2: inverse_sub_byte=8'ha8;
            8'hd3: inverse_sub_byte=8'ha9;
            8'hac: inverse_sub_byte=8'haa;
            8'h62: inverse_sub_byte=8'hab;
            8'h91: inverse_sub_byte=8'hac;
            8'h95: inverse_sub_byte=8'had;
            8'he4: inverse_sub_byte=8'hae;
            8'h79: inverse_sub_byte=8'haf;
            8'he7: inverse_sub_byte=8'hb0;
            8'hc8: inverse_sub_byte=8'hb1;
            8'h37: inverse_sub_byte=8'hb2;
            8'h6d: inverse_sub_byte=8'hb3;
            8'h8d: inverse_sub_byte=8'hb4;
            8'hd5: inverse_sub_byte=8'hb5;
            8'h4e: inverse_sub_byte=8'hb6;
            8'ha9: inverse_sub_byte=8'hb7;
            8'h6c: inverse_sub_byte=8'hb8;
            8'h56: inverse_sub_byte=8'hb9;
            8'hf4: inverse_sub_byte=8'hba;
            8'hea: inverse_sub_byte=8'hbb;
            8'h65: inverse_sub_byte=8'hbc;
            8'h7a: inverse_sub_byte=8'hbd;
            8'hae: inverse_sub_byte=8'hbe;
            8'h08: inverse_sub_byte=8'hbf;
            8'hba: inverse_sub_byte=8'hc0;
            8'h78: inverse_sub_byte=8'hc1;
            8'h25: inverse_sub_byte=8'hc2;
            8'h2e: inverse_sub_byte=8'hc3;
            8'h1c: inverse_sub_byte=8'hc4;
            8'ha6: inverse_sub_byte=8'hc5;
            8'hb4: inverse_sub_byte=8'hc6;
            8'hc6: inverse_sub_byte=8'hc7;
            8'he8: inverse_sub_byte=8'hc8;
            8'hdd: inverse_sub_byte=8'hc9;
            8'h74: inverse_sub_byte=8'hca;
            8'h1f: inverse_sub_byte=8'hcb;
            8'h4b: inverse_sub_byte=8'hcc;
            8'hbd: inverse_sub_byte=8'hcd;
            8'h8b: inverse_sub_byte=8'hce;
            8'h8a: inverse_sub_byte=8'hcf;
            8'h70: inverse_sub_byte=8'hd0;
            8'h3e: inverse_sub_byte=8'hd1;
            8'hb5: inverse_sub_byte=8'hd2;
            8'h66: inverse_sub_byte=8'hd3;
            8'h48: inverse_sub_byte=8'hd4;
            8'h03: inverse_sub_byte=8'hd5;
            8'hf6: inverse_sub_byte=8'hd6;
            8'h0e: inverse_sub_byte=8'hd7;
            8'h61: inverse_sub_byte=8'hd8;
            8'h35: inverse_sub_byte=8'hd9;
            8'h57: inverse_sub_byte=8'hda;
            8'hb9: inverse_sub_byte=8'hdb;
            8'h86: inverse_sub_byte=8'hdc;
            8'hc1: inverse_sub_byte=8'hdd;
            8'h1d: inverse_sub_byte=8'hde;
            8'h9e: inverse_sub_byte=8'hdf;
            8'he1: inverse_sub_byte=8'he0;
            8'hf8: inverse_sub_byte=8'he1;
            8'h98: inverse_sub_byte=8'he2;
            8'h11: inverse_sub_byte=8'he3;
            8'h69: inverse_sub_byte=8'he4;
            8'hd9: inverse_sub_byte=8'he5;
            8'h8e: inverse_sub_byte=8'he6;
            8'h94: inverse_sub_byte=8'he7;
            8'h9b: inverse_sub_byte=8'he8;
            8'h1e: inverse_sub_byte=8'he9;
            8'h87: inverse_sub_byte=8'hea;
            8'he9: inverse_sub_byte=8'heb;
            8'hce: inverse_sub_byte=8'hec;
            8'h55: inverse_sub_byte=8'hed;
            8'h28: inverse_sub_byte=8'hee;
            8'hdf: inverse_sub_byte=8'hef;
            8'h8c: inverse_sub_byte=8'hf0;
            8'ha1: inverse_sub_byte=8'hf1;
            8'h89: inverse_sub_byte=8'hf2;
            8'h0d: inverse_sub_byte=8'hf3;
            8'hbf: inverse_sub_byte=8'hf4;
            8'he6: inverse_sub_byte=8'hf5;
            8'h42: inverse_sub_byte=8'hf6;
            8'h68: inverse_sub_byte=8'hf7;
            8'h41: inverse_sub_byte=8'hf8;
            8'h99: inverse_sub_byte=8'hf9;
            8'h2d: inverse_sub_byte=8'hfa;
            8'h0f: inverse_sub_byte=8'hfb;
            8'hb0: inverse_sub_byte=8'hfc;
            8'h54: inverse_sub_byte=8'hfd;
            8'hbb: inverse_sub_byte=8'hfe;
            8'h16: inverse_sub_byte=8'hff;
	    endcase
    endfunction

    logic [31:0] rst_round_keys[0:63] = '{
        32'h603DEB10,
        32'h15CA71BE,
        32'h2B73AEF0,
        32'h857D7781,
        32'h1F352C07,
        32'h3B6108D7,
        32'h2D9810A3,
        32'h0914DFF4,
        32'h9BA35411,
        32'h8E6925AF,
        32'hA51A8B5F,
        32'h2067FCDE,
        32'hA8B09C1A,
        32'h93D194CD,
        32'hBE49846E,
        32'hB75D5B9A,
        32'hD59AECB8,
        32'h5BF3C917,
        32'hFEE94248,
        32'hDE8EBE96,
        32'hB5A9328A,
        32'h2678A647,
        32'h98312229,
        32'h2F6C79B3,
        32'h812C81AD,
        32'hDADF48BA,
        32'h24360AF2,
        32'hFAB8B464,
        32'h98C5BFC9,
        32'hBEBD198E,
        32'h268C3BA7,
        32'h09E04214,
        32'h68007BAC,
        32'hB2DF3316,
        32'h96E939E4,
        32'h6C518D80,
        32'hC814E204,
        32'h76A9FB8A,
        32'h5025C02D,
        32'h59C58239,
        32'hDE136967,
        32'h6CCC5A71,
        32'hFA256395,
        32'h9674EE15,
        32'h5886CA5D,
        32'h2E2F31D7,
        32'h7E0AF1FA,
        32'h27CF73C3,
        32'h749C47AB,
        32'h18501DDA,
        32'hE2757E4F,
        32'h7401905A,
        32'hCAFAAAE3,
        32'hE4D59B34,
        32'h9ADF6ACE,
        32'hBD10190D,
        32'hFE4890D1,
        32'hE6188D0B,
        32'h046DF344,
        32'h706C631E,
        32'h9BAA5191,
        32'h7F7FCAA5,
        32'hE5A0A06B,
        32'h58B0B966
    };

    logic [31:0] rcon_vals[0:9] = '{
        32'h01000000,
        32'h02000000,
        32'h04000000,
        32'h08000000,
        32'h10000000,
        32'h20000000,
        32'h40000000,
        32'h80000000,
        32'h1B000000,
        32'h36000000
    };

endpackage : function_package
