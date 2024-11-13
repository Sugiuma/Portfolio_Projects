<table>
  <tr>
    <th>SystemVerilog Code Snippet</th>
    <th>OOP Implementation Explanation</th>
  </tr>
  <tr>
    <td>

```systemverilog
interface add_if(input logic clk, reset);
  logic [7:0] ip1, ip2;
  logic [8:0] out;
endinterface

class transaction;
  rand bit [7:0] ip1, ip2;
  bit [8:0] out;
  constraint ip_c {ip1 < 100; ip2 < 100;}
endclass
