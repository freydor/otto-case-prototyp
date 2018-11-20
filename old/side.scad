use <case.scad>;
include <Metric/M3.scad>;


width = 140;
topLength = 120;
bottomLength = 75;
caseThickness = 3.5;
$fs = 0.5;
$fa = 2;
difference(){
    side(length=140,r=3.5);
    
    translate([0,3,17.5])
    rotate([-90,0,0])BoltM3();
    
    
    translate([0,3,-17.5])
    rotate([-90,0,0])BoltM3();
    
    
}
sideLeftHoles();

module sideLeftHoles(){
translate([topLength/2,20,0])
{
    translate([25,3,17.5])
        rotate([-90,0,0])#BoltM3();
    translate([-50,3,17.5])
        rotate([-90,0,0])#BoltM3();

}
translate([-bottomLength/2,20,0])
{
    translate([0,3,17.5])
        rotate([-90,0,0])#BoltM3();


}
}