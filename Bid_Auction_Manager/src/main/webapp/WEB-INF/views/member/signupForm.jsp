<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>[ SignUp Form ]</title>
	<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
	<script type="text/javascript">
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
	<h1>[ SignUp Form ]</h1>
	<form action="/member/signup" method="post" onsubmit="return checkForm();">
		<table border="1">
			<tr>
				<th>ID</th>
				<td> 
					<input type="text" name="member_id" id="member_id"> 
					<input type="button" id="idCheckBtn" value="중복검사">
				</td>
			</tr>
			<tr>
				<th>password</th>
				<td> <input type="password" name="member_pw" id="member_pw"> </td>
			</tr>
			<tr>
				<th>이름</th>
				<td> <input type="text" name="member_nm" id="member_nm"> </td>
			</tr>
			<tr>
				<th>번호</th>
				<td> <input type="tel" name="member_phone" id="member_phone"> </td>
			</tr>
			<tr>
				<th>이메일</th>
				<td> <input type="email" name="member_email" id="member_email"> </td>
			</tr>
			<tr>
				<th>성별</th>
				<td> 
					<input type="radio" name="member_gender" value="1">남 
					<input type="radio" name="member_gender" value="2">여 
				</td>
			</tr>			
			<tr>
				<th>프로필사진</th>
				<td>
					<input type="radio" id="profile1" name="member_profile" value="1" checked>
					<label for="profile1"><img alt="profile1"  src="/resources/img/pro_test1.png"></label>
					<input type="radio" id="profile2" name="member_profile" value="2">
					<label for="profile2"><img alt="profile2"  src="/resources/img/pro_test2.png"></label>
					<input type="radio" id="profile3" name="member_profile" value="3">
					<label for="profile3"><img alt="profile3"  src="/resources/img/pro_test4.png"></label>
					<input type="radio" id="profile4" name="member_profile" value="4">
					<label for="profile4"><img alt="profile4"  src="/resources/img/pro_test5.png"></label>
				</td>
			</tr>			
			<tr>
				<th colspan="2">
					<input type="submit" value="회원가입"><br>
					<a href="/member/signinForm">로그인 하러가기</a>
				</th>
			</tr>
		</table>
	</form>
</body>
</html>