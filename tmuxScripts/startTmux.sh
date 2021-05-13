echo "Wait a little"
sleep 15

workdir=/your/project/path
gateway_eth=192.168.10.254
gateway_wlan=192.168.21.254

echo "Start Tmux"
tmux new-session -s autostart -n main -d -c /your/project/path
# split panes
tmux split-window -h -t autostart:0.0
tmux split-window -h -t autostart:0.0
tmux split-window -h -t autostart:0.2
tmux split-window -v -t autostart:0.0
tmux split-window -v -t autostart:0.2
tmux split-window -v -t autostart:0.4
tmux split-window -v -t autostart:0.6

echo "Split 8 panes ready"
sleep 10

# send-keys
tmux send-keys -t autostart:0.0 "cd $workdir; echo 0.0" C-m
tmux send-keys -t autostart:0.1 "cd $workdir; echo 0.1" C-m
tmux send-keys -t autostart:0.2 "cd $workdir; echo 0.2" C-m
tmux send-keys -t autostart:0.3 "cd $workdir; echo 0.3" C-m
tmux send-keys -t autostart:0.4 "cd $workdir; echo 0.4" C-m
tmux send-keys -t autostart:0.5 "cd $workdir; echo 0.5" C-m
tmux send-keys -t autostart:0.6 "cd $workdir; echo 0.6" C-m
tmux send-keys -t autostart:0.7 "cd $workdir; echo 0.7" C-m
sleep 10

echo "Starting works"
# Start striker
# scanner
tmux send-keys -t autostart:0.0 "./Main_scan.sh" C-m
sleep 10
# tmux send-keys -t autostart:0.1 "./Optional_job.sh" C-m

# ethernet
tmux send-keys -t autostart:0.2 "./Main_worker.sh eth0 $gateway_eth 1" C-m
sleep 10
tmux send-keys -t autostart:0.3 "./Main_worker.sh eth0 $gateway_eth 2" C-m
sleep 10
tmux send-keys -t autostart:0.4 "./Main_worker.sh eth0 $gateway_eth 3" C-m
sleep 10
# wlan
tmux send-keys -t autostart:0.5 "./Main_worker.sh wlan0 $gateway_wlan 1" C-m
sleep 10
tmux send-keys -t autostart:0.6 "./Main_worker.sh wlan0 $gateway_wlan 2" C-m
sleep 10
tmux send-keys -t autostart:0.7 "./Main_worker.sh wlan0 $gateway_wlan 3" C-m
sleep 10
