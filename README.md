A toy workflow to test running on the [PRP kubernetes cluster](https://portal.nrp-nautilus.io), mostly navigating permissions in a non-privileged cluster.

Minimally, two processes share a file, which should test shared access to the same file space (in this case we're trying out using a [PersistentVolumeClaim (PVC)](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) to do this).

Once this is running successfully, we can theoretically run production workflows.
