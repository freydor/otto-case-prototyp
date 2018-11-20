use <buttons.scad>;

caseThickness = 3.5;

box = [140,195,45];
top = [box[0],box[1],caseThickness];
screen = [86,56,2];
screenView = [77,52,5.1];



difference(){
        translate([0,0,caseThickness/2])
        cube([box[0],box[1], caseThickness],true);
        TopScreen();
        TopEncoder();
        TopKey();
}

module TopEncoder(){
    translate([61,21,0])
    rotate([0,0,90])
        encoderRow(1,16); 

    translate([61,-20,0])
    rotate([0,0,90])
        encoderRow(1,16);
        
    translate([-58,0,0])
    rotate([0,0,90])
        encoderRow(1,25);
}

module TopKey(){
        translate([-30,-55,0])
            keyHole(type="4060",holes=3);

        translate([30,-55,0]){
            keyHole(type="4060",holes=3);
        rotate([0,0,90]){
            drillHoleOffset(PCBLength=40,offsetY=30);
            drillHoleOffset(PCBLength=40,offsetY=-18);
            drillHoleOffset(PCBLength=40,offsetY=83);
        }
    }
        
        drillHoleOffset(PCBLength=120,offsetY=-54);

}

module TopScreen(){
        
        translate([0,2,3])
            cube(screen,true);
        translate([-2.5,2,0])
            cube(screenView,true);
    
        //drillHoleOffset(PCBLength=86,offsetY=17);
        drillHoleOffset(PCBLength=86,offsetY=-1);

    
}    
    
    