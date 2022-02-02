$fn = 200;

length = 155;
width = 84.5+10;
materialThickness = 3;

standoffHeight = 3;
ssdHeight = 14 + standoffHeight;

screwHoleDia = 3.5;
screwXDistance = 76.6;
screwYDistance = 61.71;
screwZDistance = 3;

x1 = (length-screwXDistance)/2;
x2 = x1+screwXDistance;
y1 = 5+7.5;
y2 = y1+screwYDistance;

slitWidth = 60;
slitOffset = ((screwYDistance-slitWidth)/2)+y1;

module bracket() {
	thickness = 3.5;
	slitWidth = 1.5;
	slitHeigtht = 7;
	bracketHeight = 10;
	plateThickness = 4;
	
	union() {
		translate([0,0,ssdHeight+materialThickness+plateThickness])
			difference() {
				cube([thickness, width, bracketHeight]);			
				cube([slitWidth, width, slitHeigtht]);
			}
			
		translate([-materialThickness, 0, 0]) 
			cube([materialThickness, width, ssdHeight+bracketHeight+materialThickness+plateThickness]);
	}
}

/*
module side() {
	difference() {	
		translate([0, -materialThickness, 0]) 
			cube([length, materialThickness, 7 + materialThickness]);
		
		translate([(155-screwXDistance)/2, 0, screwZDistance+materialThickness])
			rotate(a=[90,0,0])
				cylinder(d=screwHoleDia, h=2*materialThickness, center = true);
		
		translate([((155-screwXDistance)/2)+screwXDistance, 0, screwZDistance+materialThickness])
			rotate(a=[90,0,0])
				cylinder(d=screwHoleDia, h=2*materialThickness, center = true);
	}
}
*/

module holder() {	
	holderWidth = 6.5;
	holderLength = 9;
	holderHeight = ssdHeight-0.8;
	
	holeDia = 4;
	holeDepth = 5;
	holeYDist = 7.7-(holeDia/2);
	
	difference() {	
		translate([0, width-(holderLength/2), (holderHeight/2)+materialThickness])
			cube([holderWidth, holderLength, holderHeight], center = true);
		
		translate([0, width-holeYDist, holderHeight+materialThickness-(holeDepth/2)])
			cylinder(d=holeDia, h = holeDepth, center = true);
	}
}

module stabilizer() {
	holderWidth = 6.5;
	holderLength = 9;
	holderHeight = ssdHeight-0.8;
	
	translate([0, 10, (holderHeight/2)+materialThickness])
		cube([holderWidth, holderLength, holderHeight], center = true);
}

module base() {
	difference() {
		union() {
			cube([length, width, materialThickness]);
			translate([x1, y1, 0])  standoff();
			translate([x2, y1, 0])  standoff();
			translate([x1, y2, 0])  standoff();
			translate([x2, y2, 0])  standoff();
		}
		
		translate([x1, y1, -materialThickness])
			cylinder(d=screwHoleDia, h=10*materialThickness);
		
		translate([x2, y1, -materialThickness])
			cylinder(d=screwHoleDia, h=10*materialThickness);
		
		translate([x1, y2, -materialThickness])
			cylinder(d=screwHoleDia, h=10*materialThickness);
		
		translate([x2, y2, -materialThickness])
			cylinder(d=screwHoleDia, h=10*materialThickness);
		
		translate([x1, y1, 0]) screwCutout();
		translate([x1, y2, 0]) screwCutout();
		translate([x2, y1, 0]) screwCutout();
		translate([x2, y2, 0]) screwCutout();
	}
}

module standoff() {
	standoffWidth = 10;
	standoffLength = 15;
	
	difference() {
		translate([0, 0, (standoffHeight/2)+materialThickness])
			cube([standoffWidth, standoffLength, standoffHeight], center = true);
		
		translate([0, -10, (standoffHeight/2)+materialThickness])
			rotate(a=[30, 0, 0])
				cube([15,20,5], center = true);
		
			rotate([0,0,180]) 
				translate([0, -10, (standoffHeight/2)+materialThickness])
					rotate(a=[30, 0, 0])
						cube([15,20,5], center = true);
	}
}

module screwCutout() {
	cutoutDia = 8;
	cutoutHeight = materialThickness+1;
	
	translate([0, 0, cutoutHeight/2])
		cylinder(d=cutoutDia, h=cutoutHeight, center = true);
}

union() {
	base();
	
	translate([4+2,0,0])
		holder();
	
	translate([length-(4+2),0,0])
		holder();
	
	bracket();
	
	translate([4+2,0,0])
		stabilizer();
	
	difference() {
		translate([length,width,0])
			rotate(a=[0,0,180])
				bracket();
		
		translate([length-materialThickness, slitOffset, materialThickness])
			cube([10,slitWidth,10]);
		
		translate([length-materialThickness, slitOffset, materialThickness+5])
			rotate(a=[0, 90, 0])
				cylinder(d=10, h=10);
		
		translate([length-materialThickness, slitOffset-2+screwYDistance, materialThickness+5])
			rotate(a=[0, 90, 0])
				cylinder(d=10, h=10);
	}
}