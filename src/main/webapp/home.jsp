<jsp:include page="tpl/header.jsp"></jsp:include>
<jsp:include page="tpl/left.jsp"></jsp:include>

<section id="main" class="column">

	<h4 class="alert_info">Welcome to the Tamilnadu Electricity Board</h4>

	<article class="module width_full">
		<header>
			<h3 class="tabs_involved">Time Lapsed Tasks</h3>
		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">
				<span style="float: right; padding: 10px; font-weight: bold;">Group
					Name &nbsp;&nbsp;&nbsp; <select name="goupName"
					id="timeLapseSelectorId"></select>
				</span>
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
						<tr></tr>
						<tr></tr>
						<tr></tr>
						<tr></tr>
						<tr></tr>
						<tr></tr>
						<tr></tr>
						<tr></tr>
						<tr></tr>
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
	<!-- end of content manager article -->



	<article class="module width_full">
		<header>
			<h3>Current Month Consumption</h3>
		</header>
		<div class="module_content">
			<article class="stats_graph">

				<!--  <span id="sparkline_214"> </span>  -->
				<span style=""> &nbsp; &nbsp; &nbsp; &nbsp;</span> <span
					id="sparkline_213"> </span> <br /> <span style="left: 10%;">Rating
					Per Day</span>


			</article>

			<article class="stats_overview">
				<div class="overview_today">
					<p class="overview_day">Till Date</p>
					<p class="overview_count" id="currentConsumption">1,876</p>
					<p class="overview_type">Readings</p>
					<p class="overview_count">TYD</p>
					<p class="overview_type">Charges</p>
				</div>
				<div class="overview_previous">
					<p class="overview_day">Last Month</p>
					<p class="overview_count" id="lastMonthConsumption">2,876</p>
					<p class="overview_type">Readings</p>
					<p class="overview_count">TYD</p>
					<p class="overview_type">Charges</p>
				</div>
			</article>
			<div class="clear"></div>
		</div>
	</article>
	<!-- end of stats article -->


	<div class="spacer"></div>
</section>

<script>
	var cur_page_no = 1;
	var userCurrency = "";
	var cur_cust_oid = customerOid;
	var managing_groups = [];

	function payInvoice(rowId, link) {
		alert("Assuming Completion of Payment Gateway Steps");

		$.ajax({
			type : "POST",
			url : "api/" + link,
			datatype : "json",
			contentType : "application/json; charset=utf-8",
			success : function(msg) {
				var roId = "#" + rowId;
				$(roId).html("Paid");
				$(roId).css("color", "green");
			},
			error : function(xhr, textStatus, error) {
				setErrorMessage(xhr.statusText + " - " + textStatus + " - "
						+ error);
			}
		});

	}

	function fillInvoiceReponseData(invoices) {

		var rec_count = 0;

		var finalHead = "<tr><th>Invoice No</th><th>Dated</th><th>Units Consumed</th><th>Net Amount</th><th>Status</th><th>Download</th></tr>";
		$("#user_list_thead").html(finalHead);
		var finalHtml = "";
		for ( var itr in invoices) {

			var pay_txt = "";
			var row_id = "ver_row_" + rec_count;

			var mon = invoices[itr].invoicedMonth;

			if (mon < 10)
				mon = "0" + mon;

			if (invoices[itr].paidFlag == 'Y') {
				pay_txt = "<a href='#' style='font-weight: bold; color: green;'>Paid</a>";
			} else {
				pay_txt = "<a href='javascript:payInvoice(\"" + row_id
						+ "\",\"invoice/pay?invoice_id="
						+ invoices[itr].invoiceOid
						+ "\")' style='font-weight: bold; color: red; ' "
						+ " id='" + row_id + "' >Click to Pay</a>";
			}

			finalHtml += "<tr ><td>"
					+ invoices[itr].invoiceOid
					+ "</td><td>"
					+ mon
					+ "/"
					+ invoices[itr].invoicedYear
					+ "</td><td>"
					+ invoices[itr].consumedUnits
					+ "</td><td>"
					+ invoices[itr].netAmt
					+ " "
					+ userCurrency
					+ "</td><td>"
					+ pay_txt
					+ "</td><td>"
					+ "<a target=_blank href='api/invoice/download?invoice_id="
					+ invoices[itr].invoiceOid
					+ "'><input type='image' src='images/pdf_icon.jpg' title='Download Invoice'></a>";
			+"</td></tr>";
			rec_count++;
		}
		$("#user_list_tbody").html(finalHtml);

		if (cur_page_no > 1 && rec_count == 0)
			getAllUserRecords(1);

	}

	function fillSlaExpiredData(slaData) {

		var rec_count = 0;

		var finalHead = "<tr><th>Task Key</th><th>Created Date</th><th>Priority</th><th>Time Lapse From SLA</th></tr>";
		$("#user_list_thead").html(finalHead);
		var finalHtml = "";
		for ( var itr in slaData) {

			var row_id = "ver_row_" + rec_count;

			finalHtml += "<tr><td>" + slaData[itr].task_key + "</td><td>"
					+ ( new Date(slaData[itr].created_timestamp * 1000) )  + "</td><td>"
					+ slaData[itr].priority + "</td><td>"
					+ slaData[itr].time_lapse_to_sla + "</td></tr>";
			rec_count++;
		}
		$("#user_list_tbody").html(finalHtml);

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
							$('#timeLapseSelectorId').append(
									'<option selected="selected" value="' + managing_groups[groups] + '">'
											+ managing_groups[groups]
											+ '</option>');
							group_first = managing_groups[groups];
						} else
							$('#timeLapseSelectorId').append(
									'<option selected value="' + managing_groups[groups] + '">'
											+ managing_groups[groups]
											+ '</option>');
					}
				}

				// alert(managing_groups);

				$('#timeLapseSelectorId').val(group_first);
				getSlaExpired(group_first, 1);

				/* var chartData = msg.customerUsageString;
				var arrs = chartData.split(",");

				$("#sparkline_213").sparkline(arrs, {
					type : 'line',
					width : '83%',
					height : '200'
				});  */

				// getUserRecords(cur_cust_oid, 1);
			},
			error : function(xhr, textStatus, error) {
				setErrorMessage(xhr.statusText + " - " + textStatus + " - "
						+ error);
			}
		});
	}

	$(document).ready(function() {
		getCustomerObj(customerOid);
		$("#prev_pages_no").click(function() {
			if (cust_oids) {
				if (cur_page_no != 1) {
					getUserRecords(cust_oids, cur_page_no - 1);
				}
			} else {
				if (cur_page_no != 1) {
					getAllUserRecords(cur_page_no - 1);
				}
			}

		});

		$("#next_pages_no").click(function() {
			if (cust_oids) {
				getUserRecords(cust_oids, cur_page_no + 1);
			} else {
				getAllUserRecords(cur_page_no + 1);
			}
		});

		$("#timeLapseSelectorId").on('change', function(e) {
			var optionSelected = $(this).find("option:selected");
			var valueSelected = optionSelected.val();
			getSlaExpired(valueSelected, 1);
		});

	});
</script>

<jsp:include page="tpl/footer.jsp"></jsp:include>