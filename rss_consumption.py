import time
import threading

# Function to create CPU load.
# This function runs in a separate thread and continuously performs a CPU-intensive task.
# It calculates the power of a large number, which consumes significant CPU resources.
def cpu_load(stop_event):
    while not stop_event.is_set():
        # Perform a CPU-intensive task (Calculating the power of a large number)
        _ = 99999**99999

# Function to create RAM load.
# This function allocates a large list in the memory, thus consuming RAM.
# It holds this allocation for a certain period (30 seconds) to simulate memory usage.
def ram_load():
    # Create a large list to consume RAM
    large_list = [0] * 10**8
    time.sleep(30)
    del large_list  # Delete the list to free up memory

# The duration for which the test will run (in seconds)
duration = 30

# An event used to signal the CPU load thread when to stop.
# This is necessary for safe termination of the thread.
stop_event = threading.Event()

# Create a thread for the CPU load function and start it.
# The thread will run alongside the main program, allowing for concurrent execution.
cpu_thread = threading.Thread(target=cpu_load, args=(stop_event,))
cpu_thread.start()

# Start the RAM load function. This will run in the main thread.
ram_load()

# The script waits for the specified duration while the CPU and RAM loads are being generated.
time.sleep(duration)

# Signal the CPU load thread to stop and wait for it to finish.
# This ensures that the script does not exit prematurely, allowing the thread to clean up properly.
stop_event.set()
cpu_thread.join()

# Print a message to indicate that the resource consumption test has completed.
print("Resource consumption test completed.")
