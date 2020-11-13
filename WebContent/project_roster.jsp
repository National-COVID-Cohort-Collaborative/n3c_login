<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<jsp:include page="head.jsp" flush="true" />

<style type="text/css" media="all">
	@import "resources/n3c_login_style.css";
</style>

<body>

	<jsp:include page="navbar.jsp" flush="true" />
	
	<c:if test="${not empty not_logged_in}">
		<div class=" n3c_alert">
    		<i class="fa fa-exclamation" aria-hidden="true">&emsp;</i>Our apologies, but you must successfully log in through NIH prior to registering. Click <a href="dologin.jsp">here</a> to be redirected.<br/>
    	</div>
    	<c:remove var="not_logged_in"/>
    </c:if>


	<div class="container center-box shadow-border">
    	<h2 class="header-text"><img src="images/n3c_logo.png" class="n3c_logo_header" alt="N3C Logo">Approved N3C Enclave Projects</h2>
    	<div style="text-align:center;">
 			
<p>&nbsp;</p>
<div id="table" style="overflow: scroll;">&nbsp;</div>

<div id="op_table" style="overflow: scroll;">&nbsp;</div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<link href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.js"></script>
<script>
$.getJSON("project_roster_feed.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.style.textAlign = "left";
	table.id="table1";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("table");
	divContainer.innerHTML = "";
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#table1').DataTable( {
    	data: data,
       	paging: true,
    	pageLength: 5,
    	lengthMenu: [ 5, 10, 25, 50, 75, 100 ],
    	order: [[0, 'asc']],
     	columns: [
        	{
        		data: 'title',
        		orderable: true,
        		width: '50%',
        		render: function ( data, type, row ) {
        			return '<a href="project.jsp?uid='+ row.uid + '&email=' + row.email +  '"><span style="color:#376076";>' + row.title + '<\/span></a>';
             		}
             },
        	{
            	data: 'lead_investigator',
            	orderable: true
        	 },
        	{ data: 'domain_team', visible: true, orderable: true},
         	{
        		data: 'bindings',
        		orderable: true,
        		render: function ( data, type, row ) {
        			if (row.bindings == null)
        				return '';
        			buffer = "<ul>";
        			for (i in row.bindings) {
        				buffer += '<li><a href="https://covid.cd2h.org/node/'+ row.bindings[i].nid + '"><span style="color:#376076";>' + row.bindings[i].title + '<\/span></a>';
        			}
        			buffer += "</ul>";
        			return buffer;
             		}
             }
    	]
	} );

	
});
</script>
	<jsp:include page="footer.jsp" flush="true" />
	</div>
</body>
</html>
