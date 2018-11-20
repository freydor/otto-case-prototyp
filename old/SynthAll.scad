use <buttons.scad>;
use <case.scad>;

caseThickness = 3.5;

box = [140,195,45];
top = [box[0],box[1],caseThickness];


screenpos = [25,55,10];
screen = [86,56,8];
screenView = [77,52,3];


assemble();
        drillHoleOffset(PCBLength=120,offsetY=-54);

module assemble(){
    
    
    color("green"){
    for(i = [-1,1]){
        difference(){
     translate([box[0]/2 *i + i*caseThickness/2 ,0,box[2]/2 + caseThickness]){
        
            cube([caseThickness,box[1],box[2]],true);

         }
        translate([box[0]/2 *i - i*caseThickness/2 ,0,15/2+ caseThickness]){

            translate([i*+6,0,0])
            rotate([0,i*90,0])
            #BoltM3();
        }
        translate([box[0]/2 *i - i*caseThickness/2 ,0,box[2]- caseThickness]){

            translate([i*+6,0,0])
            rotate([0,i*90,0])
            #BoltM3();
        }
     }
        
       translate([box[0]/2 *i - i*caseThickness/2 ,0,15/2+ caseThickness]){
           difference(){
                cube([caseThickness,10,15],true);
                translate([i*-2,0,0])
                rotate([0,i*-90,0])
                NutM3();

           }
         }

       translate([0,box[1]/2 *i - i*caseThickness/2,15/2 + caseThickness]){
           
           difference(){
                cube([10,caseThickness,15],true);
                translate([0,i*-2,0])
                rotate([i*90,0,0])
                NutM3();
           }
         }


        
    }
    difference(){
       translate([0,(box[1]/2 + caseThickness/2),box[2]/2 + caseThickness]){
            side(box[0],box[2]);
       }
              translate([0,(box[1]/2 + caseThickness + 1),15/2 + caseThickness])
        rotate([-90,0,0])
        #BoltM3();
       
      translate([0,(box[1]/2 + caseThickness + 1),box[2] -(15/2- caseThickness)])
        rotate([-90,0,0])
        #BoltM3();
       
   }
   
       difference(){
       translate([0,-(box[1]/2 + caseThickness/2),box[2]/2 + caseThickness]){
           rotate([180,0,0]) 
           side(box[0],box[2]);
       }
       
 translate([0,-(box[1]/2 + caseThickness + 1),15/2 + caseThickness])
        rotate([90,0,0])
        #BoltM3();
       
        translate([0,-(box[1]/2 + caseThickness + 1),box[2] - (15/2 - caseThickness)])
        rotate([90,0,0])
        #BoltM3();
   }


       }//Green
    
    difference(){
    hull(){
    for(i = [-1,1]){
        translate([box[0]/2*i,box[1]/2,0])
        linear_extrude(height = caseThickness)
        circle(caseThickness);    
    }
       
    for(i = [-1,1]){
        translate([box[0]/2 *i,-box[1]/2,0])
        linear_extrude(height = caseThickness)
        circle(caseThickness);    
    }
    }
    
    
    
    //Screen
    //Encoders
    translate([0,30,0]){
    translate([0,31,5]){
        cube(screen,true);
        rotate([0,0,90]){
        drillHoleOffset(PCBLength=56,offsetY=-25);
        drillHoleOffset(PCBLength=56,offsetY=42);
        }
    }
     translate([-2,31,-0.1])
        cube(screenView,true);
       //Encoders
    translate([55,31,+1])
          rotate([0,0,-90])
                encoderRow(3,15);
    
    translate([-55,31,+1])
          rotate([0,0,-90])
                encoderRow(2,15);
    
    
    *translate([-11.3,17,0]){
           rotate([0,0,-90]){

               
               keyHole(type="2080",holes=-1);
               
              #drillHoleOffset(PCBLength=80,offsetY=0);
           }
       }
    }    

   //Midi Keyboard 
    //buttons low left
 translate([-33,-60,0]){
        rotate([0,0,-90])
        keyHole(type="5070MIDIC",holes=3);
        drillHoleOffset(PCBLength=100,offsetX=25,offsetY=-33);
        drillHoleOffset(PCBLength=100,offsetX=25,offsetY=23);

    translate([50,0,0])
            rotate([0,0,-90])
                keyHole(type="5070MIDIF",holes=3);
    *translate([-55,-5,0])    
        rotate([0,0,-90])
        keyHole(type="4060",holes=3);
   }
   
translate([-28,3,0]){    
    rotate([0,0,-90])
    drillHoleOffset(PCBLength=40,offsetY=-30);
    rotate([0,0,-90])
    drillHoleOffset(PCBLength=40,offsetY=30);
    rotate([0,0,-90])
    drillHoleOffset(PCBLength=40,offsetY=79);

        keyHole(type="4060",holes=3);
  translate([60,0,0])    
        //rotate([0,0,-90])
        keyHole(type="4060",holes=3);
  
}    
   //Buttons
   *translate([-40,-5,0])     
   //rotate([0,0,-90])
    keyHole(type="2080",holes=3);
    }
}




