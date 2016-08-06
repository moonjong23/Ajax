var xhryear, xhrstaff, xhrcustomer;
var checkFirst = loopSend = false;
var lastKeyword = "";

function start(){
	if(checkFirst == false){
		setTimeout("sendKeyword()", 1000);
		loopSend = true;
	}
}
function sendKeyword(){
	if(loopSend == false) return;
	var keyWord = document.frm.keyword.value;
	//console.log(keyWord);
	if(keyWord == ""){
		lastKeyword = "";
		hide("suggest");
	}else if(keyWord != lastKeyword){
		lastKeyword = keyWord;
		if(keyWord != ""){
			var para = "keyword=" + keyWord;
			xhryear = new XMLHttpRequest();
			xhryear.open("post","ajaxLast_exjsonyear.jsp", true);
			xhryear.onreadystatechange = function(){
				if(xhryear.readyState == 4){
					if(xhryear.status == 200){
						process();
						
					}else{
						alert("요청실패:"  + xhr.status);
					}
				}	
			}
			xhryear.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			xhryear.send(para);
			}else{
			hide("suggest");
			
		}
	}
	setTimeout("sendKeyword()", 1000);
}
function process(){
	var Data = xhryear.responseText;
	var parseData = JSON.parse(Data);
	var str = "";
	for (var i = 0; i < parseData.years.length; i++) {
		str += "<a href=\"javascript:func('" + parseData.years[i].year + "')\">" + parseData.years[i].year  + "</a><br/>"
	}
	document.getElementById("suggest").innerHTML = str;
	show("suggest");
}
function func(data){
	xhrstaff = new XMLHttpRequest();
	xhrstaff.open("post","ajax_Lastexjsonstaff.jsp", true);
	xhrstaff.onreadystatechange = function(){
		if(xhrstaff.readyState == 4){
			if(xhrstaff.status == 200){
					var datastaff = xhrstaff.responseText;
					var parseData = JSON.parse(datastaff);
					var str = "";
						str+="직원명:"
						str+="<select id='sel' onChange='dispCustomer(this.value)'>";
						str+= "<option selected>사원명</option>";
					for (var i = 0; i < parseData.staffs.length; i++) {
						str+= "<option value= '" + parseData.staffs[i].staff + "' >" +parseData.staffs[i].staff + "</option>";
					}
					str+="</select>";
					document.getElementById("selbox").innerHTML = str;
					
					
			}else{
				alert("요청실패:"  + xhrstaff.status);
			}
		}	
	}
	xhrstaff.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	xhrstaff.send("year=" + data);
}
function dispCustomer(data){
	var staffdata = "staff=" + data;
	xhrcustomer = new XMLHttpRequest();
	xhrcustomer.open("post","ajax_Lastexjsoncustomer.jsp", true);
	xhrcustomer.onreadystatechange = function(){
		if(xhrcustomer.readyState == 4){
			if(xhrcustomer.status == 200){
					var datacustomer = xhrcustomer.responseText;
					var parseData = JSON.parse(datacustomer);
					if(parseData.customers.length == 0){
						document.getElementById("show").innerHTML = "담당 고객이 없습니다.";
					}else{
					var str = "<table>";
					str += "<tr><th>고객번호</th><th>고객명</th><th>주민번호</th><th>고객전화</th></tr>";
					
					for (var i = 0; i < parseData.customers.length; i++) {
						str += "<tr><td>" + parseData.customers[i].no + "</td>" + 
						"<td>" + parseData.customers[i].name + "</td>" +
						"<td>" + parseData.customers[i].jumin + "</td>" +
						"<td>" + parseData.customers[i].tel + "</td>" +
						"</tr>";
					}
					str += "</table>"
					document.getElementById("show").innerHTML = str;
					}	
			}else{
				alert("요청실패:"  + xhrcustomer.status);
			}
		}	
	}
	xhrcustomer.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	xhrcustomer.send(staffdata);
	
}
function hide(ele){
	var e = document.getElementById(ele);
	if(e) e.style.display = "none";
}
function show(ele){
	var e = document.getElementById(ele);
	if(e) e.style.display = "";
}

