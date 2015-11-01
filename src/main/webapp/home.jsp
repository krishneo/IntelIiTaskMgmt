<jsp:include page="tpl/header.jsp"></jsp:include>
<jsp:include page="tpl/left.jsp"></jsp:include>

<script src="chart/fusioncharts.js" type="text/javascript"></script>
<script src="chart/fusioncharts.charts.js" type="text/javascript"></script>
<script src="chart/fusioncharts.widgets.js" type="text/javascript"></script>
<style type="text/css" >
.userViewGrid, .managerViewGrid {
	display: none;
}

</style>

<section id="main" class="column">

	<h4 class="alert_info">
		Welcome to Intelli Task Management System <span
			style="float: right; font-weight: bold;"><input
			id="reshuffleTasks" value="Resuffle Tasks" type="button"
			class="assign_btn" /> &nbsp;&nbsp; </span>
	</h4>
	
	<article class="module width_full userViewGrid" >
		<header>
			<h3 class="tabs_involved">My Tasks</h3> 
		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">

				<table class="tablesorter" cellspacing="0">
					<thead id="user_mytasks_thead">
						<tr>
							<th>Task Key</th>
							<th>Created Date</th>
							<th>Priority</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody id="user_mytasks_tbody">
						<tr></tr>
						<tr></tr>
						<tr></tr>
						<tr></tr>

					</tbody>
				</table>
			</div>
			<!-- end of #tab1 -->

		</div> 

	</article>

	<article class="module width_full managerViewGrid">
		<header>
			<h3 class="tabs_involved">My Users &amp; Groups Snapshot</h3>
		</header>

		<div class="module_content">

			<fieldset style="width: 48%; float: left; margin-right: 3%;">
				<!-- to make two field float next to one another, adjust values accordingly -->
				<label>Unassigned Task in Groups</label>
				<div>
					<br /> <br />
				</div>
				<div id="unassiged_task_chart"
					style="padding: 10px; text-align: center;">Loading data..</div>

			</fieldset>
			<fieldset style="width: 48%; float: left;">
				<!-- to make two field float next to one another, adjust values accordingly -->
				<label>Users Task Load</label>
				<div>
					<br /> <br />
				</div>
				<div id="managed_user_status_chart"
					style="padding: 10px; text-align: center;">Loading data..</div>
			</fieldset>
			<div class="clear"></div>
		</div>

	</article>

	<article class="module width_full managerViewGrid">
		<header>
			<h3 class="tabs_involved">Time Lapsed Tasks</h3>
			<span style="float: right; padding: 10px; font-weight: bold;">Group
				Name &nbsp;&nbsp;&nbsp; <select name="goupName"
				id="timeLapseSelectorId" class="managerHandledGroups"></select>
			</span>
		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">

				<table class="tablesorter" cellspacing="0">
					<thead id="user_list_thead">
						<tr>
							<th>Task Key</th>
							<th>Created Date</th>
							<th>Priority</th>
							<th>Time Lapse From SLA</th>
						</tr>
					</thead>
					<tbody id="user_list_tbody">
						<tr></tr>
						<tr></tr>
						<tr></tr>
						<tr></tr>

					</tbody>
				</table>
			</div>
			<!-- end of #tab1 -->

		</div>
		<!-- end of .tab_container -->

		<footer>
			<div class="pagination_links">
				<!-- <input type="submit"  class="alt_btn" value="&nbsp;&nbsp;&nbsp;First&nbsp;&nbsp;&nbsp;">  -->
				<input type="submit" class="alt_btn" id="prev_pages_no"
					value="Previous"> <input type="text" class="alt_btn"
					value="" id="pages_no" disabled="disabled"> <input
					type="submit" class="alt_btn" id="next_pages_no"
					value="&nbsp;&nbsp;&nbsp;Next&nbsp;&nbsp;&nbsp;">
				<!--  <input type="submit"  class="alt_btn" value="&nbsp;&nbsp;&nbsp;Last&nbsp;&nbsp;&nbsp;">  -->

			</div>
		</footer>

	</article>

	<article class="module width_full managerViewGrid" >
		<header>
			<h3 class="tabs_involved">Misc Details</h3>
			<span style="float: right; padding: 10px; font-weight: bold;">Group
				Name &nbsp;&nbsp;&nbsp; <select name="goupName"
				id="groupMiscDetailsSelectorId" class="managerHandledGroups"></select>
			</span>
		</header>

		<div class="module_content">

			<fieldset style="width: 48%; float: left; margin-right: 3%;">
				<!-- to make two field float next to one another, adjust values accordingly -->
				<label>Tasks by Group</label>
				<div>
					<br /> <br />
				</div>
				<div id="group_splitup_task_chart"
					style="padding: 10px; text-align: center;">Loading data..</div>

			</fieldset>
			<fieldset style="width: 48%; float: left;">
				<!-- to make two field float next to one another, adjust values accordingly -->
				<label>Average User Satisfaction</label>
				<div>
					<br /> <br />
				</div>
				<div id="user_satisfaction_chart"
					style="padding: 10px; text-align: center;">Loading data..</div>
			</fieldset>
			<div class="clear"></div>
		</div>

	</article>

	<div class="spacer"></div>
