<jsp:include page="tpl/header.jsp"></jsp:include>
<jsp:include page="tpl/left.jsp"></jsp:include>


<section id="main" class="column">
	<h4 class="" id="message_holder"></h4>
	<article class="module width_full">
		<header>
			<h3>Task Details</h3>
		</header>
		<div class="module_content">
			<article class="stats_graph">
				<fieldset style="width: 50%; float: left; margin-right: 3%;">
					<label>Task ID: 	   </label><label id="taskId"></label><div class="clear"></div><br />
					<label>Task Key: 	   </label><label id="taskName"></label><div class="clear"></div><br />
					<label>User Name: 	   </label><label id="userName"></label><div class="clear"></div><br /> 
					<label>Status:    	   </label><label id="status"></label><div class="clear"></div><br /> 
					<label>Group Name:	   </label><label id="groupName"></label><div class="clear"></div><br />
					<label>Created at:	   </label><label id="createdAt"></label><div class="clear"></div><br /> 
					<label>Work started at:</label><label id="workedAt"></label><div class="clear"></div><br />
					<label>Priority :      </label><label id="priority"></label><div class="clear"></div><br />
					<label>Internal sla:   </label><label id="internalSla"></label><div class="clear"></div><br />
					<label>External sla:   </label><label id="externalSla"></label><div class="clear"></div>
				</fieldset>
			</article>
			<div class="clear"></div>
		</div>
		<footer>
			<div class="submit_link">
				<input type="submit" class="alt_btn"  id="release" value="Release"  >
				<input type="submit" class="alt_btn"  id="assign" value="Assign"  >
				<input type="text"   class="alt_text" id="assign_text">
				<input type="submit" class="alt_btn"  id="assigned"  value="Go"  >
				<input type="submit" class="alt_btn"  id="acceptTask"  value="Accept Task"  >
				<input type="submit" class="alt_btn"  id="completeTask"  value="Complete Task"  >								
			</div>  
		</footer>
	</article>
	<!-- end of content manager article -->

	<script type="text/javascript">
	
	var task_key = null ;
	
		$(document).ready(function() { 
			 task_key = getQueryVariable("task_key");
			getTaskDetails(task_key); 
		});
		
		function getTaskDetails(in_task_key) {
			$.ajax({
				 type : "GET",
				url : "api/task/" + in_task_key,
				datatype : "json",
				contentType : "application/json; charset=utf-8",
				success : function(msg) { 
			       fillTaskRecords(msg,in_task_key);
				},
				error : function(xhr, textStatus, error) {
					setErrorMessage(xhr.statusText + " - " + textStatus + " - "
							+ error);
				}
			}); 
		}
		
		 function fillTaskRecords(msg,in_task_key)
		{
			 var created_dt = "" ;
			 var work_sta_dt = "" ;
			 var completed_dt = "" ;
			 var user_name = "" ;
			
			if (msg.created_timestamp != null && msg.created_timestamp != 'null' ) {
				var d = new Date(msg.created_timestamp);
				created_dt = [ d.getMonth() + 1, d.getDate(), d.getFullYear() ]
							.join('/')
							+ ' '
							+ [ d.getHours(), d.getMinutes(), d.getSeconds() ]
									.join(':');
			}	
			if (msg.work_start_timestamp != null && msg.work_start_timestamp != 'null' ) {
				var d = new Date(msg.work_start_timestamp);
				work_sta_dt = [ d.getMonth() + 1, d.getDate(), d.getFullYear() ]
							.join('/')
							+ ' '
							+ [ d.getHours(), d.getMinutes(), d.getSeconds() ]
									.join(':');
			}	
			if (msg.completed_ts != null && msg.completed_ts != 'null') {
				var d = new Date(msg.completed_ts);
				completed_dt = [ d.getMonth() + 1, d.getDate(), d.getFullYear() ]
							.join('/')
							+ ' '
							+ [ d.getHours(), d.getMinutes(), d.getSeconds() ]
									.join(':');
			}
			
			if (msg.user_name != null ) {
				user_name = msg.user_name ;
			}
			
			 
			$('#taskName').text(in_task_key);
			$('#taskId').text(msg.task_oid);
			$('#userName').text(user_name);
			$('#status').text(msg.status);
			$('#groupName').text(msg.group_name);
			$('#createdAt').text(created_dt);
			$('#workedAt').text(work_sta_dt);
			$('#completedAt').text(completed_dt);
			$('#priority').text(msg.priority);
			$('#internalSla').text(msg.internal_sla);
			$('#externalSla').text(msg.external_sla);
			if($('#userName').text()!="" && $('#userName').text()!= null && $('#userName').text()!="null" )
			{
				if (msg.status != 'COMPLETED') {
				    $('#release').show() ;
				    $('#assign').hide();
				    $('#assign_text').hide();
				    $('#assigned').hide();
				} else {
					$('#release').hide() ;
				    $('#assign').hide();
				    $('#assign_text').hide();
				    $('#assigned').hide();
				    $('#acceptTask').hide();
				    $('#completeTask').hide();
				}
			}
			else
			{
				$('#release').hide();
				$('#assign').show() ;
				$('#assign_text').hide();
				$('#assigned').hide();
			}
		}
		
		$('#assign').click(function(){
			$('#assign_text').show();
			$('#assigned').show();
		});
		
		$("#assigned").click(function(){
			$.ajax({
				 type : "POST",
				url : "api/task/update/" + $('#taskId').text() + "?status=ASSIGNED&user_name=" + $('#assign_text').val(),
				datatype : "json",
				contentType : "application/json; charset=utf-8",
				success : function(msg) {
					alert("Updated") ;
					getTaskDetails(task_key); 
				},
				error : function(xhr, textStatus, error) {
					setErrorMessage(xhr.statusText + " - " + textStatus + " - "
							+ error);
				}
			}); 
		}) ;
		
		$("#completeTask").click(function(){
			$.ajax({
				 type : "POST",
				url : "api/task/update/" + $('#taskId').text() + "?status=COMPLETED&user_name=" + customerOid,
				datatype : "json",
				contentType : "application/json; charset=utf-8",
				success : function(msg) {
					alert("Updated") ;
					getTaskDetails(task_key); 
				},
				error : function(xhr, textStatus, error) {
					setErrorMessage(xhr.statusText + " - " + textStatus + " - "
							+ error);
				}
			}); 
		}) ;
		
		$("#acceptTask").click(function(){
			$.ajax({
				 type : "POST",
				url : "api/task/update/" + $('#taskId').text() + "?status=WORKING&user_name=" + customerOid,
				datatype : "json",
				contentType : "application/json; charset=utf-8",
				success : function(msg) {
					alert("Updated") ;
					getTaskDetails(task_key); 
				},
				error : function(xhr, textStatus, error) {
					setErrorMessage(xhr.statusText + " - " + textStatus + " - "
							+ error);
				}
			}); 
		}) ;
		
		$("#release").click(function(){
			$.ajax({
				 type : "POST",
				url : "api/task/update/" + $('#taskId').text() + "?status=UNASSIGNED&user_name=null",
				datatype : "json",
				contentType : "application/json; charset=utf-8",
				success : function(msg) {
					alert("Updated") ;
					getTaskDetails(task_key); 
				},
				error : function(xhr, textStatus, error) {
					setErrorMessage(xhr.statusText + " - " + textStatus + " - "
							+ error);
				}
			}); 
		}) ;
		
		$("#currentPageCrumbId").html("View Task") ;
		
	</script>
	<div class="spacer"></div>
</section>

<jsp:include page="tpl/footer.jsp"></jsp:include>
