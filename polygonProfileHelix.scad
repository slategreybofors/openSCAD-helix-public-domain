module polygonProfileHelix(rate = 1, sectionPolygon = [[0, 0, 0]], length = 1){ //Needs logic for removing duplicate points and reorganizing duplicate or intersecting faces
	degreesPerSegment = $fa;
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
	
	polyhedron(points = points, faces = triangles);
}

sectionPolygon = [[0.5, 0], [11.25/2 - 0.5, 0], [11.25/2, 0.5], [11.25/2 - 0.5, 1], [0.5, 1]];

polygonProfileHelix(rate=2, sectionPolygon = sectionPolygon, length = 25);