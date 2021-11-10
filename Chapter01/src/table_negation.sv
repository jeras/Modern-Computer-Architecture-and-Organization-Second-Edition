module table_negation();
  logic signed [8-1:0] v [0:5-1] = '{0,1,-1,127,-127};
  initial begin
    $display("| Decimal |   Binary    |     ~x      |     x+1     | -x=~x+1 |");
    $display("|---------|-------------|-------------|-------------|---------|");
    foreach (v[i]) begin
      $display("| %7d | 8'b%08b | 8'b%08b | 8'b%08b | %7d |",
               v[i], v[i], ~v[i], 8'(~v[i]+1), 8'(~v[i]+1));
    end
  end
endmodule: table_negation
