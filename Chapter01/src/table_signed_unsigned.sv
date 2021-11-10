module table_signed_unsigned();
  initial begin
    logic [8-1:0] v;
    $display("|   Binary    | Signed | Unsigned |");
    $display("|-------------|--------|----------|");
    for (int i=0; i<256; i++) begin
      v = i;
      $display("| 8'b%08b | %6d | %8d |", v, $signed(v), $unsigned(v));
    end
  end
endmodule: table_signed_unsigned
