<jsp:include page="tpl/header.jsp"></jsp:include>
<jsp:include page="tpl/left.jsp"></jsp:include>

<section id="main" class="column">

	<h4 class="" id="message_holder"></h4>

	<article class="module width_full">
		<header>
			<h3>Company Details</h3>
		</header>
		<div class="module_content">
			<article class="stats_graph">


				<fieldset style="width: 50%; float: left; margin-right: 3%;">
					<label>Company Name: </label>TamilNadu Electricity Board
					<div class="clear"></div>
					<br /> <label>Currency Type:</label> INR
					<div class="clear"></div>
					<br /> <label>Company Address:</label>TamilNadu Electric Board,
					Chennai, TamilNadu - 600001
					<div class="clear"></div>
					<br /> <label>Contact No:</label> 044-24242424
					<div class="clear"></div>
					<br /> <label>Service Charge:</label> 10 %
					<div class="clear"></div>
				</fieldset>


			</article>


			<div class="clear"></div>
		</div>
	</article>
	<!-- end of stats article -->

	<article class="module width_full">
		<header>
			<h3 class="tabs_involved">Usage Tier Details</h3>

		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">
				<table class="tablesorter" cellspacing="0">
					<thead>
						<tr>
							<th>Tier ID</th>
							<th>Tier Type</th>
							<th>Start</th>
							<th>End</th>
							<th>Rating</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td>1</td>
							<td>1</td>
							<td>300</td>
							<td>1.25</td>
						</tr>
						<tr>
							<td>2</td>
							<td>1</td>
							<td>301</td>
							<td>600</td>
							<td>1.75</td>
						</tr>
						<tr>
							<td>3</td>
							<td>1</td>
							<td>601</td>
							<td>1000</td>
							<td>2.25</td>
						</tr>

						<tr>
							<td>4</td>
							<td>1</td>
							<td>1000</td>
							<td>9999999999</td>
							<td>2.25</td>
						</tr>


						<tr>
							<td>5</td>
							<td>2</td>
							<td>1</td>
							<td>600</td>
							<td>2.00</td>
						</tr>

						<tr>
							<td>6</td>
							<td>2</td>
							<td>601</td>
							<td>1000</td>
							<td>2.75</td>
						</tr>

						<tr>
							<td>7</td>
							<td>2</td>
							<td>1001</td>
							<td>9999999999</td>
							<td>3.10</td>
						</tr>

					</tbody>
				</table>
			</div>
			<!-- end of #tab1 -->



		</div>
		<!-- end of .tab_container -->

		<footer>
			<!--				<div class="submit_link">
					 <input type="submit"  class="alt_btn" value="&nbsp;&nbsp;&nbsp;First&nbsp;&nbsp;&nbsp;">
					<input type="submit"  class="alt_btn" value="Previous">
					<input type="text"  class="alt_btn" value="" id="pages">
					<input type="submit" class="alt_btn" value="&nbsp;&nbsp;&nbsp;Next&nbsp;&nbsp;&nbsp;">
                    <input type="submit"  class="alt_btn" value="&nbsp;&nbsp;&nbsp;Last&nbsp;&nbsp;&nbsp;">
                    
				</div>  -->
		</footer>

	</article>
	<!-- end of content manager article -->

	<script type="text/javascript">
		$(document).ready(function() {

			$("#bread_crumb_text").html("Admin Options");

		});
	</script>

	<div class="spacer"></div>
</section>

<jsp:include page="tpl/footer.jsp"></jsp:include>