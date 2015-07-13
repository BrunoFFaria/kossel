// a parametric effector for a delta printer.  Plan is based on balls on the ends of rods, held together by spring-loaded strings

$fn=60;
rodSeparation = 43; // distance between the parallel rods
armSeparation = 28.5; // distance between the balls of the separate arms
ballDiameter = 10; // diameter of spherical balls
hotendDiameter = 32; // size of central hole for hotend
plateThickness = 8; // how thick the bottom plate is
ballCupAngle = 35; // pitch of the cups that hold the balls
switch_x = 19.9; // switch dimensions
switch_y = 6.3; // switch dimensions
switch_z = 8.1; // switch dimensions
switch_fudge = 0.1;  // enlarge switch cutout by this amount (2x)

m3_major = 2.85;
m3_radius = m3_major/2 + 0.1;
m3_wide_radius = m3_major/2 + 0.1 + 0.2;
mount_radius = 12.5; 

push_fit_height = 4;
hotend_radius = 8;

ballRadius = ballDiameter / 2;

rodsAngle = 120 * rodSeparation / (rodSeparation + armSeparation); // angle between the two rod balls for a given arm and rod separation
armsAngle = 120 * armSeparation / (rodSeparation + armSeparation); // angle between the edge arm balls for a given arm and rod separation
spacingRadius = (rodSeparation/2) / sin(rodsAngle/2); // distance from the center to the midpoint of a ball

ball1_x = armSeparation / 2;
ball1_y = (armSeparation/2) / tan(armsAngle/2);
ball3_x = rodSeparation / 2; // this needs to be defined to derive ball2 effectively
ball3_y = (rodSeparation/2) / tan(rodsAngle/2);
ball2_thirdAngle = 180 - (rodsAngle/2+armsAngle)-((180-armsAngle)/2);
ball2_x = ball3_x + (armSeparation * sin(ball2_thirdAngle));
ball2_y = ball3_y - (armSeparation * cos(ball2_thirdAngle));

echo("DELTA_EFFECTOR_OFFSET = ", 35.15);
// allTheBalls();
platform();

