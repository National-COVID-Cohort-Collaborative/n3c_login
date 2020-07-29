<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/n3c"%>

    <c:set var="user_email" scope="session">${attributes.get("email")[0]}</c:set>

    <c:if test="${n3c:registrationExists(user_email)}">
        <c:redirect url="profile.jsp"/>
    </c:if>

    <c:set var="first_name">${attributes.get("given_name")[0]}</c:set>
    <c:set var="last_name">${attributes.get("family_name")[0]}</c:set>
    <c:set var="institution">${attributes.get("org")[0]}</c:set>
    <c:set var="name">${attributes.get("name")[0]}</c:set>
    <n3c:registration email="${user_email}">
        <n3c:registrationOfficialFirstName officialFirstName="${first_name}"/>
        <n3c:registrationOfficialLastName officialLastName="${last_name}"/>
        <n3c:registrationOfficialFullName officialFullName="${name}"/>
        <n3c:registrationFirstName firstName="${first_name}"/>
        <n3c:registrationLastName lastName="${last_name}"/>
        <n3c:registrationInstitution  institution="${institution}"/>
        <n3c:registrationOfficialInstitution  officialInstitution="${institution}"/>
        <n3c:registrationCreatedToNow/>
        <n3c:registrationUpdatedToNow/>
    </n3c:registration>
    
    <c:redirect url="register.jsp"/>
