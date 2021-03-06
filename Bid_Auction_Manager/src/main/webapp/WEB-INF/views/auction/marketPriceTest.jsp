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
			const fruitMap = new Map([
			    ["0608", "π"],
			    ["0611", "π₯"],
			    ["0612", "π"],
			    ["0644", "π"],
			    ["0613", "π"],
			    ["0614", "π"],
			    ["0617", "π"],
			    ["0618", "π"],
			    ["0619", "π"],
			    ["0627", "π "],
			    ["0601", "π"],
			    ["0602", "π"],
			    ["0634", "π₯"],
			    ["0603", "π"],
			    ["0604", "π"],
			    ["0636", "π₯­"],
			    ["0637", "π₯­"],
			    ["0638", "π₯₯"]
			]);
			
			let p_kind = $("#p_kind").val();
			let resultContext = "";
			
			$("#p_kind").on('change', function() {
				p_kind = $("#p_kind").val();
			});
					
			$("#checkBtn").on('click', function() {
				$("#apiTest").append("λ°μ΄ν°λ₯Ό λΆλ¬μ€κ³  μμ΅λλ€...");
				$.ajax({
					url : '/getPrice',
					type : 'post',
					data : {
						p_kind : p_kind
					},
					dataType : 'json',
					success : function(data) {
						let yesterPriceArr = [];
						let yesterday = "";
						let yesterdatMPrice = 0;
						let yesterdatMPrice_len = 0;

						let lastYMPriceArr = [];
						let lasyYtoday = "";
						let lastYMPrice = 0;
						let lastYMPrice_len = 0;
						
						// μ΄μ  μμΈ 
						$.ajax({
							url : '/getYTDayPrice',
							type : 'post',
							async: false,
							data : {
								p_kind : p_kind
							},
							dataType : 'json',
							success : function(data1) {

								let tempPrice = 0;
								$.each(data1, function (idx, obj) {
									
									let _items = this.response.body.items;
									if(typeof(_items) != 'undefined' && _items != "") {
										tempPrice = 0;
										yesterdatMPrice = 0;
										$.each(_items.item, function(i, o) {
											if (typeof(this) != 'undefined' && typeof(_items.item.length) != "undefined") {
												yesterdatMPrice_len = _items.item.length;
												tempPrice += parseInt(_items.item[i].sbidPric);
												yesterday = _items.item[0].delngDe;	
											}										
										});
										if (typeof(yesterdatMPrice) != "NaN") {
											yesterdatMPrice = (parseInt(tempPrice) / yesterdatMPrice_len);
										}
									}
									yesterPriceArr[idx] = yesterdatMPrice;
								});
							}, error : function(e) {
								console.log(e);
							}
						});

						// μλμ μ€λμμΈ 
						$.ajax({
							url : '/getLastYTodayPrice',
							type : 'post',
							async: false,
							data : {
								p_kind : p_kind
							},
							dataType : 'json',
							success : function(data1) {
								let tempPrice = 0;
								$.each(data1, function (idx, obj) {
									let _items = this.response.body.items;
									if(typeof(_items) != 'undefined' && _items != "") {
										tempPrice = 0;
										lastYMPrice = 0;
										$.each(_items.item, function(i, o) {
											if (typeof(this) != 'undefined' && typeof(_items.item.length) != "undefined") {
												lastYMPrice_len = _items.item.length;
												tempPrice += parseInt(_items.item[i].sbidPric);
												lasyYtoday = _items.item[0].delngDe;	
											}										
										});
										if (typeof(lastYMPrice) != "NaN") {
											lastYMPrice = (parseInt(tempPrice) / lastYMPrice_len);
										}
									}
									lastYMPriceArr[idx] = lastYMPrice;
								});
							}, error : function(e) {
								console.log(e);
							}
						});
						
						var context = '';
						var count = -1;
							
							$("#apiTest").html("");
							$.each(data, function(idx, obj)γ{
 								var _items = this.response.body.items; 
								
								if(typeof(_items) != 'undefined' && _items != "") { // λ°μ΄ν° μμλ, item each()λλ €μ νμΈ  
									count++;
									let avgPrice = 0;
									let lenForAvg = 0;
									
									var _item = _items.item;
									
									// data 1κ° μμ λ 
									if (typeof(_item.length) == "undefined") {
										lenForAvg++;
										avgPrice = _item.sbidPric;											

										context += '<table border="1"><tr><th colspan="2"><h3>' + fruitMap.get(_item.stdPrdlstCode) +  _item.stdPrdlstNewNm + '</h3></th></tr>';
										context += '<tr><th>λΆλ₯λͺ</th><td>' + _item.catgoryNewNm + '</td></tr>';
										context += '<tr><th>λ μ§</th><td>' + _item.delngDe + '</td></tr>';
										context += '<tr><th>ν¬μ₯μνλͺ</th><td>' + _item.stdFrmlcNewNm + '</td></tr>';
										context += '<tr><th>νλͺ©λͺ</th><td>' + _item.stdPrdlstNewNm + '</td></tr>';
										context += '<tr><th>νμ’λͺ</th><td>' + _item.stdSpciesNewNm + '</td></tr>';
										context += '<tr><th>λ¨μλͺ(μ) kg)</th><td>' + _item.stdUnitNewNm + '</td></tr>';
										context += '<tr><th>κ±°λκ°κ²©(κ²½λ§€ λμ°°κ°κ²©)</th><td>' + _item.sbidPric + 'μ</td></tr>';
										avgPrice = (avgPrice / lenForAvg);
										// μ΄μ  μμΈ 
										if (yesterPriceArr.length < 0) {
											context += '<tr><th>μ΄μ μ μμΈ(' + yesterday + ')</th><td>κ²½λ§€κ° μ΄λ¦¬μ§ μμμ΅λλ€</td></tr>';
										} else {
											context += '<tr><th>μ΄μ μ μμΈ(' + yesterday + ')</th><td>' + yesterPriceArr[idx] + 'μ</td></tr>';
										}
										// μλ μμΈ 
										if (yesterPriceArr.length < 0) {
											context += '<tr><th>μλμ μ€λμμΈ(' + lasyYtoday + ')</th><td>κ²½λ§€κ° μ΄λ¦¬μ§ μμμ΅λλ€</td></tr></table><br><br>';
										} else {
											context += '<tr><th>μλμ μ€λμμΈ(' + lasyYtoday + ')</th><td>' + lastYMPriceArr[idx] + 'μ</td></tr></table><br><br>';
										}
									} else { // data 1κ° μ΄μ 
										
										// item each()λλ €μ νμΈ 
										$.each(_item, function(i, o){  
											if (typeof(this) != 'undefined') {
												lenForAvg++;
												avgPrice += this.sbidPric;											
											}								
										});
										
										context += '<table border="1"><tr><th colspan="2"><h3>' + fruitMap.get(_item[0].stdPrdlstCode) + _item[0].stdPrdlstNewNm + '</h3></th></tr>';
										context += '<tr><th>λΆλ₯λͺ</th><td>' + _item[0].catgoryNewNm + '</td></tr>';
										context += '<tr><th>λ μ§</th><td>' + _item[0].delngDe + '</td></tr>';
										context += '<tr><th>ν¬μ₯μνλͺ</th><td>' + _item[0].stdFrmlcNewNm + '</td></tr>';
										context += '<tr><th>νλͺ©λͺ</th><td>' + _item[0].stdPrdlstNewNm + '</td></tr>';
										context += '<tr><th>νμ’λͺ</th><td>' + _item[0].stdSpciesNewNm + '</td></tr>';
										context += '<tr><th>λ¨μλͺ(μ) kg)</th><td>' + _item[0].stdUnitNewNm + '</td></tr>';
										context += '<tr><th>κ±°λκ°κ²©(κ²½λ§€ λμ°°κ°κ²©)</th><td>' + _item[0].sbidPric + 'μ</td></tr>';
										avgPrice = (avgPrice / lenForAvg);
										if (yesterPriceArr.length < 0) {
											context += '<tr><th>μ΄μ μ μμΈ(' + yesterday + ')</th><td>κ²½λ§€κ° μ΄λ¦¬μ§ μμμ΅λλ€</td></tr>';
										} else {
											context += '<tr><th>μ΄μ μ μμΈ(' + yesterday + ')</th><td>' + yesterPriceArr[idx] + 'μ</td></tr>';
										}
										// μλ μμΈ 
										if (yesterPriceArr.length < 0) {
											context += '<tr><th>μλμ μ€λμμΈ(' + lasyYtoday + ')</th><td>κ²½λ§€κ° μ΄λ¦¬μ§ μμμ΅λλ€</td></tr></table><br><br>';
										} else {
											context += '<tr><th>μλμ μ€λμμΈ(' + lasyYtoday + ')</th><td>' + lastYMPriceArr[idx] + 'μ</td></tr></table><br><br>';
										}
									}
						
								} 
							});
							$("#apiTest").append(context);
							
							if (count < 0) {
								context += '<h2>' + 'μ€λμ κ²½λ§€κ° μ΄λ¦¬μ§ μμ λ°μ΄ν°κ° μ‘΄μ¬νμ§ μμ΅λλ€.' + '</h2>';
								$("#apiTest").html(context);
							}
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
	<h1>[ Market Price Page ]</h1>
	
	<select id="p_category_code">
		<option value="06">κ³Όμ€λ₯</option>
	</select>
	<select id="p_kind" name="p_kind">
		<option value="μ μ²΄λ³΄κΈ°">μ μ²΄λ³΄κΈ°</option>
		<option value="608">μλ</option>
		<option value="611">μ°Έλ€λ(ν€μ)</option>
		<option value="612">λ°λλ</option>
		<option value="644">λλ¦¬μ</option>
		<option value="613">νμΈμ ν</option>
		<option value="614">κ°κ·€</option>
		<option value="617">λ λͺ¬</option>
		<option value="618">μ€λ μ§</option>
		<option value="619">μλͺ½</option>
		<option value="627">λ¬΄νκ³Ό</option>
		<option value="601">μ¬κ³Ό</option>
		<option value="602">λ°°</option>
		<option value="634">μλ³΄μΉ΄λ</option>
		<option value="603">ν¬λ</option>
		<option value="604">λ³΅μ­μ</option>
		<option value="636">λ§κ³ </option>
		<option value="637">λ§κ³ μ€ν΄</option>
		<option value="638">μ½μ½λ</option>
	</select>
	<input type="text" placeholder="κ²μνκΈ° (μ) μλ³΄μΉ΄λ)">
	<input type="button" id="checkBtn" value="κ²μνκΈ°"> <br><br>
	
	<div id="apiTest"></div>
	<br> <br>
</body>
</html>