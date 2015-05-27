<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ include file="/include/tags.jspf"
%><!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jspf"%>
</head>
<body>
	<%@ include file="/include/top.jspf"%>
	
	<c:choose>
    <c:when test="${question.questionId == 0}">
    	<c:set value="/questions" var="urlPath" scope="request"/>
    </c:when>
    <c:otherwise>
     	<c:set value="/questions/${question.questionId}" var="urlPath" scope="request"/>
    </c:otherwise>
    </c:choose>

	<div id="main">
		<form:form modelAttribute="question" action="${urlPath}" method="post">
			<form:hidden path="questionId"/>
			<table>
				<tr>
					<td width="150">글쓴이</td>
					<td>
						<form:input path="writer" size="40"/>
						<form:errors path="writer" cssClass="error" />
					</td>
				</tr>			
				<tr>
					<td width="150">제목</td>
					<td>
						<form:input path="title" size="70"/>
						<form:errors path="title" cssClass="error" />					
					</td>
				</tr>
				<tr>
					<td width="150">내용</td>
					<td>
						<form:textarea path="contents" rows="5" cols="130"/>
						<form:errors path="contents" cssClass="error" /></td>
				</tr>
			</table>
			<input type="submit" value="질문하기" />			
		</form:form>
	</div>
</body>
</html>