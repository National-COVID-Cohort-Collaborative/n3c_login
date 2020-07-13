<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/n3c"%>

    <n3c:registration email="${user_email}">
        <n3c:registrationOfficialFirstName officialFirstName="${param.official_first_name}"/>
        <n3c:registrationOfficialLastName officialLastName="${param.official_last_name}"/>
        <n3c:registrationFirstName firstName="${param.first_name}"/>
        <n3c:registrationLastName lastName="${param.last_name}"/>
        <n3c:registrationInstitution  institution="${param.institution}"/>
        <n3c:registrationOrcidId  orcidId="${param.orcid}"/>
        <n3c:registrationGsuiteEmail  gsuiteEmail="${param.gsuite}"/>
        <n3c:registrationSlackId  slackId="${param.slack}"/>
        <n3c:registrationGithubId  githubId="${param.github}"/>
        <n3c:registrationTwitterId  twitterId="${param.twitter}"/>
        <n3c:registrationExpertise  expertise="${param.expertise}"/>
        <n3c:registrationTherapeuticArea  therapeuticArea="${param.therapeutic}"/>
        <n3c:registrationAssistantEmail  assistantEmail="${param.assistant}"/>
        <n3c:registrationUpdatedToNow/>
    </n3c:registration>

    <c:redirect url="profile.jsp"/>
