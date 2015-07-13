include <configuration.scad>;
$fn=60;

// Belt parameters
belt_width_clamp = 6;              // width of the belt, typically 6 (mm)
belt_thickness = 1.0 - 0.05;       // slightly less than actual belt thickness for compression fit (mm)           
belt_pitch = 2.0;                  // tooth pitch on the belt, 2 for GT2 (mm)
tooth_radius = 0.8;                // belt tooth radius, 0.8 for GT2 (mm)

separation = 40;
thickness = 6;

horn_thickness = 13;
horn_x = 8;

belt_width = 5;
belt_x = 5.6;
belt_z = 7;
corner_radius = 3.5;

m3_nut_radius = 3.0;
m3_wide_radius = 1.5;

outsideRadius = 6.25; // radius of corners
plateWidth = 50; // width of the whole platform
plateHeight = 56; // height of the whole platform
plateThickness = 5; // thickness of plate
ballOffsetZ = 10; // how far the bars are from the plate
ballOffsetY = 18; // how far from center the balls are located
ballDiameter = 10; // diameter of balls
ballCupAngle = 35; // pitch of the cups that hold the balls
rodSeparation = 43; // distance between the two parallel rods, and therefore the two parallel balls
ballRadius = ballDiameter / 2;

module carriage() {
  // Timing belt (up and down).
  translate([-belt_x, 0, belt_z + belt_width/2]) %
    cube([1.2, 100, belt_width], center=true);
  translate([belt_x, 0, belt_z + belt_width/2]) %
    cube([1.2, 100, belt_width], center=true);

	difference() {
    union() {
      // Main body.
      translate([0, 4, thickness/2])
        cube([27, 40, thickness], center=true);

	  hull(){
		translate([-plateWidth/2+outsideRadius,plateHeight/2-outsideRadius,0]) cylinder(h=plateThickness, r=outsideRadius, center=false);
		translate([plateWidth/2-outsideRadius,plateHeight/2-outsideRadius,0]) cylinder(h=plateThickness, r=outsideRadius, center=false);
		translate([-plateWidth/2+outsideRadius,outsideRadius,0]) cylinder(h=plateThickness, r=outsideRadius, center=false);
		translate([plateWidth/2-outsideRadius,outsideRadius,0]) cylinder(h=plateThickness, r=outsideRadius, center=false);

      	translate([0, plateHeight/3-1, thickness/2])
       		cube([rodSeparation, 15, thickness], center=true);
		}
	  // ball cups
	  hull()
			{
			translate([-rodSeparation/2,ballOffsetY,plateThickness+ballOffsetZ]) rotate([270-ballCupAngle,0,0]) cylinder(h=.1,r1=ballRadius+2,r2=1,center=false);
			translate([-rodSeparation/2,plateHeight/2-outsideRadius+5,0]) cylinder(h=plateThickness,r=(plateWidth-rodSeparation)/2,center=false);
			translate([-rodSeparation/2,ballOffsetY-5,0]) cylinder(h=plateThickness,r=(plateWidth-rodSeparation)/2,center=false);
			}
	  hull()
			{
			translate([rodSeparation/2,ballOffsetY,plateThickness+ballOffsetZ]) rotate([270-ballCupAngle,0,0]) cylinder(h=.1,r1=ballRadius+2,r2=1,center=false);
			translate([rodSeparation/2,plateHeight/2-outsideRadius+5,0]) cylinder(h=plateThickness,r=(plateWidth-rodSeparation)/2,center=false);
			translate([rodSeparation/2,ballOffsetY-5,0]) cylinder(h=plateThickness,r=(plateWidth-rodSeparation)/2,center=false);
			}

      // Avoid touching diagonal push rods (carbon tube).
      difference() {
        translate([9.75, 4, horn_thickness/2+1])
          cube([7.5, 40, horn_thickness-2], center=true);

        translate([23, -12, 12.5]) rotate([30, 40, 30])
          cube([40, 40, 20], center=true);
        translate([10, -10, 0])
          cylinder(r=m3_wide_radius+1.5, h=100, center=true, $fn=12);

      }

      // Belt clamps
      for (y = [[9, -1], [-1, 1]]) {
        translate([0.5, y[0], horn_thickness/2+1])
          color("green") hull() {
            translate([ corner_radius-0.0,  -y[1] * corner_radius + y[1], 0]) cube([1.0, 5, horn_thickness-2], center=true);
            cylinder(h=horn_thickness-2, r=corner_radius, $fn=12, center=true);
          }
      }

	  // clamp near string hole
      for (y = [[19, -1]]) {
        translate([0.30, y[0], horn_thickness/2+1])
          rotate([0, 0, 180]) color("blue") hull() {
            translate([ corner_radius-0.5,  -y[1] * corner_radius + y[1], 0]) cube([1.0, 5, horn_thickness-2], center=true);
            cylinder(h=horn_thickness-2, r=corner_radius, $fn=12, center=true);
				translate([ 0,  y[1]*4, 0]) cube([2*corner_radius, 0.5*corner_radius, horn_thickness-2], center=true);
          }
    	// string holder
		difference()
		{
			translate([0,(ballOffsetY + plateHeight/2)/2-1,plateThickness+ballOffsetZ/2+1]) cube([6.4,plateHeight/2-ballOffsetY,ballOffsetZ+3], center=true);
			translate([0,ballOffsetY,plateThickness+ballOffsetZ]) rotate([90-ballCupAngle,0,0]) cylinder(h=20,r=10,center=false);
			}
        
      }
	  // clamp without string hole
      for (y = [[-11, 1]]) {
        translate([0.30, y[0], horn_thickness/2+1])
          rotate([0, 0, 180]) color("blue") hull() {
            translate([ corner_radius-0.5,  -y[1] * corner_radius + y[1], 0]) cube([1.0, 5, horn_thickness-2], center=true);
            cylinder(h=horn_thickness-2, r=corner_radius, $fn=12, center=true);
				translate([ 0,  y[1]*4, 0]) cube([2*corner_radius, 0.5*corner_radius, horn_thickness-2], center=true);
          
	  }
      }    }
    // Screws for linear slider.
    for (x = [-10, 10]) {
      for (y = [-10, 10]) {
        translate([x, y, thickness]) #
          cylinder(r=m3_wide_radius, h=30, center=true, $fn=12);
      }
    }		
	// hole for the string
	//translate([-10,ballOffsetY+2,plateThickness+ballOffsetZ-0.5]) rotate([0,90,0]) translate([0,0,-1])#cylinder(h=20,r=1,center=false);
	// hole for the string
	translate([0,ballOffsetY,plateThickness+ballOffsetZ]) rotate([215,0,0]) translate([0,0,-1])#cylinder(h=20,r=1,center=false);
    // the balls
    translate([0,ballOffsetY,plateThickness+ballOffsetZ]) justTheBalls();
    translate([-3.9,ballOffsetY+10,plateThickness+ballOffsetZ-12]) 
        rotate([90,0,0])
        {
            // hole for the nut
            translate([0,0,-2])# import("m2_5_internal.stl");

            // hole for the screw
            cylinder(r=5/2+0.2+0.1, h=3, center=true, $fn=6);
        }
  }
}

carriage();


module justTheBalls()
{
	color("red")
	{
		translate([-rodSeparation/2,0,0]) sphere(ballRadius);
		translate([rodSeparation/2,0,0]) sphere(ballRadius);
	}
}



