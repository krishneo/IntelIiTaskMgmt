<jsp:include page="tpl/header.jsp"></jsp:include>
<jsp:include page="tpl/left.jsp"></jsp:include>

<section id="main" class="column">
		
		<h4 class="alert_info">Welcome to the Tamilnadu Electricity Board</h4>
		
		<article class="module width_full">
			<header><h3>Current Month Consumption</h3></header>
			<div class="module_content">
				<article class="stats_graph">
				 
                  <!--  <span id="sparkline_214"> </span>  -->
                    <span style=""> &nbsp; &nbsp; &nbsp; &nbsp;</span>

                    <span id="sparkline_213"> </span> 
                    <br /> Rating Per Day                                     
                    
                    
				</article>
				
				<article class="stats_overview">
					<div class="overview_today">
						<p class="overview_day">Till Date</p>
						<p class="overview_count">1,876</p>
						<p class="overview_type">Readings</p>
						<p class="overview_count">2,103</p>
						<p class="overview_type">Charges</p>
					</div>
					<div class="overview_previous">
						<p class="overview_day">Last Month</p>
						<p class="overview_count">2,876</p>
						<p class="overview_type">Readings</p>
						<p class="overview_count">4,703</p>
						<p class="overview_type">Charges</p>
					</div>
				</article>
				<div class="clear"></div>
			</div>
		</article><!-- end of stats article -->
		
		<article class="module width_full">
		<header><h3 class="tabs_involved">Invoice Details</h3>
		 
		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">
			<table class="tablesorter" cellspacing="0"> 
			<thead> 
				<tr>     				
    				<th>Month</th>     				
                    <th>Metered Reading</th>
                    <th>Amount</th>  
    				<th>Actions</th> 
				</tr> 
			</thead> 
			<tbody> 
				<tr>  
    				<td>Lorem Ipsum Dolor Sit Amet</td> 
    				<td>Articles</td> 
    				<td>5th April 2011</td> 
    				<td><input type="image" src="images/icn_alert_info.png" title="More Information"><input type="image" src="images/pdf_icon.jpg" title="Download Invoice"><input type="image" src="images/basic-icon-download.png" title="Pay Invoice"></td>
				</tr> <tr>  
    				<td>Lorem Ipsum Dolor Sit Amet</td> 
    				<td>Articles</td> 
    				<td>5th April 2011</td> 
    				<td><input type="image" src="images/icn_edit.png" title="Edit"><input type="image" src="images/icn_trash.png" title="Trash"></td> 
				</tr> 
				<tr>  
    				<td>Ipsum Lorem Dolor Sit Amet</td> 
    				<td>Freebies</td> 
    				<td>6th April 2011</td> 
   				 	<td><input type="image" src="images/icn_edit.png" title="Edit"><input type="image" src="images/icn_trash.png" title="Trash"></td> 
				</tr>
				<tr>  
    				<td>Sit Amet Dolor Ipsum</td> 
    				<td>Tutorials</td> 
    				<td>10th April 2011</td> 
    				<td><input type="image" src="images/icn_edit.png" title="Edit"><input type="image" src="images/icn_trash.png" title="Trash"></td> 
				</tr> 
				<tr>  
    				<td>Dolor Lorem Amet</td> 
    				<td>Articles</td> 
    				<td>16th April 2011</td> 
   				 	<td><input type="image" src="images/icn_edit.png" title="Edit"><input type="image" src="images/icn_trash.png" title="Trash"></td> 
				</tr>
				<tr>  
    				<td>Dolor Lorem Amet</td> 
    				<td>Articles</td> 
    				<td>16th April 2011</td> 
   				 	<td><input type="image" src="images/icn_edit.png" title="Edit"><input type="image" src="images/icn_trash.png" title="Trash"></td> 
				</tr>  
			</tbody> 
			</table>
			</div><!-- end of #tab1 -->
			
			 
			
		</div><!-- end of .tab_container -->
        
        <footer>
<!--				<div class="submit_link">
					 <input type="submit"  class="alt_btn" value="&nbsp;&nbsp;&nbsp;First&nbsp;&nbsp;&nbsp;">
					<input type="submit"  class="alt_btn" value="Previous">
					<input type="text"  class="alt_btn" value="" id="pages">
					<input type="submit" class="alt_btn" value="&nbsp;&nbsp;&nbsp;Next&nbsp;&nbsp;&nbsp;">
                    <input type="submit"  class="alt_btn" value="&nbsp;&nbsp;&nbsp;Last&nbsp;&nbsp;&nbsp;">
                    
				</div>  -->
			</footer>
		
		</article><!-- end of content manager article -->
		
		 
		
		<article class="module width_full">
			<header><h3 id="usage_breakdown">Usage breakdown</h3></header>
				<div class="module_content">
						<fieldset>
							<label>Post Title</label>
							<input type="text">
						</fieldset>
						<fieldset>
							<label>Content</label>
							<textarea rows="12"></textarea>
						</fieldset>
						<fieldset style="width:48%; float:left; margin-right: 3%;"> <!-- to make two field float next to one another, adjust values accordingly -->
							<label>Category</label>
							<select style="width:92%;">
								<option>Articles</option>
								<option>Tutorials</option>
								<option>Freebies</option>
							</select>
						</fieldset>
						<fieldset style="width:48%; float:left;"> <!-- to make two field float next to one another, adjust values accordingly -->
							<label>Tags</label>
							<input type="text" style="width:92%;">
						</fieldset><div class="clear"></div>
				</div>
			<footer>
				<div class="submit_link">
					<select>
						<option>Draft</option>
						<option>Published</option>
					</select>
					<input type="submit" value="Publish" class="alt_btn">
					<input type="submit" value="Reset">
				</div>
			</footer>
		</article><!-- end of post new article -->
		
		<h4 class="alert_warning">A Warning Alert</h4>
		
		<h4 class="alert_error">An Error Message</h4>
		
		<h4 class="alert_success">A Success Message</h4>
		
		<article class="module width_full">
			<header><h3>Basic Styles</h3></header>
				<div class="module_content">
					<h1>Header 1</h1>
					<h2>Header 2</h2>
					<h3>Header 3</h3>
					<h4>Header 4</h4>
					<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras mattis consectetur purus sit amet fermentum. Maecenas faucibus mollis interdum. Maecenas faucibus mollis interdum. Cras justo odio, dapibus ac facilisis in, egestas eget quam.</p>

<p>Donec id elit non mi porta <a href="#">link text</a> gravida at eget metus. Donec ullamcorper nulla non metus auctor fringilla. Cras mattis consectetur purus sit amet fermentum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum.</p>

					<ul>
						<li>Donec ullamcorper nulla non metus auctor fringilla. </li>
						<li>Cras mattis consectetur purus sit amet fermentum.</li>
						<li>Donec ullamcorper nulla non metus auctor fringilla. </li>
						<li>Cras mattis consectetur purus sit amet fermentum.</li>
					</ul>
				</div>
		</article><!-- end of styles article -->
		<div class="spacer"></div>
	</section>
	
	<script>
	
	alert( customerOid ) ;
	
	</script>

<jsp:include page="tpl/footer.jsp"></jsp:include>