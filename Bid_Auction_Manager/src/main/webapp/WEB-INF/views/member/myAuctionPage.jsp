<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>[ myAuctionPage ]</title>
	<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
	<style type="text/css">
		.product__container {
			margin-bottom: 30px;
		}
	</style>
</head>
<body>
	<h1>[ My Auction Page ]</h1>
	
	
	<c:forEach var="product" items="${productList }">
		<div class="product__container">
			<div>
				<img alt="productImage${product.p_num }" src="/resources/img/pro_test2.png">
			</div>
			<div>
				상품 <br>
				${product.p_name } <br>
				종류 <br>
				${product.p_kind } <br>
				경매 참가인원 <br>
				소켓 - 
				(${product.current_party }/ ${product.max_party }) <br>
				상품 등록일 <br>
				${product.p_indate } <br>
			</div>
			<div>
				<input type="button" value="참가하기">
			</div>
		</div>
	</c:forEach>
</body>
</html>