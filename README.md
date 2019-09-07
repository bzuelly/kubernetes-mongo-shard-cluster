# Kubernetes mongodb shard cluster

Mongo db  shard cluster built on kubernetes. This configuration include:
 - 3 node as config replica set
 - 4 shard  with 3 node as replica set for each shard
 - 2 node as mongos router


## Create cluster

```sh
./cluster-tear-up.sh
```


## Deploy Mongo
In your master node do

```
./initiate.sh
```
`initate.sh` will deploy for you all pods and will create all needed services.
## Connecting to mongo
For example to connect to your cluster:

- ssh into a pod `kubectl exec -it <POD-NAME> -- /bin/bash` (you can get the pod name from `kubectl get pods`)
- from the pod run `mongo mongodb://mongos1:27017` to view the cluster status from a mongo shell do
- run `sh.status()` and the output should be

```
mongos> sh.status()
--- Sharding Status ---
...
...
shards:
        {  "_id" : "rs1",  "host" : "rs1/mongosh1-1:27017,mongosh1-2:27017,mongosh1-3:27017",  "state" : 1 }
        {  "_id" : "rs2",  "host" : "rs2/mongosh2-1:27017,mongosh2-2:27017,mongosh2-3:27017",  "state" : 1 }
        {  "_id" : "rs3",  "host" : "rs3/mongosh3-1:27017,mongosh3-2:27017,mongosh3-3:27017",  "state" : 1 }
        {  "_id" : "rs4",  "host" : "rs4/mongosh4-1:27017,mongosh4-2:27017,mongosh4-3:27017",  "state" : 1 }
...

```
## Clean

To remove all pods
```sh
./clean.sh
```

## Deploy different number of shard replica set

- Edit in `config` file `SHARD_REPLICA_SET` and set the desired number
- Create for each additional replica set a file named `mongo_sh_N.yaml`
- Copy content from `mongo_sh_1.yaml`
- Replace all occurrences of `mongosh1` with `mongoshN`
- Replace all occurrences of `rs1` with `rsN`

## Delete Cluster

```sh
./cluster-tear-down
```


## TODO

- [ ] add PersistVolumes (see PersistentVolumes, PersistentVolumeClaims, Disk)

## Resources

- [Using preexisiting Persistent Disks as PersistentVolumes](https://cloud.google.com/kubernetes-engine/docs/how-to/persistent-volumes/preexisting-pd) - it shows how to create a persistent disk (together with persistent volumes, and persistent volume claims) and how a node can use a persistent volume
- [deployments_vs_statefulsets](https://cloud.google.com/kubernetes-engine/docs/concepts/persistent-volumes#deployments_vs_statefulsets) - confirmation that for stateful applications (e.g. a db) you need *statefulsets* and not *deployments*
- [Overall page about persistent volume](https://cloud.google.com/kubernetes-engine/docs/concepts/persistent-volumes)
- [Repo already using mongo shards with persistent disk and volumes](https://github.com/sunnykrGupta/gke-mongodb-shards) - The script does not work (probably outdated), however it can be used for a template on how to manage persistent disks, statefulsets, etc.