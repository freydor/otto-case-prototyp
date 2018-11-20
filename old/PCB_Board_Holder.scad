use <buttonTest.scad>;



// Length of Box (X-Axis)
PCBLength=80;		// [20:500]

// Width of Box (Y-Axis)
PCBWidth=20;		// [20:500]

// Height of Board From Base
StandoffHeight=6;	// [8:20]

// Include Mounting Hole Pins
IncludeMountingHolePins=0;	// [1:yes,0:no]

// Include Endstops - Useful if you don't use the mounting hole pins
IncludeEndStops=1;	// [1:yes,0:no]

/* [Hidden] */


$fn=120;

PCBHeight=1.6;
MHoleDiam=2;
HoleOffset=2;

translate([0, 0, 8]) 
	PCBBoard();
    
PCBHolder();

color("Cyan",1.0){
    translate([0,0,-5])
    buttonTestBoard();
}; 
 
module PCBBoard()
{
    difference()
    {
        translate([0, 0, (PCBHeight / 2)]) 
            cube([PCBLength, PCBWidth, PCBHeight], center=true);
        
        for (x=[-1,1])
            for (y=[-1,1])
               translate([(x * (PCBLength / 2)) - (HoleOffset * x), (y * (PCBWidth / 2)) - (HoleOffset * y), -0.1]) cylinder(d=MHoleDiam + 0.2, h=PCBHeight + 0.2);
    }
}

module PCBHolder()
{
	translate([0, 0, 1]) difference()
	{
		cube([PCBLength, PCBWidth + 3.75, 2], center=true);
		cube([PCBLength - 8, PCBWidth - 8, 2.2], center=true);
	}
	
	intersection()
	{
		for (x=[-1,1])
			for (y=[-1,1])
				translate([(x * (PCBLength / 2)) - (HoleOffset * x), (y * (PCBWidth / 2)) - (HoleOffset * y), 0]) 
				{
					if (IncludeMountingHolePins)
					{
						cylinder(d=MHoleDiam - 0.3, h=StandoffHeight + 2.45);
						translate([0, 0, StandoffHeight + 2.45]) sphere(d=MHoleDiam - 0.3);
					}
					translate([0, 0, StandoffHeight / 2]) cube([4, 4, StandoffHeight], center=true);
					translate([0, y * 3.25, (StandoffHeight + 7) / 2]) cube([4, 1.25, StandoffHeight + 7], center=true);
					
					translate([0, y * 8.1, StandoffHeight + 3.5]) rotate([0, 90, 0]) cylinder(d=13, h=4, center=true);
					
					if (IncludeEndStops)
					{
						translate([2.5 * x, 0, (StandoffHeight + PCBHeight + 1) / 2]) cube([1, 4, StandoffHeight + PCBHeight + 1], center=true);
					}
				}
				
		translate([0, 0, (StandoffHeight + 12) / 2]) cube([PCBLength + 5, PCBWidth + 3.75, StandoffHeight + 12], center=true);
	}
}

