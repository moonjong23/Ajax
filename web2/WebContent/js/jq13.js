$().ready(function(){
	$("#btn1").click(function(){ //xml
		$.ajax({
			type:"get",
			url:"jq13_1.jsp",
			dataType:"xml",
			success:function(data){
				//$("#disp").text(data);
				var str = "";
				$(data).find("person").each(function(){
					str += $(this).find("irum").text() + "&nbsp;&nbsp;";
				});
				$("#disp").append(str);
			},
			error:function(){
				$("#disp").text("에러 발생");
			},
			/*
			statusCode:{
				200:function(){
					alert("읽기 성공");
				},
				404:function(){
					alert("파일 찾기 실패");
				},
				500:function(){
					alert("파일 에러");
				},
			}
			*/
		});
	});
	
	$("#btn2").bind("click", function() { //xml - para
		var my = $.ajax({
			type:"post",
			url:"jq13_2.jsp",
			//data:"irum=" + "관우", //복수 data:"irum=" + "관우" + "&nai=" + "23", //get일때는 256자 1kb를 넘어갈 수 없다(브라우저마다 조금 다름) //post는 제한이 없다
			data:{"irum":"장비"}, //복수 data:{"irum":"장비","nai":"23"}, //자바스크립트 객체타입
			dataType:"xml",
			success:function(data){
				var str = "";
				$(data).find("person").each(function(){
					str += $(this).find("irum").text() + "&nbsp;&nbsp;";
				});
				$("#disp").append(str);
			},
		});
		
		my.fail(function(status){ //원래 $.ajax안에서 쓰지만 변수에 담았기 때문에 밖에서 쓸 수 있다
			$("#disp").text("처리 실패: " + status);
		});
	});
	
	$("#btn3").on("click", function() { //json
		$.ajax({
			type:"get",
			url:"jq13_3.jsp",
			dataType:"json",
			success:function(data){
				var str = "";
				$.each(data, function(index, entry){
					str += entry["name"] + ", " + entry.age + " "; 
				});
				$("#disp").append(str);
			},
			error:function(){
				$("#disp").text("에러 발생");
			}
		});
	});
	
	$("#btn4").on("mouseover", function() { //json - para
		$.ajax({
			type:"post",
			url:"jq13_4.jsp",
			data:{"irum":"유비", "nai":"33"},
			dataType:"json",
			success:function(data){
				var str = "";
				$.each(data, function(index, entry){
					str += entry["name"] + ", " + entry.age + " "; 
				});
				$("#disp").append(str);
			},
			error:function(){
				$("#disp").text("에러 발생");
			}
		});
	});

});




























