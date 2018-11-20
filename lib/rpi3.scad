//
// raspberry pi model B+
//
// design by Egil Kvaleberg, 8 Aug 2015
// Rasoberrypi 3 adapt by Guy Sheffer 28 Apr 2016
//
// drawing of the B+ model, for referrence:
// https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/Raspberry-Pi-B-Plus-V1.2-Mechanical-Drawing.pdf
//
// notes:
// design origin is middle of PCB
//

/* [Hidden] */
mil2mm = 0.0254;
pcb = [85.0, 56.0, 1.5]; // main board
pcb2floor = 4.0; // 3.5
pcb2roof = 17.0; // 15.7

pcbmntdia = 2.75; // mounting holes
pcbmnt1dx = pcb[0]/2 - 3.5;  // 
pcbmnt1dy = 3.5 - pcb[1]/2;
pcbmnt2dx = pcb[0]/2 - 3.5 - 58.0; // 
pcbmnt2dy = pcb[1]/2 - 3.5;
pcbmnthead = 6.2; // countersunk
pcbmntthreads = 2.2;

cardsy = 12.0; // card measures 11.0
cardsz = 3.1;
cardsx = 8.0; // size of internal platform
carddy = pcb[1]/2 - 28.0;
ethersy = 16.0; // ethernet contact width
ethersz = 13.5 + 0.5;
etherdy = pcb[1]/2 - 10.25;
usbsy = 13.5; // core
usbframe = 1.0; // frame
usbsz = 15.8 + 0.5;
usb1dy = pcb[1]/2 - 29.0;
usb2dy = pcb[1]/2 - 47.0;
powerpsx = 11.0; // power plug width 
powerpsz = 4.5; // plug height
powerssx = 8.0; // power socket width 
powerssz = 3.3; // socket height
powerdz = -1.7; // for plug 
powerdx = pcb[0]/2 - 10.6; // 
hdmisx = 15.2; // hdmi contact width
hdmisz = 6.2;
hdmipsx = 25.0; // typical plug
hdmipsz = 12.0;
hdmidx = pcb[0]/2 - 32.0;
audior = 7.0; // audio contact radius
audiodz = 6.0/2; // above pcb
audiodx = pcb[0]/2 -53.5;
d = 0.01;

frame_w = pcb[2] -d; // width of lip for frame 

tol = 0.5; // general tolerance
wall = 1.2; // general wall thickness
breakaway = 0.3; // have hidden hole for screw, 0 for no extra pegs 

raspberryMount(true);
raspberryPlugs();
            

module raspberryMount(show = false){
    for (dx = [pcbmnt1dx,pcbmnt2dx]) for (dy = [pcbmnt1dy,pcbmnt2dy]) 
    pedestal(dx, dy , pcb2floor, pcbmntdia );
    if(show)
        translate([0,0,pcb2floor + pcb[2]*0.5])cube([2*tol+pcb[0], 2*tol+pcb[1], pcb[2]+d],true);
}

module raspberryPlugs(){
    translate([0,0,pcb2floor+pcb[2] ]) plugs(tol);
}
        
module c_cube(x, y, z) {
	translate([-x/2, -y/2, 0]) cube([x, y, z]);
}

module pedestal(dx, dy, hg, dia) {
    translate([dx, dy, 0]) {
				cylinder(r = dia/2+wall, h = hg, $fs=0.2);
                // pegs through pcb mount holes
                if (breakaway > 0) translate([0, 0, hg]) 
                        cylinder(r = dia/2 - tol, h = pcb[2]+d, $fs=0.2);
            }
        }
        

module plugs(extra) { 
        module usb_plug(dy) {
            translate([-pcb[0]/2, dy, -extra-frame_w]) 
				c_cube(19.9, usbsy+2*extra, usbsz+2*extra+frame_w);
            translate([-pcb[0]/2 -19.9/2, dy, -extra-frame_w]) 
				c_cube(19.9, usbsy+2*usbframe+2*extra, usbsz+2*extra+frame_w+2*usbframe/2);
        }
        // card slot
        translate([pcb[0]/2, carddy, -cardsz-extra - 1.2]) // fudge 
			c_cube(19.9, cardsy+2*extra, cardsz+2*extra);
        // power socket (near side)
        translate([powerdx, pcb[1]/2, -extra-frame_w]) 
			c_cube(powerssx+2*extra, 19.9, powerssz+2*extra+frame_w);
        // room for power plug
        translate([powerdx, pcb[1]/2+9.9/2+wall*1.4, -extra-frame_w]) 
			c_cube(powerpsx+2*extra, 9.9, powerpsz+2*extra+frame_w);
       // ether plug 
        translate([-pcb[0]/2, etherdy, -extra-frame_w]) 
			c_cube(19.9, ethersy+2*extra, ethersz+2*extra+frame_w); // use half tol horizontally, seems to be enough
       // usb plugs
       usb_plug(usb1dy);
       usb_plug(usb2dy);
        // hdmi socket (near side)
        translate([hdmidx, pcb[1]/2, -extra-frame_w]) 
			c_cube(hdmisx+2*extra, 19.9, hdmisz+2*extra+frame_w);
        translate([hdmidx, pcb[1]/2+19.9/2-7.8/2, -extra-frame_w]) 
			c_cube(hdmipsx+2*extra, 7.8, hdmipsz+2*extra+frame_w);
        // audio plug (near side)
        translate([audiodx, pcb[1]/2 + 19.9/2, audiodz]) 
			rotate([90, 0, 0]) cylinder(r=audior/2+extra, h=19.9, $fn=20);
        translate([audiodx, pcb[1]/2, -extra-frame_w]) 
			c_cube(audior+2*extra, 19.9, audiodz+2*extra+frame_w);

    }
