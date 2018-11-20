use <buttons.scad>;

difference(){
    surface(PCBWidth = 40);
    keyHole(holes=1,type="2080");
}

translate([0,35,0])
    mountPCBConnectorSplit([80,20,1.61]); 

translate([-15,40,0])
    rotate([0,-90,0])
    mountPCBHolder([80,20,1.61]);
    