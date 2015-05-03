<html>
<head>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>Data Visualization</title>
<style type="text/css">
body {
	background: #ffffff;
	margin: 0;
	padding: 0;
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

#sidebar {
	width: 17%;
	position: relative;
	margin: 0;
	padding: 0;
	border: 0;
	float: left;
	background: #F5F5DC;
}

#content {
	width: 83%;
	margin: 0;
	padding: 0;
	border: 0;
	
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

h3 {
	color: #CD853F
}

#zebra {
	background: #f5f5f5;
	border-collapse: separate;
	box-shadow: inset 0 1px 0 #fff;
	font-size: 12px;
	line-height: 24px;
	margin: 30px auto;
	text-align: left;
	width: 800px;
}

th {
	background: url(http://jackrugile.com/images/misc/noise-diagonal.png),
		linear-gradient(#777, #444);
	border-left: 1px solid #555;
	border-right: 1px solid #777;
	border-top: 1px solid #555;
	border-bottom: 1px solid #333;
	box-shadow: inset 0 1px 0 #999;
	color: #fff;
	font-weight: bold;
	padding: 10px 15px;
	position: relative;
	text-shadow: 0 1px 0 #000;
}

th:after {
	background: linear-gradient(rgba(255, 255, 255, 0),
		rgba(255, 255, 255, .08));
	content: '';
	display: block;
	height: 25%;
	left: 0;
	margin: 1px 0 0 0;
	position: absolute;
	top: 25%;
	width: 100%;
}

th:first-child {
	border-left: 1px solid #777;
	box-shadow: inset 1px 1px 0 #999;
}

th:last-child {
	box-shadow: inset -1px 1px 0 #999;
}

td {
	border-right: 1px solid #fff;
	border-left: 1px solid #e8e8e8;
	border-top: 1px solid #fff;
	border-bottom: 1px solid #e8e8e8;
	padding: 10px 15px;
	position: relative;
	transition: all 300ms;
}

td:first-child {
	box-shadow: inset 1px 0 0 #fff;
}

td:last-child {
	border-right: 1px solid #e8e8e8;
	box-shadow: inset -1px 0 0 #fff;
}

tr {
	background: url(http://jackrugile.com/images/misc/noise-diagonal.png);
}

tr:nth-child(odd) td {
	background: #f1f1f1
		url(http://jackrugile.com/images/misc/noise-diagonal.png);
}

tr:last-of-type td {
	box-shadow: inset 0 -1px 0 #fff;
}

tr:last-of-type td:first-child {
	box-shadow: inset 1px -1px 0 #fff;
}

tr:last-of-type td:last-child {
	box-shadow: inset -1px -1px 0 #fff;
}

tbody:hover td {
	color: transparent;
	text-shadow: 0 0 3px #aaa;
}

tbody:hover tr:hover td {
	color: #444;
	text-shadow: 0 1px 0 #fff;
}

#chartdiv {
	background: #3f3f4f;
	color: #ffffff;
	width: 80%;
	height: 400px;
	font-size: 11px;
	float: right;
}
</style>
<script type="text/javascript"
	src="http://www.amcharts.com/lib/3/amcharts.js"></script>
<script type="text/javascript"
	src="http://www.amcharts.com/lib/3/serial.js"></script>
<script type="text/javascript"
	src="http://www.amcharts.com/lib/3/themes/dark.js"></script>
<script type="text/javascript"> 


	function barChart1(){
		var obj = [];
		//var elems = $("input[class=email]");
		var flag = false;
		var count =1;
		<c:forEach items="${bean.views}" var="item" varStatus="i">
		 var id = 'Q'+count;
		    var email = "${item}";
		    tmp = {
		        'country': id,
		        'visits': email
		    };
			flag= true;
		    obj.push(tmp); count++;
		</c:forEach>
		/* for (i = 0; i < arry.length; i += 1) {
		    var id = 'Q'+(i+1);
		    var email = arry[i];
		    tmp = {
		        'country': id,
		        'visits': email
		    };

		    obj.push(tmp);
		} */ 
		//alert(obj);  
		if(flag == true ){
		document.getElementById("chartdiv").style.display = '';
		var chart = AmCharts.makeChart( "chartdiv", {
			  "type": "serial",
			  "theme": "dark",
			  "dataProvider": obj,
			  "valueAxes": [ {
			    "gridColor": "#FFFFFF",
			    "gridAlpha": 0.2,
			    "dashLength": 0
			  } ],
			  "gridAboveGraphs": true,
			  "startDuration": 1,
			  "graphs": [ {
			    "balloonText": "[[category]]: <b>[[value]]</b>",
			    "fillAlphas": 0.8,
			    "lineAlpha": 0.2,
			    "type": "column",
			    "valueField": "visits"
			  } ],
			  "chartCursor": {
			    "categoryBalloonEnabled": false,
			    "cursorAlpha": 0,
			    "zoomable": false
			  },
			  "categoryField": "country",
			  "categoryAxis": {
			    "gridPosition": "start",
			    "gridAlpha": 0,
			    "tickPosition": "start",
			    "tickLength": 20
			  }

			} );
		}
	}
	function barChart2(){
		
		var obj = [];
		var count =1;
		var flag = false; 
		<c:forEach items="${bean.votes}" var="item" varStatus="i">
		 var id = 'Q'+count;
		    var email = "${item}";
		    tmp = {
		        'country': id,
		        'visits': email
		    };
		   // alert("${bean.votes[i.index]}");
		    flag =true;
		    obj.push(tmp); count++;
		</c:forEach>
		/* for (i = 0; i < arry.length; i += 1) {
		    var id = 'Q'+(i+1);
		    var email = arry[i];
		    tmp = {
		        'country': id,
		        'visits': email
		    };

		    obj.push(tmp);
		} */
	//	alert(obj);
		if(flag == true){
		document.getElementById("chartdiv").style.display = '';
		var chart = AmCharts.makeChart( "chartdiv", {
			  "type": "serial",
			  "theme": "dark",
			  "dataProvider": obj,
			  "valueAxes": [ {
			    "gridColor": "#FFFFFF",
			    "gridAlpha": 0.2,
			    "dashLength": 0
			  } ],
			  "gridAboveGraphs": true,
			  "startDuration": 1,
			  "graphs": [ {
			    "balloonText": "[[category]]: <b>[[value]]</b>",
			    "fillAlphas": 0.8,
			    "lineAlpha": 0.2,
			    "type": "column",
			    "valueField": "visits"
			  } ],
			  "chartCursor": {
			    "categoryBalloonEnabled": false,
			    "cursorAlpha": 0,
			    "zoomable": false
			  },
			  "categoryField": "country",
			  "categoryAxis": {
			    "gridPosition": "start",
			    "gridAlpha": 0,
			    "tickPosition": "start",
			    "tickLength": 20
			  }

			} );
		}
	}
	function submited() {
		document.getElementById('selMonth').value = document.getElementById('month').value;
		document.getElementById('voteInput').value = document.getElementById('voteN').value;
		if(document.getElementById('voteInput') == '' || document.getElementById('selMonth') == ''){
			return false;
		}
	}
	
	function Validate(s) {
		document.getElementById('qSelected').value = s;
		document.forms["myform"].submit();
		return true;
	}
	function hide() {
		document.getElementById("chartdiv").style.display = 'none';
		document.getElementById("content").style.display = 'none'; 
		var msg ='${msg}';
		
		if(msg =='No results found!'){
			document.getElementById("content").style.display = 'none';
		}else{
			document.getElementById("content").style.display = '';
		}
		document.getElementById('${bean.qtype}').checked = true;
		document.getElementById('month').value = '${bean.selMonth}'; 
		document.getElementById('voteN').value = '${bean.voteInput}';

	}
</script>
</head>
<body onload="return hide();" style="background-color: #DCDCDC"> 
	<form action="/Data_Visualization/getQuestions" method="post"
		name="form1">
		<div id="container"></div>
		<div id="header" align="center">
			<br />
		<marquee>	<h1 style="color: #FFFFFF">Stack Overflow (Java) Visual Recommender</h1> </marquee>
		</div>
		<div id="sidebar">
			<center>
				<h2 style="color: #556B2F">Filters:</h2>
			</center>
			<h3>Questions Type:</h3>
			<h4>
				<input type="radio" name="qtype" id="pragmatic" value="pragmatic"
					checked>Pragmatic <input type="radio" name="qtype"
					id="syntactic" value="syntactic">Syntactic <input
					type="radio" name="qtype" id="both" value="both">Both
			</h4>
			<h3>Time period:</h3>
			<table>
				<tr>
					<td>Month : <select id="month" name="month">
							<c:forEach items="${criteria.disMonths }" var="mon">
								<option value="${mon}">${mon}</option>
							</c:forEach>
					</select>
					</td>
				</tr>
				<tr>
					<td>Year : <select id="year" name="year">
							<option value="2014">2014</option>
					</select>
					</td>
				</tr>
			</table>
			<input type="hidden" name="selMonth" id="selMonth" /> <input
				type="hidden" name="voteInput" id="voteInput" />

			<table>
				<tr>
					<td><h3>Views</h3></td>
					<td><select id="voteN" name="voteN">
							<option value="0">All</option>
							<option value="1">0-100</option>
							<option value="2">100-500</option>
							<option value="3">500-1000</option>
							<option value="4">Above 1000</option>
					</select></td>
				</tr>

			</table>
			<input type="hidden" name="vSelected" id="vSelected">
			<table>
				<tr>
					<td><input type="submit" value="Search" onclick="submited();"
						style="width: 150px"></td>
				</tr>
				</table>
				<table>
				<tr>
					<td><input type="button" value="GetViews"
						onclick="return barChart1();"></td>
						<td><input type="button" value="GetVotes"
						onclick="return barChart2();"></td>
				</tr>
			</table>			
		</div>
	</form>
	
			<h2 align="center" style="color: #CD853F">${msg}</h2>
			<div id="chartdiv"></div> 
	<form method="post" name="myform"
		action="/Data_Visualization/getAnswers">
		<div id="content">		
			<table border="1"
				style="overflow-y: scroll; height: 50%; float: right;" class="zebra">
				<thead>
					<tr>
						<th>${number }</th>
						<th>${titles }</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${bean.titles }" var="title" varStatus="i">
						<tr>
							<td>${i.index+1 }</td>
							<td><a href="#" onclick="return Validate('${i.index}');">
									${title } </a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<input type="hidden" name="qSelected" id="qSelected">

		</div>

		<div id="footer">-- Copy Right @ ASU --</div>
	</form>
</body>
</html>