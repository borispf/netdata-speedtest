#!/bin/bash

# Netdata charts.d collector for speedtest.net internet speed test.
# Requires installed speedtest.net cli: https://www.speedtest.net/apps/cli
speedtest_update_every=600
speedtest_priority=100

speedtest_check() {
  require_cmd speedtest || return 1
  return 0
}


speedtest_create() {
	# create a chart with 2 dimensions
	# Convert bytes per second to Mbps.
	cat <<EOF
CHART system.connectionspeed '' "System Connection Speed" "Mbps" "connection speed" system.connectionspeed line $((speedtest_priority + 1)) $speedtest_update_every
DIMENSION down 'Down' absolute 8 1000000
DIMENSION up 'Up' absolute -8 1000000
EOF

	return 0
}

speedtest_update() {
	# do all the work to collect / calculate the values
	# for each dimension
	# remember: KEEP IT SIMPLE AND SHORT
  # Get the up and down speed in bytes per second. Parse them into separate values.
  speedtest_output=$(speedtest --format=tsv)
  down=$(echo "${speedtest_output}" | cut -f 6)
  up=$(echo "${speedtest_output}" | cut -f 7)

	# write the result of the work.
	cat <<VALUESEOF
BEGIN system.connectionspeed
SET down = $down
SET up = $up
END
VALUESEOF

	return 0
}
