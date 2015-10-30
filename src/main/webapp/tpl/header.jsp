<!doctype html>
<%@page import="com.hackthon.teamwg.projects.dto.RaasUsersDTO"%>
<html lang="en">

<head>
<meta charset="utf-8" />
<title>Welcome to Intelli Task Management System</title>

<link rel="stylesheet" href="css/layout.css" type="text/css"
	media="screen" />
<!--[if lt IE 9]>
	<link rel="stylesheet" href="css/ie.css" type="text/css" media="screen" />
	<script src="js/html5.js"></script>
	<![endif]-->
<script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="js/hideshow.js" type="text/javascript"></script>
<script src="js/jquery.tablesorter.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/jquery.equalHeight.js"></script>
<script type="text/javascript" src="js/jquery.sparkline.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<style type="text/css">
.prak_button {
	background: #D0D1D4 url("../images/btn_submit_2.png") repeat-x scroll 0%
		0%;
	border: 1px solid #30B0C8;
	box-shadow: 0px 1px 0px #FFF;
	font-weight: bold;
	height: 22px;
	border-radius: 5px;
	padding: 3px 10px;
	color: #003E49;
	text-shadow: 0px 1px 0px #6CDCF9;
	cursor: pointer;
	margin-left: 10px;
}
</style>
<script type="text/javascript">
	$(document).ready(
			function() {

				//When page loads...
				$(".tab_content").hide(); //Hide all content
				$("ul.tabs li:first").addClass("active").show(); //Activate first tab
				$(".tab_content:first").show(); //Show first tab content

				//On Click Event
				$("ul.tabs li").click(function() {

					$("ul.tabs li").removeClass("active"); //Remove any "active" class
					$(this).addClass("active"); //Add "active" class to selected tab
					$(".tab_content").hide(); //Hide all tab content

					var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
					$(activeTab).fadeIn(); //Fade in the active ID content
					return false;
				});

				$(".tablesorter").tablesorter();

				$("#sparkline_213").sparkline(
						[ 5, 6, 7, 9, 9, 5, 3, 2, 8, 4, 6, 7, 5, 6, 7, 9, 9, 5,
								3, 2, 8, 4, 6, 7, 4, 6, 8, 2, 4, 2, 7 ], {
							type : 'line',
							width : '83%',
							height : '200'
						});

				$("#sparkline_214").sparkline(
						[ 5, 6, 7, 9, 9, 5, 3, 2, 8, 4, 6, 7, 5, 6, 7, 9, 9, 5,
								3, 2, 8, 4, 6, 7, 4, 6, 8, 2, 4, 2, 7 ], {
							type : 'bar',
							height : '200',
							barWidth : 8,
							barSpacing : 2
						});

			});
</script>
<script type="text/javascript">
	$(function() {
		$('.column').equalHeight();
	});
</script>

</head>


<body>

	<header id="header">
		<hgroup>
			<h1 class="site_title">
				<a href="home.jsp">Intelli Task Mgmt System</a>
			</h1>
			<h2 class="section_title">User Dashboard</h2>
			<div class="btn_view_site"></div>
		</hgroup>
	</header>
	<!-- end of header bar -->

	<section id="secondary_bar">
		<div class="user">
			<p>
			<%
					RaasUsersDTO customerDTO = (RaasUsersDTO) session.getAttribute("customerDTO") ;
			if (customerDTO == null ) {
				out.println( " <META http-equiv='refresh' content='0;URL=index.jsp'> ");
			} else {
				out.print(customerDTO.getFirstName() + " (Customer ID: " + customerDTO.getLoginId() + ")") ;
				
				out.println("<script>var customerOid = '" + customerDTO.getLoginId() + "';</script>") ;
			}
					
			%>
			</p>
			<!-- <a class="logout_user" href="#" title="Logout">Logout</a> -->
		</div>
		<div class="breadcrumbs_container">
			<article class="breadcrumbs">
				<a href="home.jsp">Website Admin</a>
				<div class="breadcrumb_divider"></div>
				<a class="current">Dashboard</a>
			</article>
		</div>
	</section>
	<!-- end of secondary bar -->