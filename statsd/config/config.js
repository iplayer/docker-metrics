{
  graphitePort: 2003,
  graphiteHost: "graphite.iplayer.io",
  graphite: {
    legacyNamespace: false
  },
  port: 8125,
  mgmt_port: 8126,
  backends: ['./backends/graphite'],
  histogram: [
    { metric: "nitro", bins: [100, 300, 500, 1000, 2000, 3000, 5000, "inf"] }
  ]
}
