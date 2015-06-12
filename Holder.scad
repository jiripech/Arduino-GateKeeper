module roundedRect(size, radius) {
  x = size[0];
  y = size[1];
  z = size[2];

  linear_extrude(height=z)
  hull() {
    translate([radius, radius, 0])
      circle(r=radius);

    translate([x - radius, radius, 0])
      circle(r=radius);

    translate([x - radius, y - radius, 0])
      circle(r=radius);

    translate([radius, y - radius, 0])
      circle(r=radius);
  }
}

module remote_buttons(lem = 0) {
  btn_r_I    =  5;
  btn_r_O    =  btn_r_I + 5;

  difference() {
    cylinder(r = btn_r_O + lem, h = 1);
    translate([0, 0, -0.5]) cylinder(r = btn_r_I - lem, h = 2);
    translate([0, -lem, 0]) rotate([0, 0, -135]) cube([10, 10, 10]);
    translate([0, +lem, 0]) rotate([0, 0, +45]) cube([10, 10, 10]);
  }  
}

module remote_box() {
  dim_Y = 25;
  dim_X = 100;
  dim_Z = 14;
    
  cube([dim_X, dim_Y, dim_Z]);
}

module remote() {
  dim_Y = 25;
  dim_X = 60;
  dim_Z = 14;
    
  // some logo on the remote
  int_btn_X = 40;
  int_btn_L = 10;
  int_btn_W =  8;
  int_btn_H =  1.5;
    
  // a notch on the remote
  cb_dim_X = 10;
  cb_dim_W = 20;
  cb_dim_L = 28;
  cb_dim_H =  1;
    
  btn_center = 24;
 
  difference() {
    union () {
      cube([dim_X, dim_Y, dim_Z]);
      translate([int_btn_X, (dim_Y - int_btn_W) / 2, dim_Z])
        roundedRect([int_btn_L, int_btn_W, int_btn_H], 1);
    }
    translate([cb_dim_X, (dim_Y - cb_dim_W) / 2, dim_Z - cb_dim_H])
      cube([cb_dim_L, cb_dim_W, cb_dim_H * 2]); 
 
    translate([btn_center, dim_Y / 2, dim_Z - 2 * cb_dim_H])
      remote_buttons(0.8);
  }

  translate([btn_center, dim_Y / 2, dim_Z - 2 * cb_dim_H])
    remote_buttons();
}

module lever(rotated = 0) {
  cen_R = 6.5 / 2;
  cen_H = 4.5;
    
  lev_H = 1.5;
  lev_R = 1.45;
    
  lev_L = 19.75;
  hle_R = 0.25;

  sml_R = 2.5;
  sml_X = cen_H - 3;

  rotate([rotated + 90, 0, 90]) difference() {
    union() {
      rotate([0, -90, 0]) cylinder(r = cen_R, h = cen_H, $fn = 72);
 
      hull() {
        rotate([0, -90, 0]) cylinder(r = cen_R, h = lev_H, $fn = 72);
        translate([0, 0, lev_L - cen_R - lev_R])
          rotate([0, -90, 0]) cylinder(r = lev_R, h = lev_H, $fn = 72);
      }
    }
    for (i = [0:5]) {
        translate([lev_H, 0, lev_L - cen_R - lev_R - i * ((lev_L - cen_R - lev_R) / 7)])
         rotate([0, -90, 0]) cylinder(r = hle_R, h = lev_H * 3, $fn = 72);      
    }
    translate([-sml_X, 0, 0]) rotate([0, -90, 0]) cylinder(r = sml_R, h = cen_H, $fn = 72);
    translate([sml_X, 0, 0]) rotate([0, -90, 0]) cylinder(r = lev_R, h = cen_H, $fn = 72);
  }
}

module servo_holes() {
  srv_X = 23;
  srv_Y = 24;
  srv_Z = 12;
    
  hld_X = 16;
  hld_L =  2.5;
  hld_W = 32.5;
    
  sml_X = 11.5;
  sml_R = 2.5;
  rod_R = 2.25 / 2;
    
  translate([(srv_X - hld_W) / 2, hld_X, 0]) {
    translate([2, -3 * hld_L, srv_Z / 2])
      rotate([-90, 0, 0])
        cylinder(r = rod_R, h = hld_L * 5, $fn = 72);
    translate([hld_W - 2, -3 * hld_L, srv_Z / 2])
      rotate([-90, 0, 0])
        cylinder(r = rod_R, h = hld_L * 5, $fn = 72);
  }
}
module servo(lever_rotated = 0) {
  srv_X = 23;
  srv_Y = 25;
  srv_Z = 12.75;
 
  hld_X = 16;
  hld_L =  2.5;
  hld_W = 32.5;
    
  sml_X = 11.5;
  sml_R = 2.5;
  rod_R = 2.25 / 2;
 
  rod_L = 31;
  cen_L = 27.5;
 
  cube([srv_X, srv_Y, srv_Z]);
  difference() {
    translate([(srv_X - hld_W) / 2, hld_X, 0])
      cube([hld_W, hld_L, srv_Z]);
    servo_holes();
  }
  translate([srv_Z / 2, 0, srv_Z / 2])
    rotate([-90, 0, 0]) {
      cylinder(r = sml_R, h = rod_L, $fn = 72);
      cylinder(r = srv_Z / 2, h = cen_L, $fn = 72);
    }

  translate([sml_X, 0, srv_Z / 2])
    rotate([-90, 0, 0])
      cylinder(r = sml_R, h = cen_L, $fn = 72);
    
  translate([srv_Z / 2, rod_L, srv_Z / 2])
    lever(rotated = lever_rotated);
}

module holder_holes() {
  translate([-4, -50, 5])
    rotate([-90, 0, 0]) cylinder(r = 2.5, h = 100, $fn = 72);
  translate([72, -30, 5])
    rotate([-90, 0, 0]) cylinder(r = 2.5, h = 35, $fn = 72);
  translate([8, -30, 3])
    rotate([-90, 0, 0]) cylinder(r = 1.45, h = 25, $fn = 72);
  translate([64, -30, 3])
    rotate([-90, 0, 0]) cylinder(r = 1.45, h = 25, $fn = 72);
}

module holder_boxes() {
  translate([0, 5, 0]) remote_box();
  translate([1.5, -20, 18]) {
    servo(45);
    servo_holes();
  }
  translate([+36, -20, 18]) {
    servo(-225);
    servo_holes();
  }
}

module holder_show() {
  translate([0, 5, 0]) remote();
  translate([1.5, -20, 18]) servo(45);
  translate([+36, -20, 18]) servo(-225);
}

out_dim_X = -10;
out_dim_Y = 34 - out_dim_X;
out_dim_L = 90;
out_dim_Z = 16;

module holder_H() {
  difference() {
    difference() {
        translate([-10, out_dim_X, -3]) cube([out_dim_L, out_dim_Y, out_dim_Z]);
        translate([-10, -19.5, -3]) cube([90, 15.5, 36]);
        holder_holes();
    }
    holder_boxes();
  }
}

module holder_V() {    
  difference() {
    difference() {
        translate([-10, -19.5, -3]) roundedRect([90, 15.5, 36], 2);
        translate([-10, out_dim_X, -3]) cube([out_dim_L, out_dim_Y, out_dim_Z]);
        holder_holes();
    }
    holder_boxes();
  }
}

holder_V();
holder_H();

// holder_show();
