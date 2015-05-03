<html>
<head>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>Data Visualization</title>
<style type="text/css">
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
	font: 20px "Helvetica Neue", Helvetica, Arial, sans-serif;
	text-anchor: middle;
	text-shadow: 0 1px 0 #fff, 1px 0 0 #fff, -1px 0 0 #fff, 0 -1px 0 #fff;
}

.label,.node--root,.node--leaf {
	pointer-events: all;
}

}
body {
	background: #ffffff;
	margin: 0;
	padding: 0;
}

#content {
	width: 100%;
	margin: 0;
	padding: 0;
	border: 0;
}

a {
	color: #2b2bf6;
}

#header {
	margin: 0;
	padding: 0;
	border: 0;
	background: gray;
	text-align: center;
	padding: 5px;
}

#footer {
	background-color: black;
	color: white;
	clear: both;
	text-align: center;
	position: fixed;
	bottom: 0;
	width: 100%;
}

#container {
	/* Optional - You can set a  min-height : whatever px; for reserving some space*/
	height: 300px; /* Fix a height here */
	overflow: auto; /* Optionally you can also use overflow: scroll; */
	background: #DCDCDC;
}

h4 {
	color: #CD853F
}

#navright {
	line-height: 30px;
	width: 50px;
	float: right;
}
</style>


<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/json2.js"></script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/hinge.js"></script>
<script src="http://d3js.org/d3.v3.min.js"></script>
<script>
	function openWin(indicator) {
		if (indicator == 'AA') {
			var myWindow = window
					.open("", "MsgWindow",
							"scrollbars=yes, resizable=yes, top=500, left=500, width=400, height=400");
			myWindow.document
			.write("Accepted Answer \n    ");
			myWindow.document
					.write("Number of Votes : ${bean.acceptedOrgVote} \n");
			myWindow.document
					.write("User's Reputation : ${bean.acceptedOrgRep} \n");
			myWindow.document.write("${bean.acceptedanswer}");
			myWindow.document.body.style.background = "lightgrey";
		} else {
			<c:forEach items="${bean.answers}" var="item" varStatus="i">
			var num = "${i.index}";
			if (num == indicator) {
				var myWindow = window
						.open("", "MsgWindow",
								"scrollbars=yes, resizable=yes, top=500, left=500, width=400, height=400");
				myWindow.document
				.write("Answer : ${i.index +1} \n   ");
				myWindow.document
						.write("Number of Votes : ${bean.aOrgVotes[i.index]} \n");
				myWindow.document
						.write("User's Reputation : ${bean.aOrgRep[i.index]} \n");
				myWindow.document.write("${bean.answers[i.index]}");
				myWindow.document.body.style.background = "lightgrey";
			}
			</c:forEach>
		}

	}
