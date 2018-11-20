use <buttons.scad>;
PCBThickness = 1.6;


translate([-30,0,0])
    mountPCBConnectorSplit([40,120,PCBThickness]);         
translate([0,0,0])
    rotate([0,0,0])
    mountPCBConnectorSplit([40,86,PCBThickness]);         
translate([30,0,0])
    rotate([0,0,0])
    mountPCBConnectorSplit([40,101,PCBThickness]);     