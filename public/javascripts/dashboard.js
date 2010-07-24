// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


google.load('visualization', '1', {'packages':['barchart']});

function rand(max) {
	return Math.floor((max+1)*Math.random())
}

google.setOnLoadCallback(function() {
	// Create and populate the data table.
	var data = new google.visualization.DataTable();
	var raw_data = [[65, 35, 34],
	               [65, 35, 34],
	               [65, 35, 34]
		];

	var clerkships = [
		'Internal Medicine',
		'Pediatrics', 
		'Surgery', 
		'Ob/Gyn', 
		'Emergency Medicine', 
		'Psychiatry', 
		'Family Medicine'];

	data.addColumn('string', 'Clerkships');
	data.addColumn('number', 'Acute');
	data.addColumn('number', 'Chronic');
	data.addColumn('number', 'Ethical');
	
	data.addRows(clerkships.length);
	for(var i = 0; i < clerkships.length; ++i) {
		data.setValue(i,0, clerkships[i]);
	}
	
	for(var i = 0; i < clerkships.length; ++i) {
		for (var j = 1; j < 4; ++j) {
			data.setValue(i,j, rand(100));
		};
	};


	// Create and draw the visualization.
	var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
	chart.draw(data,
	        {title:"Progress Report",
	          width:800, height:400, is3D: false}          
	    );
	
	google.visualization.events.addListener(chart, 'select', function(e) {
		var msg = 'howdy!';
		return msg;
	});

});
