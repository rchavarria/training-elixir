# Nodes and distributed Elixir

## Nodes and Naming

**node**: is a running instance of the VM. `mix` or `iex` commands create nodes.

By default, each node is isolated. For two nodes to connect, each must have a **name**.

Nodes are named with short names (`fred@quarry`) or long ones (`wilma@quarry.foobar.com`). Typically, you use short names if your nodes run on the same computer, long names otherwise. But, you can't mix them.

Nodes try to connect the first time one references another.

Connections are transitive. It means that if two nodes are connected, and a third node connects to just only one of them, the three nodes are connected to each other (everything connects to everything).

Programming in Elixir is almost always location (network) transparent.

If a node sends a PID (local PID) to another node, it'll be *converted* into a **remote PID** (it will contain the process PID and the node id).

There are several ways to identify a process:

- The PID
- A registered name (with `Process.register(pid, :my_process)`)
- A name + a node name: `{ pid, :<node name> }`
- A remote PID

So, you can use whatever you want to send messages to a process

## Sending Messages Between Nodes in IEx

There is no to connect explicitly two nodes. The first time a node tries to send a message to the second one, they will try to connect, and they'll connect each other, because connections are transitive.

Create two `iex` sessions, passing in the parameter `--sname` to give them names. In one of them, spawn a process (like the one in `code/chapter-14/demo.exs`):

    iex> pid = spawn(Demo, :reverse, [])

Then, register a name for that process

    iex> Process.register(pid, :rev)

From the second `iex` node, send a message to the spawned process:

    iex> send { :rev, :one@your_host }, "this is the message"

To send a message to a different node you must specify a pid (or a registered name, that is much easier to know) and the node name

## A Bigger Example—a Chain of Nodes

We're gonna build a chain of several nodes, so each node will add it's name to a list and then pass this list to the next node. The message will turn several times:

    [:one]  -->  [:two, :one]  -->  [:three, :two, :one]  --> [:one, :three, :two, :one]  --> [:two, :one, :three,...]

## Implementing the Chain




