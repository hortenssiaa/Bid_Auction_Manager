<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>[ SignIn Form ]</title>
	<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
	<script type="text/javascript">
	$(function() {
		$("#signinBtn").on('click', function() {
			let member_id = $("#member_id").val();
			let member_pw = $("#member_pw").val();
			$.ajax({
				url : "/member/signin",
				type : "post",
				data : {
					member_id : member_id,
					member_pw : member_pw
				},
				//dataType : "text",
				// dataType 이 필요한 경우 : Json 은, arrylist, hashmap 과 같이 js에 없는 데이터 타입을 받을때 사용하는것이다.
				// 지금과 같은 VO 하나만 받을 경우는, dataType 안써도됨!!
				success : function(data) {
					if (data == true) {
						location.replace("/");
					} else {
						alert("아이디 또는 비밀번호가 틀립니다.");
						location.replace("signinForm");
					}
				},
				error : function(e) {
					alert("아이디 또는 비밀번호가 틀립니다.");
					console.log(e);
				}
			})
		});
	});
	
		function checkForm() {
			return true;
		}
	</script>
	<style type="text/css">
		img {
			width: 80px;
			height: 80px;
		}
		
		form {
			padding: 18px;
		}
		
		/* table {
			border: 1px solid black;
		} */
	</style>
</head>
<body>
	<h1>[ SignIn Form ]</h1>
	<form id="signinForm">
		<table border="1">
			<tr>
				<th>ID</th>
				<td> <input type="text" name="member_id" id="member_id"> </td>
			</tr>
			<tr>
				<th>password</th>
				<td> <input type="password" name="member_pw" id="member_pw"> </td>
			</tr>		
			<tr>
				<th colspan="2">
					<input type="button" id="signinBtn" value="로그인"> <br>
					<a href="/member/signupForm">회원가입 하러가기</a>
				</th>
			</tr>
		</table>
	</form>
</body>
</html>