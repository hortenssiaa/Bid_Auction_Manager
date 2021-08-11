<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>[ Write Product Form ]</title>
	<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
	<script type="text/javascript">
		$(function() {
			let p_min_price = $("#op_options option:selected").val();
			$("#op_options").on("change", function() {
				p_min_price = $("#op_options option:selected").val();	
				
				if (p_min_price == "직접입력") {
					$("#p_min_price").remove();
					$("#op_updown_select").after("<input type=\"text\" name=\"p_min_price\" size=\"3\" id=\"p_min_price\">");
				} else if (p_min_price == "시세로 설정") {
					// 후에 api 시세로 설정!! 
					$("#op_updown_select").after("<input type=\"hidden\" name=\"p_min_price\" size=\"3\" id=\"p_min_price\" value=\"33\">");
				} else {
					$("#p_min_price").remove();
				}
			});

			let max_party = $("#max_party").val();
			$("#max_party").on('change', function() {
				max_party = $("#max_party").val();
				if (max_party > 50) { 
					alert("최대인원은 50명 이하입니다.");
					$("#max_party").focus().val("");
				}				
			});
		});
		
		function checkForm() {
			let p_min_price = $("#op_options option:selected").val();
			if (p_min_price == "직접입력" || p_min_price == "선택해주세요") {
				alert("최저가격 % 를 선택해주세요");
				return false;
			}
			
			// 유효성 검사
			
		
			return true;
			
			
		}
	</script>
</head>
<body>
	<h1>[ 경매상품 등록하기 ]</h1>
	
	<form action="/product/insertProduct" method="post" onsubmit="return checkForm();">
		<input type="hidden" name="member_id" value="${sessionScope.loginID }">
		<table border="1">
			<tr>
				<th>상품이름</th>
				<td><input type="text" name="p_name" id="p_name" size="50" placeholder="상품명을 입력해주세요."></td>
			</tr>
			<tr>
				<th>상품종류</th>
				<td>
					<input type="radio" name="p_kind" id="p_kind1" value="1" checked>
					<label for="p_kind1">배추</label>
					<input type="radio" name="p_kind" id="p_kind2" value="2">
					<label for="p_kind2">양파</label>
					<input type="radio" name="p_kind" id="p_kind3" value="3">
					<label for="p_kind3">가지</label>
					<input type="radio" name="p_kind" id="p_kind4" value="4">
					<label for="p_kind4">호박</label>
				</td>
			</tr>
			<tr>
				<th>최저가격제시 <br> (경매시 판매자에게만 보입니다) <br> 시세의 %  </th>
				<td>
					
					<select id="op_updown_select" name="p_min_price_op">
						<option id="op_up" value="+">▲</option>
						<option id="op_down" value="-">▼</option>
					</select>
					<select id="op_options" name="p_min_price">
						<option id="op_default" value="0">선택해주세요</option>
						<option id="op_5" value="5">5</option>
						<option id="op_10" value="10">10</option>
						<option id="op_15" value="15">15</option>
						<option id="op_20" value="20">20</option>
						<option id="op_25" value="25">25</option>
						<option id="op_30" value="30">30</option>
						<option id="op_uptoyou">직접입력</option>
						<option id="op_choosebydata">시세로 설정</option>
					</select>
					%
				</td>
			</tr>
			<tr>
				<th>최대 인원 <br> ❉ 최대인원은 50명 이하입니다. </th>
				<td>
					<input type="number" name="max_party" id="max_party" placeholder="예) 30"> 명
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="button" value="상품시세확인">
					<input type="submit" value="상품등록">
				</th>
			</tr>
		</table>
	</form>
</body>
</html>