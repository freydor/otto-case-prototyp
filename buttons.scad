include <lib/Metric/M3.scad>;

$fs = 0.5;
$fa = 2;

// Length of Box (X-Axis)
PCBLength=80;		// [20:500]

// Width of Box (Y-Axis)
PCBWidth=20;		// [20:500]
PCBThickness = 1.6;
PCBGrid = 2.54;

mountStrength = 1;
caseThickness = 3.5;

top = [100,22,caseThickness];
buttonTolerance = 0.65;
button = [10 ,10 ,10];
buttonPinOffset = 3.5;

module keyrow(number,size,pcbGrid = 2.54,pcbOffset=3,pcbGridSpace=3) {
        
        pos = size[0] + 2 + ((pcbGridSpace*pcbGrid)-(2*pcbOffset)); 
        translate([(-(number*pos)/2),0,0]){
        for ( step = [0 : number]){    
            echo (step);  
            echo(pos*step);
            translate([pos*step,0,0])    
            cube([size[0] + buttonTolerance,size[1] + buttonTolerance,10],true);
            translate([pos*step,0,caseThickness  ])    
            cube([size[0] + 2 + buttonTolerance, size[1] + 2 + buttonTolerance,2],true);
        }
     }
 }
 
 module encoderRow(number,offset) {
        
        pos = offset; 
        translate([(-(number*pos)/2),0,0]){
        for ( step = [0 : number]){    
            echo(pos*step);
            translate([pos*step,0,-4]){    
            cylinder(r=4,h=10);
            translate([0,0,2.8 + caseThickness])    
            cube([12,15,2.5],true);
            }
        }
     }
 }
 
module mountHoles(PCBLength = 80,holes=0){
        
    if(holes== 0){
        translate([PCBLength/2 + 6,0,1])
        rotate([180,0,0]){
            BoltM3(inset=0);
        }
        
        translate([-(PCBLength/2 + 6),0,1])
        rotate([180,0,0]){
            BoltM3(inset=0);
        }    
     }
    
    if(holes==1){
        translate([PCBLength/2 + 6,0,1])
        rotate([180,0,0]){
            BoltM3(inset=0);
        }
     }        
     
     if(holes==2){
        translate([-(PCBLength/2 + 6),0,1])
        rotate([180,0,0]){
            BoltM3(inset=0);
        }    
     }
    }
 
 module mountHolesConnector(PCBLength = 80,PCBWidth = 20,holes=0){
     if(holes==0){
     translate([PCBLength/2  ,PCBWidth/2 + 4.75  ,1])
        rotate([180,0,0]){
            BoltM3(inset=0);
        }
        
        translate([PCBLength/2 ,- (PCBWidth/2 + 4.75)  ,1])
        rotate([180,0,0]){
            BoltM3(inset=0);
        }

     translate([-(PCBLength/2 ) ,PCBWidth/2 + 4.75  ,1])
        rotate([180,0,0]){
            BoltM3(inset=0);
        }
        
        translate([-(PCBLength/2 ),- (PCBWidth/2 + 4.75)  ,1])
        rotate([180,0,0]){
            BoltM3(inset=0);
        }
    }
     if(holes==1){
     translate([PCBLength/2  ,PCBWidth/2 + 4.75  ,1])
        rotate([180,0,0]){
            BoltM3(inset=0);
        }
        
        translate([PCBLength/2 ,- (PCBWidth/2 + 4.75)  ,1])
        rotate([180,0,0]){
            BoltM3(inset=0);
        }
    }
         if(holes==2){
             
     translate([-(PCBLength/2 ) ,PCBWidth/2 + 4.75  ,1])
        rotate([180,0,0]){
            BoltM3(inset=0);
        }
        
        translate([-(PCBLength/2 ),- (PCBWidth/2 + 4.75)  ,1])
        rotate([180,0,0]){
            BoltM3(inset=0);
        }
    }
 }
     
 module mountPCBHolder(size,border = 5) {
    l = size[1] + 5;
    PCBl = size[1] + 1 ;
    w = 12;
     
     difference(){
        cube([w, l ,6]);        
    
        translate([-1,(l-PCBl)/2,3])
            cube([5, PCBl ,size[2] + 0.5]);
    
        translate([8,l/2,5])
            NutM3(); //Offset to PCB 4mm
    }
}

