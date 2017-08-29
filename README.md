# Nomad Example

#### Prepare
```
$ mkdir -p /tmp/var/lib/nomad /tmp/var/lib/consul
```

#### Start Consul

```
$ nohup consul agent -server -bootstrap -ui -data-dir /tmp/var/lib/consul -client 0.0.0.0 -recursor 8.8.8.8 -advertise <your-ip-address> &> consul.log &
```

#### Start Nomad

```
$ nohup nomad agent -config server.hcl &> nomad.log &
```

#### Run a Job

```
$ nomad run example.nomad
```

#### Check Status

```
$ nomad status example
```

#### DNS Query

```
$ dig @127.0.0.1 -p 8600 jdk8-application-john.service.dc1.consul SRV
$ dig @127.0.0.1 -p 8600 jdk8-application-due.service.dc1.consul SRV
```

#### Consul UI

[http://localhost:8500/ui/#/dc1/services](http://localhost:8500/ui/#/dc1/services)
