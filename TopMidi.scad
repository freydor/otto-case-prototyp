use <buttons.scad>;

caseThickness = 3.5;

box = [135,195,45];

difference(){
        translate([0,0,caseThickness/2])
        cube([box[0],box[1], caseThickness],true);
    
        TopMidi();
}

module TopMidi(){
        translate([-25,0,0])
        rotate([0,0,-90])
            keyHole(type="5070MIDIC",holes=3);
        translate([25,0,0])
            rotate([0,0,-90])
                keyHole(type="5070MIDIF",holes=3);

        //rotate([0,0,-90])
        drillHoleOffset(PCBLength=101,offsetX=0,offsetY=8);
        drillHoleOffset(PCBLength=101,offsetX=0,offsetY=-23);
}