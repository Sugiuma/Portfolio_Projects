| SystemVerilog Testbench Code Snippet | OOP Implementation Explanation |
|--------------------------------------|--------------------------------|
| ```systemverilog
interface add_if(input logic clk, reset);
  logic [7:0] ip1, ip2;
  logic [8:0] out;
endinterface
``` | **Encapsulation**: The `add_if` interface encapsulates signals `ip1`, `ip2`, and `out`, as well as `clk` and `reset`, simplifying connections to the DUT by grouping related signals. |
| ```systemverilog
class transaction;
  rand bit [7:0] ip1, ip2;
  bit [8:0] out;
  constraint ip_c {ip1 < 100; ip2 < 100;}
endclass
``` | **Encapsulation & Randomization**: The `transaction` class encapsulates inputs and outputs, along with constraints for randomization. Constrained random values for `ip1` and `ip2` support effective test coverage while maintaining data hiding within the class. |
| ```systemverilog
class generator;
  int count;
  mailbox gen_to_drv;
  transaction tr;
  function new(mailbox gen_to_drv);
    this.gen_to_drv = gen_to_drv;
  endfunction
  task run;
    repeat(count) begin
      tr = new();
      void'(tr.randomize());
      gen_to_drv.put(tr);
    end
  endtask
endclass
``` | **Abstraction & Constructor Usage**: The `generator` class abstracts transaction generation with the `run` task handling repetitive random transaction creation, while `new` initializes the mailbox for inter-class communication, encapsulating behavior within the class. |
| ```systemverilog
class driver;
  virtual add_if vif;
  mailbox gen_to_drv;
  transaction tr;
  function new(mailbox gen_to_drv, virtual add_if vif);
    this.gen_to_drv = gen_to_drv;
    this.vif = vif;
  endfunction
  task run;
    forever begin
      @(posedge vif.clk);
      gen_to_drv.get(tr);
      vif.ip1 <= tr.ip1;
      vif.ip2 <= tr.ip2;
      @(posedge vif.clk);
      tr.out <= vif.out;
    end
  endtask
endclass
``` | **Abstraction & Constructor Usage**: The `driver` class abstracts signal driving, using `run` to handle continuous driving of signals to the DUT. The constructor `new` links `vif` (interface) and `gen_to_drv` mailbox for communication, establishing modular driver behavior. |
| ```systemverilog
class monitor;
  virtual add_if vif;
  mailbox mon_to_sb;
  function new(mailbox mon_to_sb, virtual add_if vif);
    this.vif = vif;
    this.mon_to_sb = mon_to_sb;
  endfunction
  task run;
    forever begin
      transaction mon_tr;
      wait(!vif.reset);
      @(posedge vif.clk);
      mon_tr = new();
      mon_tr.ip1 = vif.ip1;
      mon_tr.ip2 = vif.ip2;
      @(posedge vif.clk);
      mon_tr.out = vif.out;
      mon_to_sb.put(mon_tr);
    end
  endtask
endclass
``` | **Abstraction**: The `monitor` class abstracts signal monitoring, capturing DUT output into a transaction and sending it to the scoreboard. Tasks like `run` allow the monitor to operate without exposing inner workings to other testbench components. |
| ```systemverilog
class agent;
  driver drv;
  monitor mon;
  generator gen;
  mailbox gen_to_drv;
  virtual add_if vif;
  function new(virtual add_if vif, mailbox mon_to_sb);
    gen_to_drv = new();
    drv = new(gen_to_drv, vif);
    mon = new(mon_to_sb, vif);
    gen = new(gen_to_drv);
  endfunction
  task run();
    fork
      drv.run();
      mon.run();
      gen.run();
    join_any
  endtask
endclass
``` | **Modularity & Concurrency**: The `agent` class groups related `driver`, `monitor`, and `generator` classes, managing their concurrent operations via `fork...join_any` in `run`, making the testbench modular and organized. |
| ```systemverilog
class scoreboard;
  int compare_cnt;
  mailbox mon_to_sb;
  function new(mailbox mon_to_sb);
    this.mon_to_sb = mon_to_sb;
  endfunction
  task run;
    forever begin
      transaction tr;
      mon_to_sb.get(tr);
      if(tr.ip1 + tr.ip2 == tr.out) begin
        $display("Matched: ip1 = %0d, ip2 = %0d, out = %0d", tr.ip1, tr.ip2, tr.out);
      end else begin
        $display("NOT matched: ip1 = %0d, ip2 = %0d, out = %0d", tr.ip1, tr.ip2, tr.out);
      end
      compare_cnt++;
    end
  endtask
endclass
``` | **Modularity & Validation**: The `scoreboard` class modularly handles validation by checking if `ip1 + ip2 == out`. It increments `compare_cnt` for each match, isolating validation logic, and simplifying testbench debugging and analysis. |
| ```systemverilog
class env;
  agent agt;
  scoreboard sb;
  mailbox mon_to_sb;
  function new(virtual add_if vif);
    mon_to_sb = new();
    agt = new(vif, mon_to_sb);
    sb = new(mon_to_sb);
  endfunction
  task run();
    fork
      agt.run();
      sb.run();
    join_any
    wait(agt.gen.count == sb.compare_cnt);
    $finish;
  endtask
endclass
``` | **Abstraction & Modularity**: The `env` class abstracts the complete testbench setup, instantiating `agent` and `scoreboard`. The `run` task coordinates these components and completes the simulation when the generator and scoreboard counts match, ensuring a cohesive and maintainable testbench design. |
