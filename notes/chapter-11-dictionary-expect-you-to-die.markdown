# No, Mr Dictionary, I expect you to die

## Nannies and supervisors

Dave doesn't like the name of supervisor, because they tell people what to do. Instead, he likes *nanies*, becasue they take care of processes, they look at them, and recreates them if they crash.

Who takes care of nanies (supervisor)? Another nany, or a super-nany

A supervisor monitors one or more processes.

Because a supervisor is just another process, supervisors can also monitor other supervisors, so you can create supervision trees.

Supervisors sit outside the regular process structure.

There is a difference between *supervision tree* and *process tree*. Processes must focus on getting the work done. They can fail if the need to. Supervisors, on the other hand, just take care of processes.

## Write the supervisor

The supervisor must be started before the agent or other processes.

Because supervisors start other processes, it’s likely that the root level process of a supervised application will be the top level supervisor.

One way to specify a supervisor is inside the `application.ex` file. Use `Supervisor.start_link`, passing a list of child specifications and a set of options.

**Worker Specifications**

Each entry in the children list is a fairly complex data structure describing a process to supervise. Rather than creating this from scratch every time you want a new supervised process, Elixir provides two helper functions: `worker` and `supervisor`.1

The worker helper takes a module name, a list of arguments to pass to that module’s `start_link` function, and possibly some options. (Have a look at the help for `Supervisor.Spec` for a great description of those options).)

**Supervision Options**

The second parameter to `Supervisor.start_link` is a keyword list. There are many of this, and I’m not planning to duplicate the excellent documentation for the `Supervisor` module. However, here are some common options:

```
strategy: :one_for_one | :one_for_all | :rest_for_one | :simple_one_for_one
```

Tells the supervisor how to handle child creation and failures. We used `:one_for_one`, where each child process has an independent life. If a child dies, it alone is restarted. Later in this course, we’ll use `simple_one_for_one`, which lets us write dynamically scaling apps.

```
max_restarts: n and max_seconds: s
```

If more than `n` restarts occur in a period of `s` seconds, the supervisor shuts down all its supervised processes and then terminates itself.

**Testing Supervision**

Just to beat this particular horse to a pulp, supervision is a separate concern to your application functionality.

As such, the supervision strategy should (as much as possible) be tested separately from the application logic. In a way, you can think of supervision tests as being a kind of integration-level test.

