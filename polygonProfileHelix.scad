module polygonProfileHelix(rate = 1, sectionPolygon = [[0, 0, 0]], length = 1, degreesPerSegment = 0.5){ //Needs logic for removing duplicate points and reorganizing duplicate or intersecting faces
	segmentsPerTurn = 360/degreesPerSegment;
	numberOfSegments = segmentsPerTurn*length/rate;
	numberOfPoints = numberOfSegments * len(sectionPolygon);
	points = [
	for(rp = [0:1:numberOfSegments + 1])
	for(point2D = sectionPolygon)
	[sin(rp * degreesPerSegment) * point2D[0], cos(rp * degreesPerSegment) * point2D[0], (rp*rate/segmentsPerTurn) + (point2D[1])],
	];
	
	triangles = [
	for(e = [1:1:len(sectionPolygon) - 1])
	[e, 0, e - 1],
	for(p = [0:1:numberOfPoints - len(sectionPolygon) - 1])
	each([
		[p + len(sectionPolygon), p + 1, p],
		[p + len(sectionPolygon) - 1, p + len(sectionPolygon), p],
	]),
	for(e = [numberOfPoints - len(sectionPolygon) + 1:1:numberOfPoints - 1])
	[e, e - 1, numberOfPoints - 1],
	];
	
	for(t = [0:1:len(triangles) - 1])
	for(p = [0, 1, 2])
	for(q = [triangles[t][p] - 1:-1:0])
	if((points[q] == points[triangles[t][p]]) && (q != p))
	echo(triangles[t][p], q, points[q]);
	
	polyhedron(points = points, faces = triangles);
}

sectionPolygon = [[1, 0], [15/2 - 0.5, 0], [15/2, 0.5], [15/2 - 0.5, 1], [1, 1]];

difference(){
	intersection(){
		polygonProfileHelix(rate=1, sectionPolygon = sectionPolygon, length = 3, degreesPerSegment = 5);
		
		translate([0, 0, 5/2])
		cube([25, 11.3, 5], center=true);
	}
	
 //cylinder(d = 9.3, h = 35, $fn=6);
}