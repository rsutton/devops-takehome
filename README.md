# devops-takehome
Simple flask + sqlalchemy app

## Requirements
Docker Engine and Docker Compose are required to run this code.

I performed my development on an macOS High Sierra 10.13.6 host with Docker Desktop Community v2.0.0.3
- Engine 18.09.2
- Compose 1.23.2

Other tools needed to build and run tests:
- GNU Make 3.81
- curl 7.61.1

## Start the application
I chose GNU Make to manage my development lifecycle to build, run and test this demo.

    $ make test

The **test** Make target will create the app container image, start the app and postgres containers using docker-compose, and then execute three curl commands to exercise the API as shown below.


## Interact with the API
POST a message to the API:
```bash
curl -X POST http://127.0.0.1:5000/message -H "Content-Type: application/json" --data '{"message": "hi"}'
```

GET a message
```bash
curl http://127.0.0.1:5000/message/1
```

HEALTHCHECK
```bash
curl http://127.0.0.1:5000/healthcheck
```

## Monitoring
I have included a __monitor.yml__ docker compose configuration to demonstrate some monitoring options. You can start the monitoring tools with:

        $ make run YAML='monitor.yml'

The most basic monitoring available is `docker stats` which provides metrics on cpu, memory, disk, and network stats.  However, these data are only displayed on the terminal, not persisted.

        $ docker stats

These hardware metrics, that is cpu, memory, and i/o are important to watch because they provide the most basic indications of system health and can help to identify over and under-subscribed resources in need of improvement to increase performance and efficiency, and possibly to reduce costs.

For example, we might want to be notified if cpu usage is consistently over some threshold, perhaps 90% or if there are sudden increases that can be correlated with increased application response time.

Building on top of docker stats we have [cadvisor](https://hub.docker.com/r/google/cadvisor/) which provides graphical display of docker stats output. Nice, but still no persistent storage for trend analysis. For this we need a database. The cadvisor dashboard is available through your browser:

        http://localhost:8080/docker/


[InfluxDb](https://www.influxdata.com/) is an example of a time series database suitable for persisting docker performance metrics. Cadvisor can be configured to use this database.

For a more powerful and expressive option for viewing and monitoring metrics is [Grafana](https://grafana.com/). This tool greatly improves the experience over cadvisor and latest versions provide alerting and annotation features. Access to historical data is only limited by the amount of disk space available. Grafana requires some post installation configuration to make the necessary connections with InfluxDb which can be found in this [blog post](https://www.brianchristner.io/how-to-setup-docker-monitoring/). You can login using 'admin:admin'.

        http://localhost:3000/

There are many other options including web-hosted solutions. This [post](https://code-maze.com/top-docker-monitoring-tools/) might be helpful.

Remember, the data provided by `docker stats` is only related to the running containers. It doesn't tell us about the physical host running the docker engine and application performance is also important. A production quality monitoring system needs to inlude all of these metric sources, but for that we need other tools which include `Application Performance Monitors`, or APM. Examples are [New Relic](https://newrelic.com/) and [APPDYNAMICS](https://www.appdynamics.com/) which add many more metrics types associated with running code and the hardware metrics of hosts and containers.

Once you are collecting metrics then you can connect these tools with notification and alerting systems such as [PagerDuty](https://www.pagerduty.com/) and [Slack](https://slack.com/) so that engineers can take corrective action when performance thresholds are execeeded.

When you are finished with the monitoring demo apps you can cleanup the deployment with:

        $ make clean YAML='monitor.yml'