module mountPCBConnectorSplit(size) {
    l = size[1] + 16;
    PCBl = size[1] + 1 ;
    w = 8;
    
    difference(){
        cube([w, l ,3]);  
        
        translate([-3,(l-PCBl)/2,-1])
            cube([5, PCBl , 7]);
        translate([w/2 + 2,(l-PCBl)/2,-1])
            cube([4, PCBl , 7]);
        
        translate([w/2 , (l - PCBl)/4 ,6])
            NutM3(); 
        translate([w/2,l - (l - PCBl)/4    ,6])
            NutM3(); 
    }
    translate([20,0,0]){
        difference(){
        cube([w, l ,4.7]);  
        
        translate([-3,(l-PCBl)/2 + 2,-1])
            cube([5, PCBl  - 4, 7]);
        translate([w/2 + 2,(l-PCBl)/2 + 2,-1])
            cube([5, PCBl - 4 , 7]);

        translate([-1,(l-PCBl)/2,2]){
           cube([14, PCBl ,size[2] + 15]);  
        }
        
        translate([w/2, (l - PCBl)/4  ,0])
            rotate([0,180,0])
            NutM3(); 
        translate([w/2,l - (l - PCBl)/4 ,0])
            rotate([0,180,0])        
            NutM3(); 
        }
    }

}


module mountPCBConnector(size,border = 5) {
    l = size[1] + 16;
    PCBl = size[1] + 1 ;
    w = 12;
    
    difference(){
        cube([w, l ,5]);  
        
        translate([-1,(l-PCBl)/2,-1])
            cube([5, PCBl , 7]);
        translate([w/2 + 2,(l-PCBl)/2,-1])
            cube([5, PCBl , 7]);

        translate([-1,(l-PCBl)/2,2]){
            cube([14, PCBl ,size[2] + 0.5]);
            
        }
        
        echo("Position Connector holes");
        translate([w/2, (l - PCBl)/4 ,6])
            NutM3(); 
        echo((l - PCBl)/4);
        translate([w/2,l - (l - PCBl)/4    ,6])
            #NutM3(); 
        echo(l - (l - PCBl)/4 );
        echo((l - (l - PCBl)/4) - ((l - PCBl)/4));
        echo("Abstand pcb" ,(l-PCBl)/2 - (l - PCBl)/4 );
    }
}
     
 module surface(PCBLength=80,PCBWidth=20){
        translate([0,0,caseThickness/2])
            cube([PCBLength + 20,PCBWidth +10 ,caseThickness],true);
}

module key3070MIDICHoles(PCBGrid=2.54){
               
            translate([0,-3.5*PCBGrid,0])
                keyrow(3,button,PCBGrid,pcbOffset=buttonPinOffset);  
            
            translate([-1 *PCBGrid -((3 * PCBGrid) - 7),2*PCBGrid,0])
                keyrow(1,button,PCBGrid,pcbOffset=buttonPinOffset);  
    
             //mountHoles(PCBLength=70);
             //mountHolesConnector(PCBLength=70,PCBWidth=30);

}


module key3070MIDIFHoles(PCBGrid=2.54){
               
            translate([0,-3.5*PCBGrid,0])
                keyrow(3,button,PCBGrid,pcbOffset=buttonPinOffset);  
            
            translate([-4*PCBGrid -((3 * PCBGrid) - 7),2*PCBGrid,0])
                keyrow(2,button,PCBGrid,pcbOffset=buttonPinOffset);  
            
            mountHolesConnector(PCBLength=70,PCBWidth=30);
}

module key3070Holes(PCBGrid=2.54){
               
            translate([0,-3.5*PCBGrid,0])
                keyrow(3,button,PCBGrid,pcbOffset=buttonPinOffset);  
            
            translate([0,2.5*PCBGrid,0])
                keyrow(3,button,PCBGrid,pcbOffset=buttonPinOffset);  
            
}

