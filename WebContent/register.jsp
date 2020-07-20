<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/n3c"%>
<!DOCTYPE html>
<c:if test="${empty user_email}">
    <c:set scope="session" var="not_logged_in" value="t"/>
    <c:redirect url="index.jsp"/>
</c:if>
<html>
<head>
	 <meta charset="utf-8">
	 <meta http-equiv="X-UA-Compatible" content="IE=edge">
     <meta name="viewport" content="width=device-width, initial-scale=1">
	 <title>N3C Login/Registration</title>
	 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
	 <link rel="stylesheet" id='font-awesome' href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">


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
    	<h2 class="header-text"><img src="images/n3c_logo.png" class="n3c_logo_header" alt="N3C Logo">N3C Registration</h2>
    	<n3c:registration email="${user_email}">
    	<form name="registration" method='POST' action='submit_registration.jsp' onsubmit="return validateForm()" >
  			<div class="form-group row">
    			<label for="email" class="col-sm-2 col-form-label">Email</label>
    			<div class="col-sm-10">
      				<input name="email" type="text" readonly class="form-control-plaintext" id="email" value="${user_email}">
    			</div>
  			</div>
  			<div class="form-group row">
    			<label class="required" for="first_name" class="col-sm-2 col-form-label">First Name</label>
                <style>.required:after { content:" *"; color: red; } </style>
    			<div class="col-sm-10">
      				<input name="first_name" type="text" class="form-control" id="first_name" value="${n3c:registrationFirstNameValue()}">
    			</div>
  			</div>
  			<div class="form-group row">
    			<label class="required" for="last_name" class="col-sm-2 col-form-label">Last Name</label>
    			<div class="col-sm-10">
      				<input name="last_name" type="text" class="form-control" id="last_name" value="${n3c:registrationLastNameValue()}">
    			</div>
  			</div>
  			<div class="form-group row">
    			<label class="required" for="institution" class="col-sm-2 col-form-label">Institution</label>
    			<div class="col-sm-10">
      				<input name="institution" type="text" class="form-control" id="institution" value="${n3c:registrationInstitutionValue()}">
    			</div>
  			</div>
            <div class="form-group row">
                <label for="institution" class="col-sm-2 col-form-label">Assistant's Email</label>
                <div class="col-sm-10">
                    <input name="assistant" type="text" class="form-control" id="assistant" value="${n3c:registrationAssistantEmailValue()}">
                </div>
            </div>
           <input type="checkbox" id="enclave" name="enclave" value="enclave" onclick="enclaveFunction()" <c:if test="${n3c:registrationEnclaveValue()}">checked</c:if> > <label for=""enclave"">Access to the N3C Enclave</label><br>
            
            <div id="enclave-div" style="display:<c:choose><c:when test="${n3c:registrationEnclaveValue()}">block</c:when><c:otherwise>none</c:otherwise></c:choose>;">
                <p>Your request for access to the Enclave will be submitted for approval. You will be notified via email shortly.
                Please provide these additional details to enhance your ability to collaborate and be credited for contributions.</p>
            <div class="form-group row">
                <label for="institution" class="col-sm-2 col-form-label">ORCiD ID</label>
                <div class="col-sm-10">
                    <input name="orcid" type="text" class="form-control" id="orcid" value="${n3c:registrationOrcidIdValue()}">
                </div>
            </div>
            <div class="form-group row">
                <label for="institution" class="col-sm-2 col-form-label">Expertise</label>
                <div class="col-sm-10">
                    <input name="expertise" type="text" class="form-control" id="expertise" value="${n3c:registrationExpertiseValue()}">
                </div>
            </div>
            <div class="form-group row">
                <label for="institution" class="col-sm-2 col-form-label">Therapeutic Area (for clinicians)</label>
                <div class="col-sm-10">
                    <input name="therapeutic" type="text" class="form-control" id="therapeutic" value="${n3c:registrationTherapeuticAreaValue()}">
                </div>
            </div>
            </div>

           <input type="checkbox" id="workstreams" name="workstreams" value="workstreams" onclick="workstreamFunction()" <c:if test="${n3c:registrationWorkstreamsValue()}">checked</c:if>> <label for=""workstream"">Participate in N3C Workstreams</label><br>

				<div id="workstream-div" style="display: <c:choose><c:when test="${n3c:registrationWorkstreamsValue()}">block</c:when><c:otherwise>none</c:otherwise></c:choose>;">
					<div class="form-group row">
						<label for="institution" class="col-sm-2 col-form-label">GSuite
							(GMail) ID</label>
						<div class="col-sm-10">
							<input name="gsuite" type="text" class="form-control" id="gsuite"
								value="${n3c:registrationGsuiteEmailValue()}">
						</div>
					</div>
					<div class="form-group row">
						<label for="institution" class="col-sm-2 col-form-label">Slack
							ID</label>
						<div class="col-sm-10">
							<input name="slack" type="text" class="form-control" id="slack"
								value="${n3c:registrationSlackIdValue()}">
						</div>
					</div>
					<div class="form-group row">
						<label for="institution" class="col-sm-2 col-form-label">GitHub
							ID</label>
						<div class="col-sm-10">
							<input name="github" type="text" class="form-control" id="github"
								value="${n3c:registrationGithubIdValue()}">
						</div>
					</div>
					<div class="form-group row">
						<label for="institution" class="col-sm-2 col-form-label">Twitter
							ID</label>
						<div class="col-sm-10">
							<input name="twitter" type="text" class="form-control"
								id="twitter" value="${n3c:registrationTwitterIdValue()}">
						</div>
					</div>
					<p>Please select the workstreams in which you would like to
						participate:</p>
		            <n3c:foreachWorkstream var="x">
		                <n3c:workstream>
		                    <div class="form-check mb-4">
		                        <input type="checkbox" id="${n3c:workstreamLabelValue()}" name="${n3c:workstreamLabelValue()}" value="${n3c:workstreamLabelValue()}" class="form-check-input">
		                        <label class="form-check-label" for="${n3c:workstreamLabelValue()}"><strong class="accent-text" style="font-size:18px;"><n3c:workstreamFullName/> </strong> - <n3c:workstreamDescription/></label>
		                    </div>
		                </n3c:workstream>
		            </n3c:foreachWorkstream>
				</div>

				<input type="hidden" name="official_first_name" value="${n3c:registrationOfficialFirstNameValue()}">
                <input type="hidden" name="official_last_name" value="${n3c:registrationOfficialLastNameValue()}">
            
            <div style="text-align:right;">
            	<button class="btn btn-n3c" type="submit" name="action" value="submit">Submit</button>
            </div>
    	</form>
        </n3c:registration>
	</div>
    <jsp:include page="footer.jsp" flush="true" />
	<script type="text/javascript">
		function enclaveFunction() {
			var x = document.getElementById("enclave-div");
			if (x.style.display === "none") {
				x.style.display = "block";
			} else {
				x.style.display = "none";
			}
		}

		function workstreamFunction() {
            var x = document.getElementById("workstream-div");
            if (x.style.display === "none") {
                x.style.display = "block";
            } else {
                x.style.display = "none";
            }
        }
		
		function validateForm() {
			  var first_name = document.forms["registration"]["first_name"].value;
			  if (first_name == "") {
			    alert("First name is required");
			    return false;
			  }
              var last_name = document.forms["registration"]["last_name"].value;
              if (last_name == "") {
                alert("Last name is required");
                return false;
              }
              var institution = document.forms["registration"]["institution"].value;
              if (institution == "") {
                alert("Institution is required");
                return false;
              }
		}
	</script>
</body>
</html>
