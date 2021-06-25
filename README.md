# VHDL-Design-of-Debouncing-Circuit

The code generates a simple debouncing circuit. Here, the output the debounced output makes the transition right away, when the switch changes state. Then it waits for a certain amount of time(reconfigurable, based on requirement) for the input to stabilise. It does this by ignoring the input for that time.

After the required time elapses, it starts checking for input transitions again.
