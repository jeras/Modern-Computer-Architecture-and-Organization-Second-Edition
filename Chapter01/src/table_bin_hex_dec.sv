module table_bin_hex_dec();
  initial begin
    $display("| Binary  | Hex  | Decimal |");
    $display("|---------|------|---------|");
    for (int i=0; i<16; i++) begin
      $display("| 4'b%04b | 4'h%01X | %7d |", i, i, i);
    end
  end
endmodule: table_bin_hex_dec