module platform()
{
	difference()
	{
		union()
		{
			// draw the rounded hexagonal shape
			difference()
			{
			hull()
			{
				translate([-ball1_x,ball1_y,ballRadius + 2]) rotate([180-ballCupAngle,0,armsAngle/2+rodsAngle/2]) cylinder(h=2*ballDiameter,r1=ballRadius+2,r2=1,center=false);
				translate([-ball1_x,ball1_y,0]) cylinder(h=.1,r=ballRadius - plateThickness/4,center=false);

				translate([ball1_x,ball1_y,ballRadius + 2]) rotate([180-ballCupAngle,0,-(armsAngle/2+rodsAngle/2)]) cylinder(h=2*ballDiameter,r1=ballRadius+2,r2=1,center=false);
				translate([ball1_x,ball1_y,0]) cylinder(h=.1,r=ballRadius - plateThickness/4,center=false);

				translate([-ball2_x,-ball2_y,ballRadius + 2]) rotate([180-ballCupAngle,0,armsAngle/2+rodsAngle/2]) cylinder(h=2*ballDiameter,r1=ballRadius+2,r2=1,center=false);
				translate([-ball2_x,-ball2_y,0]) cylinder(h=.1,r=ballRadius - plateThickness/4,center=false);

				translate([ball2_x,-ball2_y,ballRadius + 2]) rotate([180-ballCupAngle,0,-(armsAngle/2+rodsAngle/2)]) cylinder(h=2*ballDiameter,r1=ballRadius+2,r2=1,center=false);	
				translate([ball2_x,-ball2_y,0]) cylinder(h=.1,r=ballRadius - plateThickness/4,center=false);

				translate([-ball3_x,-ball3_y,ballRadius + 2]) rotate([180-ballCupAngle,0,180]) cylinder(h=2*ballDiameter,r1=ballRadius+2,r2=1,center=false);
				translate([-ball3_x,-ball3_y,0]) cylinder(h=.1,r=ballRadius - plateThickness/4,center=false);

				translate([ball3_x,-ball3_y,ballRadius + 2]) rotate([180-ballCupAngle,0,180]) cylinder(h=2*ballDiameter,r1=ballRadius+2,r2=1,center=false);
				translate([ball3_x,-ball3_y,0]) cylinder(h=.1,r=ballRadius - plateThickness/4,center=false);
			}
			translate([0,0,plateThickness+10]) cube([100,100,20], center=true);
			}
			
			// add cups to hold the balls	
			hull()
			{
				translate([-ball1_x,ball1_y,ballRadius + 2]) rotate([180-ballCupAngle,0,armsAngle/2+rodsAngle/2]) cylinder(h=2*ballDiameter,r1=ballRadius+2,r2=1,center=false);
				translate([-ball1_x,ball1_y,0]) cylinder(h=.1,r=ballRadius - plateThickness/4,center=false);
			}
			hull()
			{
				translate([ball1_x,ball1_y,ballRadius + 2]) rotate([180-ballCupAngle,0,-(armsAngle/2+rodsAngle/2)]) cylinder(h=2*ballDiameter,r1=ballRadius+2,r2=1,center=false);
				translate([ball1_x,ball1_y,0]) cylinder(h=.1,r=ballRadius - plateThickness/4,center=false);
			}
			hull()
			{
				translate([-ball2_x,-ball2_y,ballRadius + 2]) rotate([180-ballCupAngle,0,armsAngle/2+rodsAngle/2]) cylinder(h=2*ballDiameter,r1=ballRadius+2,r2=1,center=false);
				translate([-ball2_x,-ball2_y,0]) cylinder(h=.1,r=ballRadius - plateThickness/4,center=false);
			}
			hull()
			{
				translate([ball2_x,-ball2_y,ballRadius + 2]) rotate([180-ballCupAngle,0,-(armsAngle/2+rodsAngle/2)]) cylinder(h=2*ballDiameter,r1=ballRadius+2,r2=1,center=false);	
				translate([ball2_x,-ball2_y,0]) cylinder(h=.1,r=ballRadius - plateThickness/4,center=false);
			}
			hull()
			{
				translate([-ball3_x,-ball3_y,ballRadius + 2]) rotate([180-ballCupAngle,0,180]) cylinder(h=2*ballDiameter,r1=ballRadius+2,r2=1,center=false);
				translate([-ball3_x,-ball3_y,0]) cylinder(h=.1,r=ballRadius - plateThickness/4,center=false);
			}
			hull()
			{
				translate([ball3_x,-ball3_y,ballRadius + 2]) rotate([180-ballCupAngle,0,180]) cylinder(h=2*ballDiameter,r1=ballRadius+2,r2=1,center=false);
				translate([ball3_x,-ball3_y,0]) cylinder(h=.1,r=ballRadius - plateThickness/4,center=false);
			}
			
			// add mounts for z-hinge
			/*translate([0,-20,plateThickness + 5])
			{
				difference()
				{
					hull()
					{
						rotate([0,90,0]) cylinder(h=34, r=4.5, center=true);
						translate([0,-2,-5.2]) cube([34,13,.1], center=true);
					}
					cube([25,30,30], center=true); // the gap for the hinge
					rotate([0,90,0]) cylinder(h=34.1, r=1.7, center=true); // the hole for the screw to go through
				}
			}
			*/
			// add mounts for cooling fan
			/*translate([0,ball1_y+ballDiameter,4])
			{
				difference()
				{
					hull()
					{
						rotate([0,90,0]) cylinder(h=22, r=4, center=true);
						translate([0,-ballRadius,-2]) cube([22,ballDiameter,4],center=true);
					}
					rotate([0,90,0]) cylinder(h=23, r=1.6, center=true);
					cube([15,20,20], center=true);
				}
			}
            */
		}
		
		// remove a hole for the switch
		/*translate([-4.5,20.8,plateThickness-4]) cube([(switch_x + 2 * switch_fudge),(switch_y + 2 * switch_fudge), switch_z],center=true);
		// remove a hole for the switch locking screws
		translate([0.5,21,plateThickness/2]) rotate([90,90,0]) cylinder(h=20,r=1.1,center=true);
		translate([-9.5,21,plateThickness/2]) rotate([90,90,0]) cylinder(h=20,r=1.1,center=true);
		translate([0.5,14,plateThickness/2]) rotate([90,90,0]) cylinder(h=8,r=2.25,center=true);
		translate([-9.5,14,plateThickness/2]) rotate([90,90,0]) cylinder(h=8,r=2.25,center=true);
        */
		// make mounts for the spring string
		translate([0,-ball3_y,plateThickness/2]) cylinder(h=plateThickness+.1,r=1.3,center=true);
		translate([-(ball1_x+ball2_x)/2,(ball1_y-ball2_y)/2,plateThickness/2]) cylinder(h=plateThickness+.1,r=1.3,center=true);
		translate([(ball1_x+ball2_x)/2,(ball1_y-ball2_y)/2,plateThickness/2]) cylinder(h=plateThickness+.1,r=1.3,center=true);
		
		// make mounts for the probe springs
		/*translate([-(3*ball1_x+ball2_x)/4,(3*ball1_y-ball2_y)/4,plateThickness]) cylinder(h=12,r=1.3,center=true);
		translate([(3*ball1_x+ball2_x)/4,(3*ball1_y-ball2_y)/4,plateThickness]) cylinder(h=12,r=1.3,center=true);
            */
		// remove the hole down the center for the hotend
		/*hull()
		{
			translate([0,0,0]) cylinder(h=100,r=hotendDiameter/2,center=true);
		
			// an additional bump out of the hotend hole for cable routing
			translate([-hotendDiameter/2,0,0]) cylinder(h=100,r=4.5,center=true);
		}
		*/
        translate([0, 0, push_fit_height-plateThickness/2-0.1])
            cylinder(r=hotend_radius+0.2, h=plateThickness/2+2.2, $fn=36);
        translate([0, 0, 1]) # import("m4_internal.stl");
            for (a = [0:60:359]) rotate([0, 0, a]) {
               translate([0, mount_radius, 0])
               cylinder(r=m3_wide_radius, h=2*plateThickness+0.1, center=true, $fn=12);
           }
        
		// remove the spheres from the picture
		translate([0,0,ballRadius + 2]) allTheBalls();
		
		// make sure the bottom is flat
		translate([0,0,-10]) cube([100,100,20],center=true); 
	}
}

module allTheBalls()
{
	translate([-ball1_x,ball1_y,0]) sphere(ballRadius);
	translate([ball1_x,ball1_y,0]) sphere(ballRadius);
	translate([-ball2_x,-ball2_y,0]) sphere(ballRadius);
	translate([ball2_x,-ball2_y,0]) sphere(ballRadius);
	translate([-ball3_x,-ball3_y,0]) sphere(ballRadius);
	translate([ball3_x,-ball3_y,0]) sphere(ballRadius);
}
