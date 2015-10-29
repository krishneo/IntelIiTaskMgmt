<jsp:include page="tpl/header.jsp"></jsp:include>
<jsp:include page="tpl/left.jsp"></jsp:include>

<section id="main" class="column">

	<article class="module width_full">
		<header>
			<h3>Add Task</h3>
		</header>
		<div class="module_content">
			<article class="stats_graph">


				<fieldset style="width: 50%; float: left; margin-right: 3%;">
					<form name="add_user_form" id="add_user_form" method="post" action="/user/add">
						<label>Task Key</label> <input name="task_key"
							style="width: 90%;" type="text">
						<div class="clear"></div>
						<br /> <label>Customer Type</label> <select name="customer_type"
							style="width: 92%;">
							<option value="1">Comercial</option>
							<option value="2">Home</option>
						</select>
						<div class="clear"></div>
						<br /> <label>Address</label> <input name="customer_address"
							maxlength="400" style="width: 90%;" type="text">
						<div class="clear"></div>
						<br /> <label>Region</label> <input name="customer_region"
							style="width: 90%;" type="text">
						<div class="clear"></div>
						<br /> <input name="customer_company" type="hidden" value="1"
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
		
		$(document).ready(
				function() {

					$("#submit_butn").click(function(e){
						
						var tes = $('#add_user_form').serializeObject () ;
						
						alert(  JSON.stringify(tes) ) ;
						
					});
					$("form").submit(function(e) {
						alert("asdds");
						e.preventDefault();
						
					}); 

				});
		
		</script>

	<div class="spacer"></div>
</section>

<jsp:include page="tpl/footer.jsp"></jsp:include>