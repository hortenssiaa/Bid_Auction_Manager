<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>[ Bid & Auction Manager ]</title>
</head>
<body>
	<h1>[ Bid & Auction Manager ]</h1>
	<c:choose>
		<c:when test="${empty sessionScope.loginID }">
			경매는 회원만 가능합니다.	
		</c:when>
		<c:otherwise>
			<h2>${sessionScope.loginID }(${sessionScope.loginNM })님 환영합니다!</h2>	
		</c:otherwise>
	</c:choose>
	<ul>
		<li><a href="/auction/actionList">경매 참여하기</a></li>
		<li><a href="/auction/watchAuction">현재 진행중인 경매 관람</a></li>
		<c:choose>
			<c:when test="${empty sessionScope.loginID }">
				<li><a href="/member/signinForm">로그인</a></li>							
			</c:when>
			<c:otherwise>
				<li><a href="/member/myAuctionPage">나의 경매 관리</a></li>				
				<li><a href="/auction/insertProductForm">나의 경매 시작하기</a></li>				
				<li><a href="/member/logout">로그아웃</a></li>				
			</c:otherwise>
		</c:choose>
	</ul>
</body>
</html>
