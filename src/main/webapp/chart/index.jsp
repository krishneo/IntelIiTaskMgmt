<html>
<head>
<link rel="stylesheet" href="styles.css">
</head>
<div id="chartContainer">
  <script src="d3.v3.min.js"></script>
  <script src="dimple.v2.1.6.min.js"></script>
  <script type="text/javascript">
    var svg = dimple.newSvg("#chartContainer", 590, 400);
    d3.tsv("example_data.tsv", function (data) {
      var myChart = new dimple.chart(svg, data);
      myChart.setBounds(20, 20, 460, 360)
      myChart.addMeasureAxis("p", "Unit Sales");
      myChart.addSeries("Owner", dimple.plot.pie);
      myChart.addLegend(500, 20, 90, 300, "left");
      myChart.draw();
    });
  </script>
</div>
</html>