</section>

<script>
	if (customerOid == null || customerOid == 'undefined')
		window.href = "index.jsp";

	var cur_page_no = 1;
	var cur_cust_oid = customerOid;
	var managing_groups = [];

	var basicChartLoaded = false;

	function drawUnassignedTasksChart(chartData) {

		var _chartData = [];

		for ( var itr in chartData) {

			var _data = new Object();
			_data.label = chartData[itr].key1;
			_data.value = chartData[itr].value1;

			_chartData.push(_data);
		}

		FusionCharts.ready(function() {
			var salesChart = new FusionCharts({
				type : 'area2d',
				renderAt : 'unassiged_task_chart',
				width : '400',
				height : '300',
				dataFormat : 'json',
				dataSource : {
					"chart" : {
						"xAxisName" : "Groups Managed",
						"yAxisName" : "Unassigned Tasks"
					},
					"data" : _chartData
				}
			}).render();
		});

	}

	function drawGroupTaskSplitups(chartData) {

		FusionCharts
				.ready(function() {
					var revenueChart = new FusionCharts(
							{
								type : 'doughnut2d',
								renderAt : 'group_splitup_task_chart',
								width : '400',
								height : '300',
								dataFormat : 'json',
								dataSource : {
									"chart" : {
										"paletteColors" : "#0075c2,#1aaf5d,#f2c500,#f45b00,#8e0000",
										"use3DLighting" : "0",
										"showShadow" : "0",
										"enableSmartLabels" : "1",
										"startingAngle" : "310",
										"showLabels" : "0",
										"showPercentValues" : "1",
										"showLegend" : "1",
										"legendShadow" : "0",
										"legendBorderAlpha" : "0",
										"centerLabel" : "$label Count: $value",
										"captionFontSize" : "14",
										"subcaptionFontSize" : "14",
										"subcaptionFontBold" : "0"
									},
									"data" : chartData
								}
							}).render();
				});

	}

	function drawManagedUserStatusChart(datasets, categories) {

		FusionCharts.ready(function() {
			var analysisChart = new FusionCharts({
				type : 'stackedColumn3DLine',
				renderAt : 'managed_user_status_chart',
				width : '400',
				height : '300',
				dataFormat : 'json',
				dataSource : {
					"chart" : {
						"showvalues" : "0",
						"xaxisname" : "Users managed",
						"yaxisname" : "Tasks Splitup",
						"captionFontSize" : "14",
						"subcaptionFontSize" : "14",
						"subcaptionFontBold" : "0",
						"divlineColor" : "#999999",
						"divLineIsDashed" : "1",
						"divLineDashLen" : "1",
						"divLineGapLen" : "1",
						"toolTipColor" : "#ffffff",
						"toolTipBorderThickness" : "0",
						"toolTipBgColor" : "#000000",
						"toolTipBgAlpha" : "80",
						"toolTipBorderRadius" : "2",
						"toolTipPadding" : "5",
						"legendBgColor" : "#ffffff",
						"legendBorderAlpha" : '0',
						"legendShadow" : '0',
						"legendItemFontSize" : '10',
						"legendItemFontColor" : '#666666'
					},
					"dataset" : datasets,
					"categories" : categories
				}
			}).render();
		});

	}

	function drawUserSatisfaction(max_data, user_value, color_data) {

		FusionCharts.ready(function() {
			var cSatScoreChart = new FusionCharts({
				type : 'angulargauge',
				renderAt : 'user_satisfaction_chart',
				width : '400',
				height : '300',
				dataFormat : 'json',
				dataSource : {
					"chart" : {
						"caption" : "Workers Load Gauage",
						"subcaption" : "Last week",
						"lowerLimit" : "0",
						"upperLimit" : max_data,
						"lowerLimitDisplay" : "Good",
						"upperLimitDisplay" : "Bad",
						"showValue" : "1",
						"valueBelowPivot" : "1"
					},
					"colorRange" : {
						"color" : color_data
					},
					"dials" : {
						"dial" : [ {
							"value" : user_value
						} ]
					}
				}
			}).render();
		});

	}

	function loadUnassignedTasksChart(in_user_id) {

		$.ajax({
			type : "GET",
			url : "api/task/unassigned/" + in_user_id,
			datatype : "json",
			contentType : "application/json; charset=utf-8",
			success : function(msg) {
				drawUnassignedTasksChart(msg);
				loadUserStatusUnderManagerChart(cur_cust_oid);
			},
			error : function(xhr, textStatus, error) {
				setErrorMessage(xhr.statusText + " - " + textStatus + " - "
						+ error);
				loadUserStatusUnderManagerChart(cur_cust_oid);
			}
		});

	}

	function loadGroupTaskSplitups(in_user_id, group_name) {

		$.ajax({
			type : "GET",
			url : "api/chart/groups/" + in_user_id + "?group_name="
					+ group_name,
			datatype : "json",
			contentType : "application/json; charset=utf-8",
			success : function(msg) {
				drawGroupTaskSplitups(msg);
				loadUserSatisfaction(in_user_id, group_name);
			},
			error : function(xhr, textStatus, error) {
				setErrorMessage(xhr.statusText + " - " + textStatus + " - "
						+ error);
				loadUserSatisfaction(in_user_id, group_name);
			}
		});

	}

	function loadUserSatisfaction(in_user_id, group_name) {

		$.ajax({
			type : "GET",
			url : "api/chart/user/statisfaction/" + in_user_id + "?group_name="
					+ group_name,
			datatype : "json",
			contentType : "application/json; charset=utf-8",
			success : function(msg) {
				if (msg) {
					var dataset = msg.data;
					var max_value = msg.max_value;
					var marked_value = msg.marked_value;
					drawUserSatisfaction(max_value, marked_value, dataset);
				}
			},
			error : function(xhr, textStatus, error) {
				setErrorMessage(xhr.statusText + " - " + textStatus + " - "
						+ error);
			}
		});

	}

	function loadUserStatusUnderManagerChart(in_user_id) {

		$.ajax({
			type : "GET",
			url : "api/chart/users/" + in_user_id,
			datatype : "json",
			contentType : "application/json; charset=utf-8",
			success : function(msg) {
				if (msg) {
					var dataset = msg.dataset;
					var categories = msg.categories;
					drawManagedUserStatusChart(dataset, categories);
					basicChartLoaded = true;
				}
			},
			error : function(xhr, textStatus, error) {
				setErrorMessage(xhr.statusText + " - " + textStatus + " - "
						+ error);
			}
		});

	}

	function fillSlaExpiredData(slaData) {

		var rec_count = 0;

		var finalHead = "<tr><th>Task Key</th><th>Created Date</th><th>Priority</th><th>Time Lapse From SLA</th></tr>";
		$("#user_list_thead").html(finalHead);
		var finalHtml = "";
		for ( var itr in slaData) {

			var row_id = "ver_row_" + rec_count;
			var taskKeyLink = "<a href='viewTask.jsp?task_key="
					+ slaData[itr].task_key + "' target='_blank' >"
					+ slaData[itr].task_key + "</a>";

			var d = new Date(slaData[itr].created_timestamp);

			var dformat = [ d.getMonth() + 1, d.getDate(), d.getFullYear() ]
					.join('/')
					+ ' '
					+ [ d.getHours(), d.getMinutes(), d.getSeconds() ]
							.join(':');

			finalHtml += "<tr><td>" + taskKeyLink + "</td><td>"
					+ dformat + "</td><td>" + slaData[itr].priority
					+ "</td><td>" + slaData[itr].time_lapse_to_sla
					+ "</td></tr>";
			rec_count++;
		}
		$("#user_list_tbody").html(finalHtml);

		//if (cur_page_no > 1 && rec_count == 0)
		//	getAllUserRecords(1);

	}
	
	function fillMyTasksGrid(slaData) {

		var rec_count = 0;

		var finalHead = "<tr><th>Task Key</th><th>Created Date</th><th>Priority</th><th>Status</th></tr>";
		$("#user_mytasks_thead").html(finalHead);
		var finalHtml = "";
		for ( var itr in slaData) {

			var row_id = "ver_row_" + rec_count;
			var taskKeyLink = "<a href='viewTask.jsp?task_key="
					+ slaData[itr].task_key + "' target='_blank' >"
					+ slaData[itr].task_key + "</a>";

			var d = new Date(slaData[itr].created_timestamp);

			var dformat = [ d.getMonth() + 1, d.getDate(), d.getFullYear() ]
					.join('/')
					+ ' '
					+ [ d.getHours(), d.getMinutes(), d.getSeconds() ]
							.join(':');

			finalHtml += "<tr><td>" + taskKeyLink + "</td><td>"
					+ dformat + "</td><td>" + slaData[itr].priority
					+ "</td><td>" + slaData[itr].status
					+ "</td></tr>";
			rec_count++;
		}
		$("#user_mytasks_tbody").html(finalHtml);

		//if (cur_page_no > 1 && rec_count == 0)
		//	getAllUserRecords(1);

	}


	function getSlaExpired(in_group_id, page_no) {
		cur_page_no = page_no;

		$.ajax({
			type : "GET",
			url : "api/group/slaexpire/" + in_group_id + "?page_no=" + page_no,
			datatype : "json",
			contentType : "application/json; charset=utf-8",
			success : function(msg) {
				// setSuccessMessage("Data Saved: " + msg);
				$("#pages_no").val(page_no);
				fillSlaExpiredData(msg);
				if (!basicChartLoaded)
					loadUnassignedTasksChart(cur_cust_oid);
			},
			error : function(xhr, textStatus, error) {
				setErrorMessage(xhr.statusText + " - " + textStatus + " - "
						+ error);
				if (!basicChartLoaded)
					loadUnassignedTasksChart(cur_cust_oid);
			}
		});
	}

	function reshuffleTasks() {
		$.ajax({
			type : "GET",
			url : "api/rest/task/assign/invoke/ALL",
			datatype : "json",
			contentType : "application/json; charset=utf-8",
			success : function(msg) {
				alert("Request Sent");
				loadUnassignedTasksChart(cur_cust_oid);
			},
			error : function(xhr, textStatus, error) {
				setErrorMessage(xhr.statusText + " - " + textStatus + " - "
						+ error);
			}
		});
	}

	function getUserRecords(in_group_id, page_no) {

		//cur_page_no = page_no;
		alert("still called");

	}

	function getCustomerObj(in_cust_oid) {
		$.ajax({
			type : "GET",
			url : "api/user/" + in_cust_oid,
			datatype : "json",
			contentType : "application/json; charset=utf-8",
			success : function(msg) {
				cur_cust_oid = msg.loginId;

				var group_first = "";

				if (msg.managingGroups) {
					managing_groups = msg.managingGroups.split(",");
					for ( var groups in managing_groups) {
						if (groups == 0) {
							$('.managerHandledGroups').append(
									'<option selected="selected" value="' + managing_groups[groups] + '">'
											+ managing_groups[groups]
											+ '</option>');
							group_first = managing_groups[groups];
						} else
							$('.managerHandledGroups').append(
									'<option selected value="' + managing_groups[groups] + '">'
											+ managing_groups[groups]
											+ '</option>');
					}
				}

				$('.managerHandledGroups').val(group_first);

				getSlaExpired(group_first, 1);
				loadGroupTaskSplitups(cur_cust_oid, group_first);

			},
			error : function(xhr, textStatus, error) {
				setErrorMessage(xhr.statusText + " - " + textStatus + " - "
						+ error);
			}
		});
	}
	
	function getRepUserObj (in_cust_oid) {		

		page_no = 1;
		
		$.ajax({
			type : "GET",
			url : "api/task/mytask/" + in_cust_oid,
			datatype : "json",
			contentType : "application/json; charset=utf-8",
			success : function(msg) {
				$("#pages_no").val(page_no);
				fillMyTasksGrid(msg);
			},
			error : function(xhr, textStatus, error) {
				setErrorMessage(xhr.statusText + " - " + textStatus + " - "
						+ error);									
			}
		});
	}

	$(document).ready(function() {

		if (customerOid == null || customerOid == 'undefined') {
			window.href = "index.jsp";
		} else {
			
			if (userRole == 'MANAGER') {
				$(".userViewGrid").hide() ;
				$(".managerViewGrid").show() ;				
				getCustomerObj(customerOid);
			} else if (userRole == 'USER') {
				$(".userViewGrid").show() ;
				$(".managerViewGrid").hide() ;
				getRepUserObj(customerOid) ;
			}		

			$("#timeLapseSelectorId").on('change', function(e) {
				var optionSelected = $(this).find("option:selected");
				var valueSelected = optionSelected.val();
				getSlaExpired(valueSelected, 1);
			});

			$("#groupMiscDetailsSelectorId").on('change', function(e) {
				var optionSelected = $(this).find("option:selected");
				var valueSelected = optionSelected.val();
				loadGroupTaskSplitups(customerOid, valueSelected);
				// loadUserSatisfaction(customerOid, valueSelected);
			});

			$("#reshuffleTasks").click(function() {
				reshuffleTasks();
			});
		}
	});
</script>

<jsp:include page="tpl/footer.jsp"></jsp:include>
