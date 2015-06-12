# Arduino-GateKeeper
Arduino Nano project to control two servo motors which are the pushing the remote controller
buttons. Nano is connected through the USB port to a machine where the simple PHP web app
is used to control two gates from your phone instead of using the remote controller itself.

Application must have access to /dev/ttyUSBx where it reads from and writes to. This is
configured in the gatekeeper.php file.
