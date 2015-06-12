<?php
// this should be protected by the HTTP authentication and put behing a TLS protection

// the port and timezone should be configured, so you can connect to a proper device
// and log the usage of the device
  $comPort = "/dev/ttyUSBx";
  date_default_timezone_set('Europe/Prague');

// you don't need to show errors in production, but it's vital in the development stage
// when you are tunning the file privileges and such a stuff
//  ini_set('error_reporting', E_ALL);
//  ini_set('display_errors', 1);

// if we've got the code of the button and the user authenticated himself
// against the authority (should be some kind of SSO), we can proceed

if ((! empty($_POST['button'])) && (! empty($_SERVER['REMOTE_USER']))) {
    $btnPressed = intval($_POST['button']);
    if (($btnPressed != 1) && ($btnPressed != 2)) {
      header('HTTP/1.1 501 Not Implemented');
      header('Status: 501 Not Implemented');
      die ('Unknown button pressed, sorry.');
    }
    // we log who is using the app
    $fp = fopen('gate.txt', 'a');
    fwrite($fp, date("Y-m-d H:i:s") . ' ' . $_SERVER['REMOTE_USER'] . ' ' . $btnPressed . "\n");
    fclose($fp);
    // open your USB communication port for reading and writing
    $fpr = fopen($comPort, 'r+');
    // wait for initialization
    sleep(2);
    // read the ready state, just to be sure, there is something listening to us
    $ready = fread($fpr, 5);
    if ($ready == 'Ready') {
      // send the button to the device
      fwrite($fpr, $btnPressed);
      // wait before closing the port, so the device has a time to proceed
      sleep(3);
      // and close the file
      fclose($fpr);
      // send something back
      die ('OK');
    } else {
      header('HTTP/1.1 503 Service Unavailable');
      header('Status: 503 Service Unavailable');
      die ('Device disconnected or malfuctioning, sorry.');
    }
} else {
  header('HTTP/1.1 404 Not Found');
  header('Status: 404 Not Found');
  die ('Ehm, yes.');
} ?>