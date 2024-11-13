<table>
  <tr>
    <th>SystemVerilog Code Snippet</th>
    <th>OOP Implementation Explanation</th>
  </tr>
  <tr>
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

</td>

<td>
  <strong>Encapsulation</strong>:  
  The <code>add_if</code> interface encapsulates signals <code>ip1</code>, <code>ip2</code>, and <code>out</code>, along with <code>clk</code> and <code>reset</code>, simplifying DUT connections by grouping related signals. The <code>transaction</code> class encapsulates inputs and outputs, with constraints for randomization that enable constrained random testing and data hiding within the class.
</td>
</tr>
