# Arduino-GateKeeper
Arduino Nano project to control two servo motors which are pushing two remote controller
buttons controlling two car gates. Nano is connected through the USB port to a machine
where the simple PHP web app is used to control two gates from your phone instead of using
the remote controller itself.

The thing is that you probably don't want to destroy your remote controller when doing such
a stuff, so you basically put it into a 3D printed holder where it stays until the battery
is gone or you just don't need it anymore.

Application must have access to /dev/ttyUSBx where it reads from and writes to. This is
configured in the gatekeeper.php file.

Two M6 screws with nuts are needed to put the 3D printed holders together.
Feel free to modify it, so it suits your needs.

# Directories and files
_Gatekeeper_ directory holds the Arduino files.

_gatekeeper.php_ is an example PHP application controlling the servos. You have to post a button to it and it expects an authentication.

_Holder.scad_ is the OpenSCAD source.

_Holder_V.stl_ is the vertical part of the holder.

_Holder_H.stl_ is the horizontal part of the holder.

