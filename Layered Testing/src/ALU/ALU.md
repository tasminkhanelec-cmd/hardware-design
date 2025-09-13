ALU with layered testbench
generator is for randomization
testcase is for  constraints

An interface is nothing but a connection between the DUT and TB. The DUT and sv-interface are static (memory will be allocated during compilation time) and TB-classes are dynamic (memory will be allocated during run time) components in nature.

During compilation the static components gets allocated but not the dynamic components. At this time, one side of the interface will be connected and the other side remains open, which is not allowed. In other words it is illegal to declare a static interface inside a class which is dynamic, but it is allowed to point to the interface.

Virtual interface is a handle from the TB, pointing to the static interface. This helps to connect the interface signals to the TB and provide access once the TB gets allocated.