module key4060Holes(PCBGrid=2.54){
    rotate([0,0,90]){
            translate([0.5*PCBGrid,0,0]){
            translate([0,5*PCBGrid,0])
                keyrow(2,button,PCBGrid,pcbOffset=buttonPinOffset);             
    
            translate([0,-1*PCBGrid,0])
                keyrow(2,button,PCBGrid,pcbOffset=buttonPinOffset);  
            
            translate([0,-7*PCBGrid,0])
                keyrow(2,button,PCBGrid,pcbOffset=buttonPinOffset);  
    }        
}
           // mountHoles(PCBLength=70);
}

module key5070Holes(PCBGrid=2.54){
             translate([0,7.5*PCBGrid,0])
                keyrow(3,button,PCBGrid,pcbOffset=buttonPinOffset);             
    
            translate([0,2.5*PCBGrid,0])
                keyrow(3,button,PCBGrid,pcbOffset=buttonPinOffset);  

            translate([0,-2.5*PCBGrid,0])
                keyrow(3,button,PCBGrid,pcbOffset=buttonPinOffset);  
            
            translate([0,-7.5*PCBGrid,0])
                keyrow(3,button,PCBGrid,pcbOffset=buttonPinOffset);  
                        
           // mountHoles(PCBLength=70);
}

module key5070MidiCHoles(PCBGrid=2.54){
               
            rotate([0,0,90]){
            translate([0,-9*PCBGrid,0])
                keyrow(3,button,PCBGrid,pcbOffset=buttonPinOffset);  

            translate([-1*PCBGrid,-3*PCBGrid,0])
                keyrow(1,button,PCBGrid,pcbOffset=buttonPinOffset);  
            
            translate([2.5*PCBGrid,3*PCBGrid,0])
                keyrow(2,button,PCBGrid,pcbOffset=buttonPinOffset);  
                        
    
            translate([4*PCBGrid,9*PCBGrid,0])
                keyrow(1,button,PCBGrid,pcbOffset=buttonPinOffset);  
            }
            //mountHoles(PCBLength=70);
}

module key5070MidiFHoles(PCBGrid=2.54){
               
            rotate([0,0,90]){
            translate([-1.5*PCBGrid,-9*PCBGrid,0])
                keyrow(2,button,PCBGrid,pcbOffset=buttonPinOffset);  

            translate([-2.5*PCBGrid,-3*PCBGrid,0])
                keyrow(2,button,PCBGrid,pcbOffset=buttonPinOffset);  
            
            translate([0*PCBGrid,3*PCBGrid,0])
                keyrow(3,button,PCBGrid,pcbOffset=buttonPinOffset);  
                        
    
            translate([1.5*PCBGrid,9*PCBGrid,0])
                keyrow(2,button,PCBGrid,pcbOffset=buttonPinOffset);  
            }
}

module key2080Holes(PCBGrid=2.54,holes=0){
        keyrow(5,button,PCBGrid,pcbOffset=buttonPinOffset);  
        
        if(holes==0){
            mountHoles();
        }
        if(holes==1){
            mountHoles(holes=2);
            mountHolesConnector(holes=1);
        }    
        if(holes==2){
            mountHolesConnector(holes=2);
            mountHoles(holes=1);
        }    
        if(holes==3){
            mountHolesConnector(holes=0);
        }    

}

module drillHoles(holes=0,PCBLength=80,PCBWidth=20){
        if(holes==0){
            mountHoles(PCBLength=PCBLength);
        }
        if(holes==1){
            mountHoles(holes=2,PCBLength=PCBLength);
            mountHolesConnector(holes=1,PCBLength=PCBLength,PCBWidth=PCBWidth);
        }    
        if(holes==2){
            mountHolesConnector(holes=2,PCBLength=PCBLength,PCBWidth=PCBWidth);
            mountHoles(holes=1,PCBLength=PCBLength);
        }    
        if(holes==3){
            mountHolesConnector(holes=0,PCBLength=PCBLength,PCBWidth=PCBWidth);
        }  
}

