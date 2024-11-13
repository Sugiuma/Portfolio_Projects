| **SystemVerilog Code Snippet** | **OOP Implementation Explanation** |
|-------------------------------|-------------------------------------|
| ![SystemVerilog Snippet](https://path/to/your/code-image.png) | **Encapsulation**: The `add_if` interface encapsulates signals `ip1`, `ip2`, and `out`, along with `clk` and `reset`, simplifying DUT connections by grouping related signals. |

| **Encapsulation**: The `add_if` interface encapsulates signals `ip1`, `ip2`, and `out`, as well as `clk` and `reset`, simplifying connections to the DUT by grouping related signals. |
| **Encapsulation & Randomization**: The `transaction` class encapsulates inputs and outputs, along with constraints for randomization. Constrained random values for `ip1` and `ip2` support effective test coverage while maintaining data hiding within the class. |
 | **Abstraction & Constructor Usage**: The `generator` class abstracts transaction generation with the `run` task handling repetitive random transaction creation, while `new` initializes the mailbox for inter-class communication, encapsulating behavior within the class. |
 | **Abstraction & Constructor Usage**: The `driver` class abstracts signal driving, using `run` to handle continuous driving of signals to the DUT. The constructor `new` links `vif` (interface) and `gen_to_drv` mailbox for communication, establishing modular driver behavior. |
 | **Abstraction**: The `monitor` class abstracts signal monitoring, capturing DUT output into a transaction and sending it to the scoreboard. Tasks like `run` allow the monitor to operate without exposing inner workings to other testbench components. |
| **Modularity & Concurrency**: The `agent` class groups related `driver`, `monitor`, and `generator` classes, managing their concurrent operations via `fork...join_any` in `run`, making the testbench modular and organized. |
| **Modularity & Validation**: The `scoreboard` class modularly handles validation by checking if `ip1 + ip2 == out`. It increments `compare_cnt` for each match, isolating validation logic, and simplifying testbench debugging and analysis. |
 | **Abstraction & Modularity**: The `env` class abstracts the complete testbench setup, instantiating `agent` and `scoreboard`. The `run` task coordinates these components and completes the simulation when the generator and scoreboard counts match, ensuring a cohesive and maintainable testbench design. |

