<!DOCTYPE html>
<meta charset="utf-8">
<style>

.node {

  cursor: pointer;
  
}

.node:hover {
  stroke: #000;
  stroke-width: 2px;
}

.node--leaf {
  fill: white;
}
.node--leaf:hover {
fill: #CCFFFF;
}

.label {
  font: 11px "Helvetica Neue", Helvetica, Arial, sans-serif;
  text-anchor: middle;
  text-shadow: 0 1px 0 #fff, 1px 0 0 #fff, -1px 0 0 #fff, 0 -1px 0 #fff;
}

.label,
.node--root,
.node--leaf {
  pointer-events: all;
}

}
</style>
<body>
<script src="http://d3js.org/d3.v3.min.js"></script>
<!--  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/d3.v3.min.js"></script>  -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/hinge.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/json2.js"></script>
<script>
  
var margin = 20,
    diameter = 500;

var color = d3.scale.linear()
    .domain([-1, 5])
    .range(["hsl(152,80%,80%)", "hsl(228,30%,40%)"])
    .interpolate(d3.interpolateHcl);

var pack = d3.layout.pack()
    .padding(2)
    .size([diameter - margin, diameter - margin])
    .value(function(d) { return d.size; });

var svg = d3.select("body").append("svg")
    .attr("width", diameter)
    .attr("height", diameter)
  .append("g")
    .attr("transform", "translate(" + diameter / 2 + "," + diameter / 2 + ")");
var obj = '{"name": "vis","children": [{"name": "Votes","children": '+
	'[ {"name": "200", "size": 2000,"url":"1"}, {"name": "500", "size": 500,"url":"2"},{"name": "300", "size": 300,"url":"3"}, '+
	   '{"name": "400", "size": 400,"url":"4"}] },'+
	   '{"name": "Reputation","children": [ {"name": "200", "size": 200},{"name": "500", "size": 500},{"name": "300", "size": 300},'+
	   '{"name": "400", "size": 400}]},'+
	   '{"name": "Accepted Answer","children": [{"name": "encoder","children": [ {"name": "Accepted Answer", "size": 500}]}]}]}';

  alert('cmg');
 var root = JSON.parse(obj);
 alert('root: ' + root);
  var focus = root,
      nodes = pack.nodes(root),
      view;
  
alert(nodes);
  var circle = svg.selectAll("circle")
      .data(nodes)
    .enter().append("circle")
      .attr("class", function(d) { return d.parent ? d.children ? "node" : "node node--leaf" : "node node--root"; })
      .style("fill", function(d) { return d.children ? color(d.depth) : null; })
      .on("click", clickFct);
	  
	  function clickFct(d,i) {
    if (d3.select(this).classed("node--leaf")) {
         if(d.url !== undefined)
        {
			//document.getElementById("content").innerHTML='<object type="type/html" data="main.html" ></object>';
//window.open(d.url, windowName, "height=200,width=200");
window.open(d.url);
			//alert(d.url);
        }
    } else {
        if (focus !== d) 
        {
            zoom(d); 
            d3.event.stopPropagation();
        }
    }
  }

  var text = svg.selectAll("text")
      .data(nodes)
    .enter().append("text")
      .attr("class", "label")
      .style("fill-opacity", function(d) { return d.parent === root ? 1 : 0; })
      .style("display", function(d) { return d.parent === root ? null : "none"; })
      .text(function(d) { return d.name; });

  var node = svg.selectAll("circle,text");

  d3.select("body")
     // .style("background", color(-1))
      .on("click", function() { zoom(root); });

  zoomTo([root.x, root.y, root.r * 2 + margin]);

  function zoom(d) {  
    var focus0 = focus; focus = d;
    var transition = d3.transition()
        .duration(d3.event.altKey ? 7500 : 750)
        .tween("zoom", function(d) {
          var i = d3.interpolateZoom(view, [focus.x, focus.y, focus.r * 2 + margin]);
          return function(t) { zoomTo(i(t)); };
        });

    transition.selectAll("text")
      .filter(function(d) { return d.parent === focus || this.style.display === "inline"; })
        .style("fill-opacity", function(d) { return d.parent === focus ? 1 : 0; })
        .each("start", function(d) { if (d.parent === focus) this.style.display = "inline"; })
        .each("end", function(d) { if (d.parent !== focus) this.style.display = "none"; });
  
  }

  function zoomTo(v) {
    var k = diameter / v[2]; view = v;
    node.attr("transform", function(d) { return "translate(" + (d.x - v[0]) * k + "," + (d.y - v[1]) * k + ")"; });
    circle.attr("r", function(d) { return d.r * k; });
  }
//});


d3.select(self.frameElement).style("height", diameter + "px");

</script>
</body>