| SystemVerilog Code Snippet | OOP Implementation Explanation |
|----------------------------|--------------------------------|
| [SystemVerilog Code for `add_if` and `transaction`](https://gist.github.com/) | **Encapsulation**: The `add_if` interface encapsulates signals `ip1`, `ip2`, and `out`, along with `clk` and `reset`, simplifying DUT connections by grouping related signals. The `transaction` class encapsulates inputs and outputs, with constraints for randomization that enable constrained random testing and data hiding within the class. |
| [SystemVerilog Code for `generator`](https://gist.github.com/) | **Abstraction & Constructor Usage**: The `generator` class abstracts transaction creation with the `run` task for repeated generation. The constructor initializes the mailbox for inter-class communication, encapsulating behavior within the class. |
| [SystemVerilog Code for `driver`](https://gist.github.com/) | **Abstraction & Constructor Usage**: The `driver` class abstracts signal driving, using `run` to handle continuous stimulus to the DUT. The `new` constructor links `vif` and `gen_to_drv` mailbox, enabling modular driver behavior. |
