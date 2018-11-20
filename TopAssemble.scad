use <buttons.scad>;
use <case.scad>;
use <TopScreen.scad>;
use <TopMidi.scad>;

width = 140;
topLength = 120;
bottomLength = 75;
caseThickness = 3.5;

translate([0,topLength/2 ,0])
frontTopPart();

translate([0,-bottomLength/2,0])
frontBottomPart();

//rotate([0,0,90])
//sideLeft();

module frontTopPart(){

    difference(){
        rotate([0,0,180])
                roundRect([width,topLength,caseThickness],r=caseThickness,upper=false);

        translate([0,25,0]){
            TopScreen();
            TopEncoder();
            TopKey();
          
        }
        drillHoleOffset(PCBLength=110,offsetY=-topLength/2+ 5,offsetX=-2.5);
    }
    screwMount(width,mountWidth=12,offsetY= 25);
    screwMount(width,offsetY= -50);
    rotate([0,0,90])
    screwMount(topLength,offsetY= 0,single=true);

}

module frontBottomPart(){

    difference(){
        roundRect([width,bottomLength,caseThickness],r=caseThickness,upper=false);
        translate([0,2.5,0]){
            TopMidi();
          
        }
        drillHoleOffset(PCBLength=110,offsetY=bottomLength/2 - 5,offsetX=-2.5);     
    }
    screwMount(width,offsetY= 0);
    rotate([0,0,-90])
    screwMount(bottomLength,offsetY= 0,single=true);
}