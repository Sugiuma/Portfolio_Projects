interface add_if(input logic clk, reset);
  logic [7:0] ip1, ip2;
  logic [8:0] out;
endinterface

class transaction;
  rand bit [7:0] ip1, ip2;
  bit [8:0] out;
  constraint ip_c {ip1 < 100; ip2 < 100;}
endclass

class generator;
  int count;
  mailbox gen_to_drv;
  transaction tr;
  
  function new(mailbox gen_to_drv);
    this.gen_to_drv = gen_to_drv;
  endfunction
  
  task run;
    // Randomization and mailbox operations
  endtask
endclass

class driver;
  virtual add_if vif;
  mailbox gen_to_drv;
  transaction tr;
  
  function new(mailbox gen_to_drv, virtual add_if vif);
    this.gen_to_drv = gen_to_drv;
    this.vif = vif;
  endfunction
  
  task run;
    // Driver logic for DUT
  endtask
endclass

class monitor;
  virtual add_if vif;
  mailbox mon_to_sb;
  
  function new(mailbox mon_to_sb, virtual add_if vif);
    this.vif = vif;
    this.mon_to_sb = mon_to_sb;
  endfunction
  
  task run;
    // Monitoring and mailbox operations
  endtask
endclass

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
    // Fork and join tasks for agent components
  endtask
endclass

class scoreboard;
  int compare_cnt;
  mailbox mon_to_sb;
  
  function new(mailbox mon_to_sb);
    this.mon_to_sb = mon_to_sb;
  endfunction
  
  task run;
    // Compare transactions and output results
  endtask
endclass

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
    // Fork and join tasks for environment components
  endtask
endclass

program base_test(add_if vif);
  env env_o;
  
  initial begin
    env_o = new(vif);
    env_o.agt.gen.count = 5;
    env_o.run();
  end
endprogram

module tb_top;
  bit clk;
  bit reset;
  add_if vif(clk, reset);
  adder DUT(.clk(vif.clk),.reset(vif.reset),.in1(vif.ip1),.in2(vif.ip2),.out(vif.out));
  base_test t1(vif);
  
  initial begin
    clk = 0;
    reset = 1;
    #5; 
    reset = 0;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
endmodule
