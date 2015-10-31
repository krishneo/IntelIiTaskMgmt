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
					<label>Task Name: 	   </label><label id="taskName"></label><div class="clear"></div><br />
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
				<input type="submit" class="alt_btn"  id="release" disabled="true" value="Release"  >
				<input type="submit" class="alt_btn"  id="assign" disabled="false" value="Assign"  >
				<input type="text"   class="alt_text" id="assign_text">
				<input type="submit" class="alt_btn"  id="assigned"  value="Go"  >
			</div>  
		</footer>
	</article>
	<!-- end of content manager article -->

	<script type="text/javascript">
		$(document).ready(function() {
			 $('#assign_text').hide();
			$('#assigned').hide(); 
			var task_key = getQuer yVariable("task_key");
			getTaskDetails(task_key); 
		});
		
		function getTaskDetails(in_task_key) {
			$.ajax({
				 type : "GET",
				url : "api/task?task_key=" + in_task_key,//give ur rest api here
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
			$('#taskName').text(in_task_key);
			$('#userName').text(msg.user_name);
			$('#status').text(msg.status);
			$('#groupName').text(msg.group_name);
			$('#createdAt').text(msg.created_at);
			$('#workedAt').text(msg.worked_at);
			$('#priority').text(msg.priority);
			$('#internalSla').text(msg.internal_sla);
			$('#externalSla').text(msg.external_sla);
			if($('#userName').text()!="")
			{
			    $('#release').prop('disabled',false);
			    $('#assign').hide();
			}
			else
			{
				$('#release').hide();
				$('#assign').prop('disabled',false);
			}
		}
		
		$('#assign').click(function(){
			$('#assign_text').show();
			$('#assigned').show();
		});
		
		
	</script>
	<div class="spacer"></div>
</section>

<jsp:include page="tpl/footer.jsp"></jsp:include>