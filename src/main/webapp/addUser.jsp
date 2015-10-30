<jsp:include page="tpl/header.jsp"></jsp:include>
<jsp:include page="tpl/left.jsp"></jsp:include>

<section id="main" class="column">

	<h4 class="" id="message_holder"></h4>

	<article class="module width_full">
		<header>
			<h3>Add User</h3>
		</header>
		<div class="module_content">
			<article class="stats_graph">


				<fieldset style="width: 50%; float: left; margin-right: 3%;">
					<form name="add_user_form" id="add_user_form" method="post"
						action="/user/add">
						<label>User Name</label> <input name="customerName"
							style="width: 90%;" type="text">
						<div class="clear"></div>
						<br /> <label>User Email</label> <input name="customerEmail"
							style="width: 90%;" type="text">
						<div class="clear"></div>
						<br />
						<label>Password</label> <input name="customerPass"
							style="width: 90%;" type="password">
						<div class="clear"></div>
						<br /> <label>Address</label> <input name="addressStr"
							maxlength="400" style="width: 90%;" type="text">
						<div class="clear"></div>
						<br /> <label>Region</label> <input name="regionDetails"
							style="width: 90%;" type="text">
						<div class="clear"></div>
						<br /> <label>Customer Type</label> <select
							name="customerTypeOid" style="width: 92%;">
							<option value="1">Home</option>
							<option value="2">Comercial</option>
						</select>
						<div class="clear"></div>
						<br /> <label>Currency Preference</label> <select
							name="currencyType" style="width: 92%;">
							<option value="INR">INR</option>
							<option value="USD">USD</option>
						</select>
						<div class="clear"></div>
						<br /> <label>Is Admin User</label> <select name="adminFlag"
							style="width: 92%;">
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select>
						<div class="clear"></div>
						<br /> <input name="companyOid" type="hidden" value="1"
							style="width: 90%;">
						<div class="clear"></div>
						<br /> <input id="submit_butn" class="prak_button" type="button"
							value="Add Customer" style="width: 90%;">
						<div class="clear"></div>
						<br />
					</form>
				</fieldset>


			</article>


			<div class="clear"></div>
		</div>
	</article>
	<!-- end of stats article -->

	<script type="text/javascript">
		$(document)
				.ready(
						function() {

							$("#submit_butn")
									.click(
											function(e) {

												var tes = $('#add_user_form')
														.serializeObject();
												var data = JSON.stringify(tes);

												$
														.ajax({
															type : "POST",
															url : "api/user/add",
															datatype : "json",
															data : data,
															contentType : "application/json; charset=utf-8",
															success : function(
																	msg) {
																setSuccessMessage("Data Saved: "
																		+ msg);
																$('#add_user_form')[0]
																		.reset();
															},
															error : function(
																	xhr,
																	textStatus,
																	error) {
																setErrorMessage(xhr.statusText
																		+ " - "
																		+ textStatus
																		+ " - "
																		+ error);
															}
														});

											});

							$("form").submit(function(e) {
								alert("asdds");
								e.preventDefault();

							});

							$("#bread_crumb_text").html("Add User");
							//	$('#message_holder').attr("class", "alert_info").html("Sample ") ;

						});
	</script>

	<div class="spacer"></div>
</section>

<jsp:include page="tpl/footer.jsp"></jsp:include>