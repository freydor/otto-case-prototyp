include <lib/Metric/M3.scad>;
use <old/PCB_Board_Holder.scad>

// Length of Box (X-Axis)
PCBLength=80;		// [20:500]

// Width of Box (Y-Axis)
PCBWidth=20;		// [20:500]
pcbThickness = 1.6;
pcbGrid = 2.54;

mountStrength = 1;
caseThickness = 3.5;
MHoleDiam=2;
HoleOffset=2;

$fs = 0.5;
$fa = 2;

box = [95,22,90];
screen = [89,56,8];
screenpos = [25,55,10];
midipos = [0,0,0];
leftkeyspos = [8,-10,0];
leftkeys2pos = [70,25,0];
leftkeys2rot = [0,0,90];
rightkeyspos = [-85,-20,0];
encoderpos = [230,15,0];
encoderrot = [0,0,90];

buttonTolerance = 0.35;
button = [10 + buttonTolerance,10 + buttonTolerance ,10];
buttonPinOffset = 3.5;

keyboardkeyslow = 5;
keyboardkeyhigh = 3;

buttonTestBoard();
//pcbMount();
//translate([0,30,0])
//translate([0,-PCBWidth/2 - d_head_m3/2 , caseThickness + (1+pcbThickness)/2])
//translate([0,0,(mountStrength+pcbThickness) /2 ])
//pcbMountScrew();

translate([0,40,0]){
    rotate([90,0,0]){
    pcbHolder([PCBLength,PCBWidth,pcbThickness]);
    translate([0,0,10])
    pcbHolder([PCBLength,PCBWidth,pcbThickness]);
    }
}
translate([0,0,8])
    cube([PCBLength, PCBWidth, pcbThickness], center=true);

module prism(l, w, h){
    polyhedron(
        points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
   );
}
module pcbMount(width =3, edges = true){
    translate([0,PCBWidth/2, caseThickness + (1+pcbThickness)/2]){
        difference(){
        cube([PCBLength + 2 , width , mountStrength+pcbThickness],center=true);
        translate([0,-1,- mountStrength/2])    
        cube([PCBLength +1, width +0.1 , pcbThickness + 0.1],center=true);
         
          //only edges 
         if(edges)   
            cube([PCBLength * 0.8 , 3 + .1, mountStrength+pcbThickness + 0.1],center=true);  
            
            translate([PCBLength/2 +1.8 ,-2,2.5]){
            rotate([0,90,90])
            prism(4,PCBLength * 0.2/2 + 2,mountStrength+pcbThickness  +1);
            }    
            translate([-PCBLength/2 -1.8 ,-1.6,-1.5]){
            rotate([0,-90,-90])
            prism(4,PCBLength * 0.2/2 + 2,mountStrength+pcbThickness  +1);
            }
        }
    }
}
module pcbMountScrewHole(){
            translate([0,-PCBWidth/2 - d_head_m3/2 -0.5 , -1]){
            rotate([180,0,0]){
                BoltM3();
                }}
}
module pcbMountScrew(width =9, edges = true){
        //translate([0,-PCBWidth/2 - d_head_m3/2 , caseThickness + (1+pcbThickness)/2]){
    
        difference(){
        cube([12 , width , mountStrength+pcbThickness],center=true);
            
        translate([0,5, mountStrength/2])    
        cube([13, width /2 , pcbThickness + 0.1],center=true);
         
         translate([0,-1,0])   
         NutM3(inset=0); 
         
          //only edges 
         //if(edges)   
         //   cube([PCBLength * 0.8 , 3 + .1, mountStrength+pcbThickness + 0.1],center=true);   
        }
    //}
}

module pcbHolder(size,border = 5) {
    
    difference(){
    
    cube([12, size[1] + border ,5]);        
    
    translate([-1,2.5,2])
        #cube([5,PCBWidth + 0.8 ,pcbThickness + 0.5]);
    
    translate([8,(size[1] + 5)/2,5])
    NutM3(); //Offset to PCB 4mm
    }
    
}

module rounded_rect(x, y, z, radius) {
	echo("Draw Rounded Rectangle.");
	linear_extrude(height=z)
            minkowski() {
			square([x,y],center=true);
			circle(r = radius);
		}
}

module keyrow(number,size,pcbGrid = 2.54,pcbOffset=3,pcbGridSpace=4) {
        
        //pos =  pcbGrid + size[0] + (pcbOffset-pcbGrid);
        pos = size[0] + 2 + ((pcbGridSpace*pcbGrid)-(2*pcbOffset)); 
        translate([(-(number*pos)/2),0,0]){
        for ( step = [0 : number]){    
            echo (step);  
            echo(pos*step);
            translate([pos*step,0,0])    
            cube([size[0],size[1],10],true);
            translate([pos*step,0,caseThickness  ])    
            #cube([size[0] + 2, size[1] + 2,2],true);
        }
     }
 }
//rounded_rect(box[0],box[1],3,5);

module buttonTestBoard(){
    translate([0,0,0]){
    difference(){
        rounded_rect(box[0],box[1],3,caseThickness);
    
        translate(midipos)   
        keyrow(4,button,pcbGrid,pcbOffset=buttonPinOffset);  
        
        translate([PCBLength/2 + 6,0,1])
        rotate([180,0,0]){
        #BoltM3(inset=0);
        }
        translate([-(PCBLength/2 + 6),0,1])
        rotate([180,0,0]){
        BoltM3(inset=0);
        }
        
        //pcbMountScrewHole();
        *translate([0,0,-10])
        cube([100,20,100]);

     

    }
}
}