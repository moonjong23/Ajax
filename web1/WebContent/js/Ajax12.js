var xhr;
var para;
var checkFirst = loopSend = false;
var lastKeyword = "";


function listdown(){
	//alert("aa");
	if(checkFirst == false){
		setTimeout("sendKeyword()",1000);
		loopSend = true;
	}
}

function sendKeyword(){
	if(loopSend == false) return;
	
	var key = document.frm.ibsanyun.value; // document.폼이름.인풋텍스트이름.value
	//console.log(key);
	
	if(key == ""){
		lastKeyword = "";
		hide("suggest");
	}else if(key != lastKeyword){
		lastKeyword = key;
		
		if(key != ""){
			para ="ibsaDay=" + key;
			//alert(para);
			startXhr();
		}else{
			hide("suggest");
		}
	}
	setTimeout("sendKeyword()", 1000);
}

function startXhr(){
	xhr = new XMLHttpRequest();
	xhr.open("post", "Ajax12_xml.jsp", true);
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4){
			if(xhr.status == 200){
				suggest();
			}else{
				alert("post 요청 실패: " + xhr.status);
			}
		}
	}
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr.send(para);	
}
function changeXhr(aaa){
	var v = aaa.value;
	//alert(v);
	xhr = new XMLHttpRequest();
	xhr.open("post", "Ajax12_xml(2).jsp", true);
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4){
			if(xhr.status == 200){
				process();
			}else{
				alert("post 요청 실패: " + xhr.status);
			}
		}
	}
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr.send("name=" + v);	
}

function suggest(){
	var data = xhr.responseXML;
	//alert(data);
	var sawonNode = data.getElementsByTagName("sawon");
	var ibsayearNode = data.getElementsByTagName("ibsayear");
	var yearbefore = "";
	var str = "";
	for (var i = 0; i < sawonNode.length; i++) {
		var ibsaNode = ibsayearNode[i].childNodes[0].nodeValue;
		if((i == 0) ||(yearbefore != ibsaNode)){ //년도 중복배제
			str+= "<a href=\"javascript:selectbox('"+ ibsaNode + "')\">" + ibsaNode +"</a><br>";
			yearbefore = ibsaNode;
		}
	}
	document.getElementById("suggest").innerHTML = str;
}

function selectbox(d){
	//alert(d); //년도
	
	var data = xhr.responseXML;
	var sawonNode = data.getElementsByTagName("sawon");
	var sawon_nameNode = data.getElementsByTagName("sawon_name");
	var ibsayearNode = data.getElementsByTagName("ibsayear");
	var str = "";
		str += "<option>선택하세요.</option>";
	for (var i = 0; i < sawonNode.length; i++) {
		if(ibsayearNode[i].childNodes[0].nodeValue == d){
			str+= "<option value='"+ sawon_nameNode[i].childNodes[0].nodeValue + "'>";
			str+= sawon_nameNode[i].childNodes[0].nodeValue;
			str+= "</option>";	
		}
	}
	document.getElementById("sel").innerHTML= str;		
}

function process(){
	//alert("process");
	
	var data = xhr.responseXML;
	//alert(data);
	var gogekNode = data.getElementsByTagName("gogek");
	var gogek_noNode = data.getElementsByTagName("gogek_no");
	var gogek_nameNode = data.getElementsByTagName("gogek_name");
	var gogek_telNode = data.getElementsByTagName("gogek_tel");
	var gogek_juminNode = data.getElementsByTagName("gogek_jumin");

	
	var str = "<table border='1'>";
	str += "<tr><td>고객번호</td><td>고객이름</td><td>주민번호</td><td>고객전화</td></tr>";
	for (var i = 0; i < gogekNode.length; i++) {
		str +="<tr>";
		str+="<td>" + gogek_noNode[i].childNodes[0].nodeValue + "</td>";
		str+="<td>" + gogek_nameNode[i].childNodes[0].nodeValue + "</td>";
		str+="<td>" + gogek_telNode[i].childNodes[0].nodeValue + "</td>";
		str+="<td>" + gogek_juminNode[i].childNodes[0].nodeValue + "</td>";
		str +="<tr>";
	}
	str+="</table>";
	document.getElementById("disp").innerHTML = str;
}





















