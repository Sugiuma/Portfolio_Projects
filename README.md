| SystemVerilog Testbench Code Snippet | OOP Implementation Explanation |
|--------------------------------------|--------------------------------|
| ```systemverilog interface add_if(input logic clk, reset); logic [7:0] ip1, ip2;  logic [8:0] out; endinterface``` | **Encapsulation**: The `add_if` interface encapsulates signals `ip1`, `ip2`, and `out`, as well as `clk` and `reset`, simplifying connections to the DUT by grouping related signals. |
| ```systemverilog<br>class transaction;<br>  rand bit [7:0] ip1, ip2;<br>  bit [8:0] out;<br>  constraint ip_c {ip1 < 100; ip2 < 100;}<br>endclass``` | **Encapsulation & Randomization**: The `transaction` class encapsulates inputs and outputs, along with constraints for randomization. Constrained random values for `ip1` and `ip2` support effective test coverage while maintaining data hiding within the class. |
| ```systemverilog<br>class generator;<br>  int count;<br>  mailbox gen_to_drv;<br>  transaction tr;<br>  function new(mailbox gen_to_drv);<br>    this.gen_to_drv = gen_to_drv;<br>  endfunction<br>  task run;<br>    repeat(count) begin<br>      tr = new();<br>      void'(tr.randomize());<br>      gen_to_drv.put(tr);<br>    end<br>  endtask<br>endclass``` | **Abstraction & Constructor Usage**: The `generator` class abstracts transaction generation with the `run` task handling repetitive random transaction creation, while `new` initializes the mailbox for inter-class communication, encapsulating behavior within the class. |
| ```systemverilog<br>class driver;<br>  virtual add_if vif;<br>  mailbox gen_to_drv;<br>  transaction tr;<br>  function new(mailbox gen_to_drv, virtual add_if vif);<br>    this.gen_to_drv = gen_to_drv;<br>    this.vif = vif;<br>  endfunction<br>  task run;<br>    forever begin<br>      @(posedge vif.clk);<br>      gen_to_drv.get(tr);<br>      vif.ip1 <= tr.ip1;<br>      vif.ip2 <= tr.ip2;<br>      @(posedge vif.clk);<br>      tr.out <= vif.out;<br>    end<br>  endtask<br>endclass``` | **Abstraction & Constructor Usage**: The `driver` class abstracts signal driving, using `run` to handle continuous driving of signals to the DUT. The constructor `new` links `vif` (interface) and `gen_to_drv` mailbox for communication, establishing modular driver behavior. |
| ```systemverilog<br>class monitor;<br>  virtual add_if vif;<br>  mailbox mon_to_sb;<br>  function new(mailbox mon_to_sb, virtual add_if vif);<br>    this.vif = vif;<br>    this.mon_to_sb = mon_to_sb;<br>  endfunction<br>  task run;<br>    forever begin<br>      transaction mon_tr;<br>      wait(!vif.reset);<br>      @(posedge vif.clk);<br>      mon_tr = new();<br>      mon_tr.ip1 = vif.ip1;<br>      mon_tr.ip2 = vif.ip2;<br>      @(posedge vif.clk);<br>      mon_tr.out = vif.out;<br>      mon_to_sb.put(mon_tr);<br>    end<br>  endtask<br>endclass``` | **Abstraction**: The `monitor` class abstracts signal monitoring, capturing DUT output into a transaction and sending it to the scoreboard. Tasks like `run` allow the monitor to operate without exposing inner workings to other testbench components. |
| ```systemverilog<br>class agent;<br>  driver drv;<br>  monitor mon;<br>  generator gen;<br>  mailbox gen_to_drv;<br>  virtual add_if vif;<br>  function new(virtual add_if vif, mailbox mon_to_sb);<br>    gen_to_drv = new();<br>    drv = new(gen_to_drv, vif);<br>    mon = new(mon_to_sb, vif);<br>    gen = new(gen_to_drv);<br>  endfunction<br>  task run();<br>    fork<br>      drv.run();<br>      mon.run();<br>      gen.run();<br>    join_any<br>  endtask<br>endclass``` | **Modularity & Concurrency**: The `agent` class groups related `driver`, `monitor`, and `generator` classes, managing their concurrent operations via `fork...join_any` in `run`, making the testbench modular and organized. |
| ```systemverilog<br>class scoreboard;<br>  int compare_cnt;<br>  mailbox mon_to_sb;<br>  function new(mailbox mon_to_sb);<br>    this.mon_to_sb = mon_to_sb;<br>  endfunction<br>  task run;<br>    forever begin<br>      transaction tr;<br>      mon_to_sb.get(tr);<br>      if(tr.ip1 + tr.ip2 == tr.out) begin<br>        $display("Matched: ip1 = %0d, ip2 = %0d, out = %0d", tr.ip1, tr.ip2, tr.out);<br>      end else begin<br>        $display("NOT matched: ip1 = %0d, ip2 = %0d, out = %0d", tr.ip1, tr.ip2, tr.out);<br>      end<br>      compare_cnt++;<br>    end<br>  endtask<br>endclass``` | **Modularity & Validation**: The `scoreboard` class modularly handles validation by checking if `ip1 + ip2 == out`. It increments `compare_cnt` for each match, isolating validation logic, and simplifying testbench debugging and analysis. |
| ```systemverilog<br>class env;<br>  agent agt;<br>  scoreboard sb;<br>  mailbox mon_to_sb;<br>  function new(virtual add_if vif);<br>    mon_to_sb = new();<br>    agt = new(vif, mon_to_sb);<br>    sb = new(mon_to_sb);<br>  endfunction<br>  task run();<br>    fork<br>      agt.run();<br>      sb.run();<br>    join_any<br>    wait(agt.gen.count == sb.compare_cnt);<br>    $finish;<br>  endtask<br>endclass``` | **Abstraction & Modularity**: The `env` class abstracts the complete testbench setup, instantiating `agent` and `scoreboard`. The `run` task coordinates these components and completes the simulation when the generator and scoreboard counts match, ensuring a cohesive and maintainable testbench design. |
