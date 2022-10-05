module polygonProfileHelix(rate = 1, sectionPolygon = [[0, 0, 0]], sectionPointCount = 0, length = 1, degreesPerSegment = 0.5){ //*screams internally*
	thatj = 360/degreesPerSegment;
	numberOfSegments = thatj*length/rate;
	numberOfPoints = numberOfSegments * sectionPointCount;
	points = [//[0, 0, 0],
	for(rp = [0:1:numberOfSegments + 1])
	for(point2D = sectionPolygon)
	[sin(rp * degreesPerSegment) * point2D[0], cos(rp * degreesPerSegment) * point2D[0], (rp*rate/thatj) + (point2D[1])],
	];
	
	triangles = [
	for(e = [1:1:sectionPointCount - 1])
	[e, 0, e - 1],
	[1, sectionPointCount, 0],
	[sectionPointCount - 1, sectionPointCount, 0],
	for(p = [1:1:numberOfPoints - sectionPointCount - 1])
	for(t = [
		[p + sectionPointCount - 1, p + sectionPointCount, p],
		[p + sectionPointCount, p + 1, p],
	])
	t,
	for(e = [numberOfPoints - sectionPointCount:1:numberOfPoints - 1])
	[e, e - 1, numberOfPoints - 1],
	];
	
	polyhedron(points = points, faces = triangles);
}

sectionPolygon = [[5/2, -.125], [15/2 - 1, 0], [15/2, 1], [15/2 - 1, 2], [5/2, 2.125]];

difference(){
	intersection(){
		polygonProfileHelix(rate=2, sectionPolygon = sectionPolygon, sectionPointCount = 5, length = 25 - 2, degreesPerSegment = 15);
		
//		translate([0, 0, 35/2])
//		cube([25, 11.3, 35], center=true);
	}
	
	//cylinder(d = 9.3, h = 35, $fn=6);
}