include <lib/Metric/M3.scad>;
use <lib/rpi3.scad>;
use <TopAssemble.scad>;
    
caseThickness = 3.5;

box = [145,190,50];
top = [box[0],box[1],caseThickness];

width = 140;
topLength = 120;
bottomLength = 75;
caseThickness = 3.5;

sideHolesTop = 1;
topTopHolesOffset = [0,0];
topBotHolesOffset = [10,0];
bottomTopHolesOffset = [-35,0];
bottomBotHolesOffset = [-35,0];


$fs = 0.5;
$fa = 2;

translate([0,topLength/2 ,box[2] + 2*caseThickness])
rotate([0,180,0])
frontTopPart();

translate([0,-bottomLength/2,box[2] + 2*caseThickness])
rotate([0,180,0])
frontBottomPart();

difference(){
    union(){
        translate([0,topLength/2 ,0])
            bottomTop();
        translate([0,bottomLength/-2,0])
            bottomBottom();
        
        translate([0,(topLength-bottomLength)/2,0])
        rotate([0,0,90])screwMount(box[1]);

        
        translate()
            sideRounded();
        
        side(length=box[1],heigth=box[2]);
        
        translate([-32,box[1]/2 - 5,0])
            raspberryMount(); 
    }
    
    translate([0,0,box[2]/2])sideLeftHoles();
    
    
    screwHole(offsetY=-37.5,offsetX=box[0]/-2,offsetZ=caseThickness + 7.5,side=-1);
    
    screwHole(offsetY=25,offsetX=box[0]/-2,offsetZ=caseThickness + 7.5,side=-1);
    
    color("blue"){
        translate([-32,box[1]/2 - 3,0]){ 
            raspberryPlugs(); 
    
            }
        }
}
 

module bottomTop(){
        rotate([0,0,180])
         roundRect([width,topLength,caseThickness],r=caseThickness,upper=false);
        screwMount(box[0] - caseThickness,offsetY= bottomTopHolesOffset[0]);
    

}

module bottomBottom(){
         roundRect([width,bottomLength,caseThickness],r=caseThickness,upper=false);
        screwMount(box[0] - caseThickness,offsetY=0);

}
    
module roundRect(size, r, upper=true,center=true){
    if(!upper){
        hull(){
            for(i = [-1,1]){
                translate([size[0]/2*i,size[1]/2 - r,r/2])
                    cube([2*r,2*r,r],true); 
            }
       
            for(i = [-1,1]){
                translate([size[0]/2 *i,-size[1]/2,0])
                    linear_extrude(height = r)
                    circle(r);    
            }       
        }
    }
    else{
        hull(){
    for(i = [-1,1]){
        translate([size[0]/2*i,size[1]/2,0])
        linear_extrude(height = caseThickness)
            circle(caseThickness);    
    }
       
    for(i = [-1,1]){
        translate([size[0]/2 *i,-size[1]/2,0])
        linear_extrude(height = caseThickness)
        circle(caseThickness);    
        }
        }
    }
 }
 
 module screwHole(offsetX=0,offsetY=0,offsetZ=0,side=1){ 
        
            translate([offsetX,offsetY,offsetZ])
                rotate([0,side*90,0])
                    BoltM3(inset=0);
}
 
 
 module screwMount(width,mountWidth=15,caseThickness=3.5,offsetY=0,single=false){
     if(!single){
      for(i = [-1,1]){
            translate([width/2 *i - i*caseThickness/2 ,offsetY,15/2+ caseThickness]){
           difference(){
                cube([caseThickness,mountWidth,15],true);
                translate([i*-2,0,0])
                rotate([0,i*-90,0])
                NutM3();
           }
         }
     }
 }
     else{
         i = 1;
          translate([width/2 *i - i*caseThickness/2 ,offsetY,mountWidth/2+ caseThickness]){
           difference(){
                cube([caseThickness,mountWidth,15],true);
                translate([i*-2,0,0])
                rotate([0,i*-90,0])
                NutM3();

           }
         }  
     }
 }

//caseClip();
module caseClip(){
    difference(){
    cube([20,7,caseThickness],true);
    translate([5,0,+2])
        NutM3();
    translate([-5,0,+2])
        NutM3();
            
    }
    }

module sideLeftHoles(offsetY=21){
translate([box[0]/-2 -3,topLength/2,offsetY])
{
    translate([0,25,0])
        rotate([-90,0,90])BoltM3();
    translate([0,-50,0])
        rotate([-90,0,90])BoltM3();

}
translate([box[0]/-2 -3,-bottomLength/2,offsetY])
{
    translate([0,0,0])
        rotate([-90,0,90])BoltM3();


}
}
module side(length=140,heigth=50){
            
    //translate([0,0,box[2]/2])sideLeftHoles();

        translate([width/-2+caseThickness/-2 , (topLength-bottomLength)/2  ,box[2]/2 + caseThickness])
    difference(){        
        cube([caseThickness,topLength+bottomLength,box[2]],true);
    
    }
       *translate([width/2+caseThickness/2 , (topLength-bottomLength)/2  ,box[2]/2 + caseThickness])
            cube([caseThickness,topLength+bottomLength,50],true);

}
module sideRounded(length=140,heigth=50,r=caseThickness){
    
    translate([0,topLength + caseThickness/2 ,box[2]/2 + caseThickness])
    union(){
      
        cube([length,caseThickness,heigth],true);
        *translate([0,-3,heigth/2 - caseThickness/2 - caseThickness ])
            cube([length,3.5,3],true); 
        *translate([0,-3, caseThickness/2 + caseThickness  - heigth/2 ])
            cube([length,3.5,3],true); 
        
        for(i = [-1,1]){
        translate([i * length/2 ,-r + caseThickness/2,-heigth/2 ])
        difference(){
            cylinder(r=r,h=heigth);
            translate([-r,-r,-1])
                cube([2*r,2*r - caseThickness,heigth +5]);
           
        }
    }
}
}