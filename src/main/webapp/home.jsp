<jsp:include page="tpl/header.jsp"></jsp:include>
<jsp:include page="tpl/left.jsp"></jsp:include>

<section id="main" class="column">

	<h4 class="alert_info">Welcome to the Tamilnadu Electricity Board</h4>

	<article class="module width_full">
		<header>
			<h3>Current Month Consumption</h3>
		</header>
		<div class="module_content">
			<article class="stats_graph">

				<!--  <span id="sparkline_214"> </span>  -->
				<span style=""> &nbsp; &nbsp; &nbsp; &nbsp;</span> <span
					id="sparkline_213"> </span> <br /> <span style="left: 10%;">Rating Per Day</span>


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


	<article class="module width_full">
		<header>
			<h3 class="tabs_involved">My Invoice Details</h3>

		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">
				<table class="tablesorter" cellspacing="0">
					<thead id="user_list_thead">

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



	<div class="spacer"></div>
</section>

<script>
	var cur_page_no = 1;
	var userCurrency = "";
	var cur_cust_oid = customerOid;

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

	function getUserRecords(in_cust_oid, page_no) {

		cur_page_no = page_no;

		$.ajax({
			type : "GET",
			url : "api/user/invoices?page_no=" + page_no + "&cust_oid="
					+ in_cust_oid,
			datatype : "json",
			contentType : "application/json; charset=utf-8",
			success : function(msg) {
				// setSuccessMessage("Data Saved: " + msg);
				$("#pages_no").val(page_no);
				fillInvoiceReponseData(msg);
			},
			error : function(xhr, textStatus, error) {
				setErrorMessage(xhr.statusText + " - " + textStatus + " - "
						+ error);
			}
		});

	}

	function getCustomerObj(in_cust_oid) {
		$.ajax({
			type : "GET",
			url : "api/user?cust_oid=" + in_cust_oid,
			datatype : "json",
			contentType : "application/json; charset=utf-8",
			success : function(msg) {
				cur_cust_oid = msg.customerOid;
				userCurrency = msg.currencyType; 
				var curMr = msg.currentMonthReading ;
				if (curMr == null || curMr == undefined )
					curMr = 0 ;
				var lasMr = msg.lastMonthReading ;
				if (lasMr == null || lasMr == undefined )
					lasMr = 0 ;
				lasMr = lasMr + " " + userCurrency ;
				$("#currentConsumption").html(curMr);
				$("#lastMonthConsumption").html(lasMr);
				
				var chartData = msg.customerUsageString ;
				var arrs = chartData.split(",") ;
				
				$("#sparkline_213").sparkline(
						arrs, {
							type : 'line',
							width : '83%',
							height : '200'
						});
				
				getUserRecords(cur_cust_oid, 1);
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
	 
	});
</script>

<jsp:include page="tpl/footer.jsp"></jsp:include>