</script>
</head>
<body>
	<form action="/Data_Visualization/getQuestions" method="post">

		<div id="header" align="center">
			<br />
			<h1 style="color: #FFFFFF">Visual Recommender</h1>
		</div>
		<div id="navright">
			<a href="/Data_Visualization/"> <img
				src="${pageContext.request.contextPath}/resources/home.png"
				width="40">
			</a>
		</div>
		<div id="content">
			<h2 align="center">Question:</h2>
			<div id="container">
				<h4 style="color: black;">${bean.question}</h4>
			</div>
		</div>
		<br />
		<h1 style="color: #CD853F" align="center">${msg}</h1>
		<div>
			<script>
				if ('${msg}' == 'Select any answer') {
					draw();
				}

				function draw() {
					var margin = 20, diameter = 550;

					var color = d3.scale.linear().domain([ -1, 5 ]).range(
							[ "hsl(152,80%,80%)", "hsl(228,30%,40%)" ])
							.interpolate(d3.interpolateHcl);

					var pack = d3.layout.pack().padding(2).size(
							[ diameter - margin, diameter - margin ]).value(
							function(d) {
								return d.size;
							});

					var svg = d3.select("body").append("svg").attr("width",
							diameter).attr("height", diameter).append("g")
							.attr(
									"transform",
									"translate(" + diameter / 2 + ","
											+ diameter / 2 + ")");

					var votes = [];
					<c:forEach items="${bean.aVotes}" var="item" varStatus="i">
					var id = "${bean.aOrgVotes[i.index]}";
					var size = "${item}";
					tmp = '{"name": ' + id + ',"size": ' + size + ',"url" : '
							+ "${i.index}" + '}';
					flag1 = true;
					votes.push(tmp);
					</c:forEach>

					var rep = [];

					<c:forEach items="${bean.aReputation}" var="item" varStatus="i">
					var id = "${bean.aOrgRep[i.index]}";
					var size = "${item}";
					tmp = '{"name": ' + id + ',"size": ' + size + ',"url" : '
							+ "${i.index}" + '}';
					flag2 = true;
					rep.push(tmp);
					</c:forEach>
					var ans = '';
					var accAns = [];
					<c:if test="${not empty bean.acceptedanswer}">
					tmp = '{"name": "Accepted Answer", "size": 500, "url": "AA"}';
					ans = "Accepted Answer";
					accAns.push(tmp);
					</c:if>
					
					<c:if test="${ bean.acceptedanswer == 'no'}">
					accAns = [];
					ans =' ';
					tmp = '{}';
					accAns.push(tmp);
					</c:if>

					var obj = '{"name": "vis","children": [{"name": "Votes","children": '
							+ '[ '
							+ votes
							+ '] },'
							+ '{"name": "Reputation","children": [ '
							+ rep
							+ ']},'
							+ '{"name": "'+ans+'","children": [{"name": "encoder","children": '
							+ '[' + accAns + ']}]}]}';

					var root = JSON.parse(obj);
					var focus = root, nodes = pack.nodes(root), view;

					var circle = svg.selectAll("circle").data(nodes).enter()
							.append("circle").attr(
									"class",
									function(d) {
										return d.parent ? d.children ? "node"
												: "node node--leaf"
												: "node node--root";
									}).style("fill", function(d) {
								return d.children ? color(d.depth) : null;
							}).on("click", clickFct);

					function clickFct(d, i) {
						if (d3.select(this).classed("node--leaf")) {
							if (d.url !== undefined) {

								var ind = d.url;
								openWin(ind);
							}
						} else {
							if (focus !== d) {
								zoom(d);
								d3.event.stopPropagation();
							}
						}
					}

					var text = svg.selectAll("text").data(nodes).enter()
							.append("text").attr("class", "label").style(
									"fill-opacity", function(d) {
										return d.parent === root ? 1 : 0;
									}).style("display", function(d) {
								return d.parent === root ? null : "none";
							}).text(function(d) {
								return d.name;
							});

					var node = svg.selectAll("circle,text");

					d3.select("body")
					// .style("background", color(-1))
					.on("click", function() {
						zoom(root);
					});

					zoomTo([ root.x, root.y, root.r * 2 + margin ]);

					function zoom(d) {
						focus = d;
						var transition = d3.transition().duration(
								d3.event.altKey ? 7500 : 750).tween(
								"zoom",
								function(d) {
									var i = d3.interpolateZoom(view, [ focus.x,
											focus.y, focus.r * 2 + margin ]);
									return function(t) {
										zoomTo(i(t));
									};
								});

						transition.selectAll("text").filter(
								function(d) {
									return d.parent === focus
											|| this.style.display === "inline";
								}).style("fill-opacity", function(d) {
							return d.parent === focus ? 1 : 0;
						}).each("start", function(d) {
							if (d.parent === focus)
								this.style.display = "inline";
						}).each("end", function(d) {
							if (d.parent !== focus)
								this.style.display = "none";
						});

					}

					function zoomTo(v) {
						var k = diameter / v[2];
						view = v;
						node.attr("transform", function(d) {
							return "translate(" + (d.x - v[0]) * k + ","
									+ (d.y - v[1]) * k + ")";
						});
						circle.attr("r", function(d) {
							return d.r * k;
						});
					}

					d3.select(self.frameElement).style("height",
							diameter + "px");
				}
			</script>
		</div>

		<div id="footer">-- Copy Right @ ASU --</div>
	</form>

</body>
</html>