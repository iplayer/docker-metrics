/** @scratch /configuration/config.js/1
 * == Configuration
 * config.js is where you will find the core Grafana configuration. This file contains parameter that
 * must be set before kibana is run for the first time.
 */
define(['settings'],
function (Settings) {

  return new Settings({

    /**
     * Multiple graphite servers? Comment out graphiteUrl and replace with
     *
     *  datasources: {
     *    data_center_us: { type: 'graphite',  url: 'http://<graphite_url>',  default: true },
     *    data_center_eu: { type: 'graphite',  url: 'http://<graphite_url>' }
     *  }
     */

    default_route: '/dashboard/file/default.json',

    /**
     * If your graphite server has another timezone than you & users browsers specify the offset here
     * Example: "-0500" (for UTC - 5 hours)
     */
    timezoneOffset: null,

    grafana_index: "grafana-dash",

    panel_names: [
      'text',
      'graphite'
    ]
  });
});
