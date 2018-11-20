include <Metric/M3.scad>;

caseThickness = 3.5;

box = [210,140,90];
top = [box[0],box[1],caseThickness];

$fs = 0.5;
$fa = 2;
difference(){
hull(){
    for(i = [-1,1]){
        translate([box[0]/2*i,box[1]/2,0])
        linear_extrude(height = caseThickness)
            circle(4);    
    }
       
    for(i = [-1,1]){
        translate([box[0]/2 *i,-box[1]/2,0])
        linear_extrude(height = caseThickness)
        circle(4);    
    }
}    
    for(i = [-1,1]){
        translate([box[0]/2*i,box[1]/2,0])
            NutM3();
    }    
    for(i = [-1,1]){
        translate([box[0]/2 *i,-box[1]/2,0])
            rotate([180,0,0])   
            #BoltM3();
    }

}
side();
module side(){
    
    translate([-107,0,55/2 + 3.5]){
        rotate([0,90,0])
            cube([55,135,3.5],true);
        translate([2,-70,-27]){ 
            linear_extrude(height = caseThickness)
            circle(4,true);
     
        }

    }
    
}