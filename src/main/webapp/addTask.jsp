<jsp:include page="tpl/header.jsp"></jsp:include>
<jsp:include page="tpl/left.jsp"></jsp:include>

<section id="main" class="column">

	<h4 class="" id="message_holder"></h4>

	<article class="module width_full">
		<header>
			<h3>Add Task</h3>
		</header>
		<div class="module_content">
			<article class="stats_graph">


				<fieldset style="width: 50%; float: left; margin-right: 3%;">
					<form name="add_user_form" id="add_user_form" method="post"
						action="/user/add">
						<label>Task Key</label> <input name="task_key"
							style="width: 90%;" type="text">
						<div class="clear"></div>
						<br /> <label>Group name</label> <input name="group_name"
							style="width: 90%;" type="text">
						<div class="clear"></div>
						<br />
						<label>Priority</label> <input name="priority"
							style="width: 90%;" type="text">
						<div class="clear"></div>
						<br /> <label>Weightage</label> <input name="internal_sla"
							maxlength="400" style="width: 90%;" type="text">
						<div class="clear"></div>
						<br /> <label>SLA</label> <input name="external_sla"
							style="width: 90%;" type="text">
						<div class="clear"></div>
						
						<br /> <input id="submit_butn" class="prak_button" type="button"
							value="Add Task" style="width: 90%;">
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
		$(document).ready(function() {
							$("#submit_butn").click(function(e) {
												var tes = $('#add_user_form').serializeObject();
												var data = JSON.stringify(tes);
												$.ajax({
															type : "POST",
															url : "api/task/add",
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

							$("#add_user_form").submit(function(e) {
								e.preventDefault();
							});

							$("#currentPageCrumbId").html("Add Task");
							//	$('#message_holder').attr("class", "alert_info").html("Sample ") ;

						});
	</script>

	<div class="spacer"></div>
</section>

<jsp:include page="tpl/footer.jsp"></jsp:include>