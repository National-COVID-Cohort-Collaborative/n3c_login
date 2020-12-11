<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/n3c"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>

<c:if test="${empty user_email}">
	<c:set scope="session" var="not_logged_in" value="t" />
	<c:redirect url="index.jsp" />
</c:if>
<c:if test="${not empty param.save}">
    <sql:update dataSource="jdbc/N3CLoginTagLib">
        insert into n3c_admin.registration_remap values(?,?)
        <sql:param>${param.institution}</sql:param>
        <sql:param>${param.save}</sql:param>
    </sql:update>
    <c:redirect url="admin.jsp" />
</c:if>

<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>N3C ROR - CTSA Match</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<link rel="stylesheet" id='font-awesome'
	href="https://use.fontawesome.com/releases/v5.7.2/css/all.css"
	integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr"
	crossorigin="anonymous">


<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
       <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
       <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
     <![endif]-->
</head>

<style type="text/css" media="all">
@import "resources/n3c_login_style.css";
</style>

<body>

	<jsp:include page="navbar.jsp" flush="true" />
	
	<div class="container center-box shadow-border">
		<h2 class="header-text">
			<img src="images/n3c_logo.png" class="n3c_logo_header" alt="N3C Logo">N3C Registration Admin Match to InCommon
		</h2>
		
        <form name="incommon" method='POST' action='award_map.jsp' >
            <c:set var="ror_pattern" value="${param.ror_pattern}"/>
            <c:if test="${empty ror_pattern}">
                <c:set var="ror_pattern" value="${param.institution}"/>
            </c:if>
            <div class="form-group row">
                <label for="org_pattern" class="required col-sm-2 col-form-label">Org pattern</label>
                <style>.required:after { content:" *"; color: red; } </style>
                <div class="col-sm-10">
                    <input name="org_pattern" type="text" size="20" class="form-control" id="org_pattern" value="${param.org_pattern}">
                </div>
            </div>
            <div style="text-align:left;">
                <button class="btn btn-n3c" type="submit" name="action" value="submit">Submit</button>
            </div>
            <input type="hidden" name="institution" value="${param.institution}">
        </form>
        <c:if test="${not empty param.org_pattern }">
	 		<h3>Candidate mappings</h3>
		    <sql:query var="categories" dataSource="jdbc/N3CLoginTagLib">
		        select institutionid,institutionname,project.application_id,core_project_num,full_project_num,title,org_name
		        from n3c_admin.dta_master,nih_exporter.project
		        where lower(institutionname)~lower(?) and lower(project.org_name)~lower(?) and activity='UL1' and application_type=1 and now()<project_end;
		        <sql:param>${param.org_pattern}</sql:param>
		        <sql:param>${param.org_pattern}</sql:param>
		    </sql:query>
		    <table class="table table-hover">
		    <thead><tr><th>ROR ID</th><th>ROR Name</th><th>Application ID</th><th>Core Award #</th><th>Full Award #</th><th>Title</th><th>Organization</th></tr></thead>
		    <tbody>
		    <c:forEach items="${categories.rows}" var="row" varStatus="rowCounter">
		        <tr><td><a href="submit_award_mapping.jsp?ror=${row.institutionid}&application=${row.application_id}&award=${row.core_project_num}">${row.institutionid}</a></td><td>${row.institutionname}</td><td>${row.application_id}</td><td>${row.core_project_num}</td><td>${row.full_project_num}</td><td>${row.title}</td><td>${row.org_name}</td></tr>
		    </c:forEach>
		    </tbody>
		    </table>
        </c:if>
		<h3>Unbound DTAs</h3>
	    <sql:query var="dtas" dataSource="jdbc/N3CLoginTagLib">
	        select institutionid as ror_id, institutionname as ror_name
	        from n3c_admin.dta_master
	        where institutionid not in (select ror_id from n3c_admin.award_map) and institutionid not in (select ror_id from n3c_admin.award_suppress) order by 2;
	    </sql:query>
	    <table class="table table-hover">
	    <thead><tr><th>ROR ID</th><th>Institution</th></tr></thead>
	    <tbody>
	    <c:forEach items="${dtas.rows}" var="row" varStatus="rowCounter">
	        <tr><td><a href="submit_award_suppress.jsp?ror=${row.ror_id}">${row.ror_id}</a></td><td>${row.ror_name}</td></tr>
	    </c:forEach>
	    </tbody>
	    </table>
	</div>
	<jsp:include page="footer.jsp" flush="true" />
</body>
</html>
