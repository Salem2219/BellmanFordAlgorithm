# Bellman–Ford Algorithm 

Given a graph and a source vertex src in graph, find shortest paths from src to all vertices in the given graph. The graph may contain negative weight edges.
This algorithm is similar to Dijkstra’s. Dijkstra’s algorithm is a Greedy algorithm and time complexity is O(VLogV) (with the use of Fibonacci heap). Dijkstra doesn’t work for Graphs with negative weight edges, Bellman-Ford works for such graphs. Bellman-Ford is also simpler than Dijkstra and suites well for distributed systems. But time complexity of Bellman-Ford is O(VE), which is more than Dijkstra.


# Notes
- src : 4 bits.
- graph : 20 bits.
- graph (19 : 16) : V (Number of vertices).
- graph (15 : 12) : E (Number of edges).
- graph (11 : 8) : edge(address).src (The source of the specified edge by its unique address).
- graph (7 : 4) : edge(address).dest (The destination of the specified edge by its unique address).
- graph (3 : 0) : edge(address).weight (The weight of the specified edge by its unique address).
- There is a createGraph.vhd which helps the user to create the graph (20 bits).

## Install

These examples use [ModelSim&reg; and Quartus&reg; Prime from Intel FPGA](http://fpgasoftware.intel.com/?edition=lite), [GIT](https://git-scm.com/download/win), [Visual Studio Code](https://code.visualstudio.com/download), make sure they are installed locally on your computer before proceeding.

## Usage

1. Grab a copy of this repository to your computer's local folder (i.e. C:\projects):

    ```sh
    $ cd projects
    $ git clone https://github.com/Salem22/BellmanFordAlgorithm.git
    ```
2. Use Visual Studio Code (VSC) to edit and view the design files:

    ```sh
    $ cd BellmanFordAlgorithm
    $ code .
    ```
    Click on the toplevel.vhd file in the left pane to view its contents.
    
3. From the VSC View menu, choose Terminal, in the VCS Terminal, create a "work" library:

    ```sh
    $ vlib work
    ```
    
4. Compile all the design units:

    ```sh
    $ vcom *.vhd
    ```
    
5. Simulate your design. For example, V = 5, E = 8:
- Note the details of the graph shall be found in createGraph.vhd

    ```sh
    $ vsim work.tb
    ```
6. Add the following commands in the transcript :
 ```sh
$ add wave -position end  sim:/tb/dut/control/p
$ add wave -position end  sim:/tb/dut/datapath/printArr/datapath/vertex
$ add wave -position end  sim:/tb/dut/datapath/printArr/datapath/Distance_from_Source
run 9ns
```
7. Keep running the vertices and its their distances from the source will be output in vertex and Distance_from_Source signals.