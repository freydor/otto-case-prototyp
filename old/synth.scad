box = [180,120,90];
screen = [89,56,8];
screenpos = [25,55,10];
midipos = [-85,-5,0];
leftkeyspos = [8,-10,0];
leftkeys2pos = [70,25,0];
leftkeys2rot = [0,0,90];
rightkeyspos = [-85,-20,0];
encoderpos = [230,15,0];
encoderrot = [0,0,90];
button = [10,10];

keyboardbuttonholes = [[90,10,-3],[102,10,-3],[114,10,-3],[126,10,-3],[138,10,-3],[150,10,-3],[162,10,-3],[174,10,-3],[186,10,-3],
                         [198,10,-3],[210,10,-3],[222,10,-3],[234,10,-3],[246,10,-3],
                         [96,25,-3],[108,25,-3],[132,25,-3],[144,25,-3],[156,25,-3],[180,25,-3],[192,25,-3],[216,25,-3],[228,25,-3],[240,25,-3]];
                         
keyleftbuttonholes = [[10,45,-3],[22,45,-3],[34,45,-3],[46,45,-3],[58,45,-3],[70,45,-3],[82,45,-3],[94,45,-3],[106,45,-3],
                                    /*[10,75,-3], [10,90,-3]*/];
                                    
keyleftbuttonholes2 = [  [10,60,-3], [22,60,-3], [34,60,-3], [46,60,-3], [58,60,-3], [70,60,-3], [82,60,-3], /*[94,60,-3], [106,60,-3],*/];
                                    
keyrightbuttonholes = [[235,60,-3],[247,60,-3],
                                      [235,73,-3],[247,73,-3],
                                       [235,86,-3],[247,86,-3],
                                       [235,99,-3],[247,99,-3],
                                       [235,122,-3],[247,122,-3],];      
         
encoderholes = [[35,95,-3],[55,95,-3],[75,95,-3],[95,95,-3],
                            /*[45,80,-3],[65,80,-3],[85,80,-3],[105,80,-3]*/];

module rounded_rect(x, y, z, radius) {
	echo("Draw Rounded Rectangle.");
	linear_extrude(height=z)
		minkowski() {
			square([x,y]);
			circle(r = radius);
		}
}

//rounded_rect(box[0],box[1],3,5);


translate([0,0,0]){
    color("Blue",1.0){
    translate(screenpos){ cube(screen);}
    }
    difference(){
    rounded_rect(box[0],box[1],3,3);
     
    translate([0,0,-12]){    
    translate(screenpos){ cube(screen);}    
    }
    
  
    translate(encoderpos){
          rotate(encoderrot){
    for (hole = encoderholes){    
        translate(hole){    
            #cylinder(20,3,3,false);
            cube([button[0],button[1],10],true);
        }
        }
    }
}
      
        
    translate(midipos){    
    for (hole = keyboardbuttonholes){    
        translate(hole)    
            cube([button[0],button[1],10]);
        }
    }
    translate(leftkeyspos){  
     for (hole = keyleftbuttonholes){    
        translate(hole)    
            cube([button[0],button[1],10]);
        }
    }
     translate(leftkeys2pos){  
         rotate(leftkeys2rot){
     for (hole = keyleftbuttonholes2){    
        translate(hole)    
            cube([button[0],button[1],10]);
        }
    }
}
    
      translate(rightkeyspos){     
      for (hole = keyrightbuttonholes){    
        translate(hole)    
            cube([button[0],button[1],10]);
        }
    } 
    }
}