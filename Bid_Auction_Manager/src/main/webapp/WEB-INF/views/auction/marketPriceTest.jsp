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
			    ["0608", "🍑"],
			    ["0611", "🥝"],
			    ["0612", "🍌"],
			    ["0644", "🍈"],
			    ["0613", "🍍"],
			    ["0614", "🍊"],
			    ["0617", "🍋"],
			    ["0618", "🍊"],
			    ["0619", "🍊"],
			    ["0627", "🍠"],
			    ["0601", "🍎"],
			    ["0602", "🍐"],
			    ["0634", "🥑"],
			    ["0603", "🍇"],
			    ["0604", "🍑"],
			    ["0636", "🥭"],
			    ["0637", "🥭"],
			    ["0638", "🥥"]
			]);
			
			let p_kind = $("#p_kind").val();
			let resultContext = "";
			
			$("#p_kind").on('change', function() {
				p_kind = $("#p_kind").val();
			});
					
			$("#checkBtn").on('click', function() {
				$("#apiTest").append("데이터를 불러오고 있습니다...");
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
						
						// 어제 시세 
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

						// 작년의 오늘시세 
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
							$.each(data, function(idx, obj)　{
 								var _items = this.response.body.items; 
								
								if(typeof(_items) != 'undefined' && _items != "") { // 데이터 있을때, item each()돌려서 확인  
									count++;
									let avgPrice = 0;
									let lenForAvg = 0;
									
									var _item = _items.item;
									
									// data 1개 있을 때 
									if (typeof(_item.length) == "undefined") {
										lenForAvg++;
										avgPrice = _item.sbidPric;											

										context += '<table border="1"><tr><th colspan="2"><h3>' + fruitMap.get(_item.stdPrdlstCode) +  _item.stdPrdlstNewNm + '</h3></th></tr>';
										context += '<tr><th>부류명</th><td>' + _item.catgoryNewNm + '</td></tr>';
										context += '<tr><th>날짜</th><td>' + _item.delngDe + '</td></tr>';
										context += '<tr><th>포장상태명</th><td>' + _item.stdFrmlcNewNm + '</td></tr>';
										context += '<tr><th>품목명</th><td>' + _item.stdPrdlstNewNm + '</td></tr>';
										context += '<tr><th>품종명</th><td>' + _item.stdSpciesNewNm + '</td></tr>';
										context += '<tr><th>단위명(예) kg)</th><td>' + _item.stdUnitNewNm + '</td></tr>';
										context += '<tr><th>거래가격(경매 낙찰가격)</th><td>' + _item.sbidPric + '원</td></tr>';
										avgPrice = (avgPrice / lenForAvg);
										// 어제 시세 
										if (yesterPriceArr.length < 0) {
											context += '<tr><th>어제의 시세(' + yesterday + ')</th><td>경매가 열리지 않았습니다</td></tr>';
										} else {
											context += '<tr><th>어제의 시세(' + yesterday + ')</th><td>' + yesterPriceArr[idx] + '원</td></tr>';
										}
										// 작년 시세 
										if (yesterPriceArr.length < 0) {
											context += '<tr><th>작년의 오늘시세(' + lasyYtoday + ')</th><td>경매가 열리지 않았습니다</td></tr></table><br><br>';
										} else {
											context += '<tr><th>작년의 오늘시세(' + lasyYtoday + ')</th><td>' + lastYMPriceArr[idx] + '원</td></tr></table><br><br>';
										}
									} else { // data 1개 이상 
										
										// item each()돌려서 확인 
										$.each(_item, function(i, o){  
											if (typeof(this) != 'undefined') {
												lenForAvg++;
												avgPrice += this.sbidPric;											
											}								
										});
										
										context += '<table border="1"><tr><th colspan="2"><h3>' + fruitMap.get(_item[0].stdPrdlstCode) + _item[0].stdPrdlstNewNm + '</h3></th></tr>';
										context += '<tr><th>부류명</th><td>' + _item[0].catgoryNewNm + '</td></tr>';
										context += '<tr><th>날짜</th><td>' + _item[0].delngDe + '</td></tr>';
										context += '<tr><th>포장상태명</th><td>' + _item[0].stdFrmlcNewNm + '</td></tr>';
										context += '<tr><th>품목명</th><td>' + _item[0].stdPrdlstNewNm + '</td></tr>';
										context += '<tr><th>품종명</th><td>' + _item[0].stdSpciesNewNm + '</td></tr>';
										context += '<tr><th>단위명(예) kg)</th><td>' + _item[0].stdUnitNewNm + '</td></tr>';
										context += '<tr><th>거래가격(경매 낙찰가격)</th><td>' + _item[0].sbidPric + '원</td></tr>';
										avgPrice = (avgPrice / lenForAvg);
										if (yesterPriceArr.length < 0) {
											context += '<tr><th>어제의 시세(' + yesterday + ')</th><td>경매가 열리지 않았습니다</td></tr>';
										} else {
											context += '<tr><th>어제의 시세(' + yesterday + ')</th><td>' + yesterPriceArr[idx] + '원</td></tr>';
										}
										// 작년 시세 
										if (yesterPriceArr.length < 0) {
											context += '<tr><th>작년의 오늘시세(' + lasyYtoday + ')</th><td>경매가 열리지 않았습니다</td></tr></table><br><br>';
										} else {
											context += '<tr><th>작년의 오늘시세(' + lasyYtoday + ')</th><td>' + lastYMPriceArr[idx] + '원</td></tr></table><br><br>';
										}
									}
						
								} 
							});
							$("#apiTest").append(context);
							
							if (count < 0) {
								context += '<h2>' + '오늘은 경매가 열리지 않아 데이터가 존재하지 않습니다.' + '</h2>';
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
		<option value="06">과실류</option>
	</select>
	<select id="p_kind" name="p_kind">
		<option value="전체보기">전체보기</option>
		<option value="608">자두</option>
		<option value="611">참다래(키위)</option>
		<option value="612">바나나</option>
		<option value="644">듀리안</option>
		<option value="613">파인애플</option>
		<option value="614">감귤</option>
		<option value="617">레몬</option>
		<option value="618">오렌지</option>
		<option value="619">자몽</option>
		<option value="627">무화과</option>
		<option value="601">사과</option>
		<option value="602">배</option>
		<option value="634">아보카도</option>
		<option value="603">포도</option>
		<option value="604">복숭아</option>
		<option value="636">망고</option>
		<option value="637">망고스턴</option>
		<option value="638">코코넛</option>
	</select>
	<input type="text" placeholder="검색하기 (예) 아보카도)">
	<input type="button" id="checkBtn" value="검색하기"> <br><br>
	
	<div id="apiTest"></div>
	<br> <br>
</body>
</html>