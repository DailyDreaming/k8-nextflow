A toy workflow to test running on the PRP kubernetes cluster, mostly navigating permissions in a non-privileged cluster.

Minimally, two processes share a file, which should test shared access to the same file space (in this case we're trying out using a PVC to do this).

Once this is running successfully, we can theoretically run production workflows.