module drillHoleOffset(PCBLength=80,PCBWidth=20,offsetX=0,offsetY=0,left=true,right=true){
    
        translate([PCBLength/2 + 4.25 + offsetX,offsetY,2])
        rotate([0,180,0])
            BoltM3(inset=0);
        translate([-PCBLength/2 - 4.25 + offsetX,offsetY ,2])
                   rotate([0,180,0])
            BoltM3(inset=0);
        

}

module keyHole(PCBGrid=2.54,holes=0,type="2080"){
    if (type=="2080"){
        key2080Holes(holes=holes);
       translate([0,0,10])
              #cube([80,20,2],true);
    }
    else if (type=="3070MIDIC"){
        key3070MIDICHoles();
        drillHoles(holes=holes,PCBLength=70,PCBWidth=30);
    }   
    else if (type=="3070MIDIF"){
        key3070MIDIFHoles();
        drillHoles(holes=holes,PCBLength=70,PCBWidth=30);
    }  
    else if (type=="3070"){
        key3070Holes();
        //drillHoles(holes=holes,PCBLength=70,PCBWidth=30);
    }
        else if (type=="4060"){
        key4060Holes();
                   translate([0,0,10])
              #cube([60,40,2],true);
        //drillHoles(holes=holes,PCBLength=60,PCBWidth=40);
    }
    else if (type=="5070"){
        key5070Holes();
        drillHoles(holes=holes,PCBLength=70,PCBWidth=50);
    }
    else if (type=="5070MIDIC"){
        key5070MidiCHoles();
                           translate([0,0,10])
              #cube([70,50,2],true);
        //drillHoles(holes=holes,PCBLength=70,PCBWidth=50);
    }
    else if (type=="5070MIDIF"){
        key5070MidiFHoles();
                                   translate([0,0,10])
              #cube([70,50,2],true);
        //drillHoles(holes=holes,PCBLength=70,PCBWidth=50);
    }
}

module DemoMounts(){
        translate([0,-50,0])
        mountPCBHolder([80,20,PCBThickness]);
    
        translate([0,-110,0])
        mountPCBConnector([80,20,PCBThickness]);    

        translate([0,-150,0])
        mountPCBConnectorSplit([80,20,PCBThickness]);  

    translate([34,-18,8])
        mountPCBConnector([80,20,PCBThickness]);
        
    translate([-38,12.5,8])
        rotate([0,0,180]){
        mountPCBHolder([80,20,PCBThickness]);
        }
        
        translate([0,0,6])
        %cube([80,20,1.6],true);
        
        translate([-20,-60,0])
        mountPCBHolder([80,30,PCBThickness]);
    
        translate([-20,-110,0])
        mountPCBConnector([80,30,PCBThickness]);
    
    } 
DemoPlate();
 module DemoPlate(){
   DemoMounts();
  translate([0,0,0]){
        difference(){
            surface(PCBWidth = 30);
            key2080Holes(holes=1);
        }
    }
    
  translate([0,70,0]){
        difference(){
            surface(PCBWidth = 60,PCBLength=30);
            key4060Holes(holes=1);
        }
    }
    
    translate([100,0,0]){
        difference(){
            surface(PCBLength=70,PCBWidth=30);
            key3070MIDICHoles();
            
        }
    }

    translate([100,50,0]){
        difference(){
            surface(PCBLength=70,PCBWidth=30);
            key3070MIDIFHoles();
        }
    }

    translate([100,-60,0]){
        difference(){
            surface(PCBLength=70,PCBWidth=30);
            key3070Holes();
            translate([0,0,6])
                %cube([70,30,1.6],true);
            drillHoleOffset(PCBLength=70);
        }
        translate([43,-6,10])
        rotate([0,0,90]){
        mountPCBConnectorSplit([0,70,PCBThickness]);}

    }    
    translate([-100,0,0]){
        difference(){
            surface(PCBLength=70,PCBWidth=70);
            key5070MidiCHoles();
        }
    }
        translate([-100,100,0]){
        difference(){
            surface(PCBLength=70,PCBWidth=70);
            key5070MidiFHoles();
        }
    }
    
 }