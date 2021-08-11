<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>[ Market Price Test ]</title>
	<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
	<script type="text/javascript">
		$(function(){
			let p_kind = '0614';
			
			$("#checkBtn").on('click', function() {
				$.ajax({
					url : '/getPrice',
					type : 'get',
					/* date : {
						p_kind : p_kind
					}, */
					dataType : 'json',
					success : function(data) {
						let myItem = data.response.body.items.item;
						//console.log(myItem); 
						//console.log(myItem.length);
						
						let context = "";
						let avgPrice = 0;
						
						$.each(myItem, function(idx, obj) {
							
							/* context += '<h2>' + (idx + 1) + '</h2>';
							context += '부류명 : ' + this.catgoryNewNm + '<br>';
							context += '부류코드명 : ' + this.catgoryNewCode + '<br>';
							context += '법인명 : ' + this.insttNewNm + '<br>';
							context += '포장상태명 : ' + this.stdFrmlcNewNm + '<br>';
							context += '품목명 : ' + this.stdPrdlstNewNm + '<br>';
							//context += '구품목명 : ' + this.stdPrdlstNm + '<br>';
							context += '등급명 : ' + this.stdQlityNewNm + '<br>';
							context += '품종명 : ' + this.stdSpciesNewNm + '<br>';
							//context += '구품종명 : ' + this.stdSpciesNm + '<br>';
							context += '단위명(예) kg) : ' + this.stdUnitNewNm + '<br>';
							context += '거래가격(경매 낙찰가격) : ' + this.sbidPric + '<br>';
							context += '시장명 : ' + this.whsalMrktNewNm + '<br><br><br>'; */
							
							avgPrice += this.sbidPric;
						});
				
						avgPrice = (avgPrice / myItem.length);
				
						$("#apiTest").html(context);
						$("#apiTest").append('평균시세 : ' + parseInt(avgPrice) + '원<br><br>');
						
						/* let jsonObject = JSON.stringify(myItem);
						console.log(jsonObject.length);
						console.log(jsonObject);
						
						$("#apiTest").text(jsonObject); */
						
						//$("#apiTest").text(data);
					},
					error : function(e) {
						console.log("error : " + e);
					}
				});
			});
		});
	</script>
</head>
<body>
	<h1>[ Market Price API Test ]</h1>
	
	<input type="button" id="checkBtn" value="확인하기">
	<div id="apiTest"></div>
</body>
</html>