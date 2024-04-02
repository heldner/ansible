# playerctl

The playerctl utility provides a command line tool to send commands to MPRIS
clients. The most common commands are play-pause, next and previous:

```shell
playerctl play-pause
playerctl next
playerctl previous
```

playerctl will send the command to the first player it finds. To select a
player manually, use the --player option, e.g. --player=vlc. For better
automation playerctl comes with a daemon that keeps track of media player
activity and directs commands to the one with most recent activity. You can
spun it into the background with:
