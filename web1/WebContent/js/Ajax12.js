var xhr1, xhr2;
var para;
var loopSend = false;
var lastKeyword = "";
var ibsayearNode;


function listdown(){
	//alert("aa");
		setTimeout("sendKeyword()",1000);
		loopSend = true;
}

function sendKeyword(){
	if(loopSend == false) return;
	
	var key = document.frm.ibsanyun.value; // document.폼이름.인풋텍스트이름.value
	//console.log(key);
	
	if(key == ""){
		lastKeyword = "";
	}else if(key != lastKeyword){
		lastKeyword = key;
		
		if(key != ""){
			para ="ibsaDay=" + key;
			//alert(para);
			startXhr();
		}else{
			
		}
	}
	setTimeout("sendKeyword()", 1000);
}

function startXhr(){
	xhr1 = new XMLHttpRequest();
	xhr1.open("post", "Ajax12_xml.jsp", true);
	xhr1.onreadystatechange = function(){
		if(xhr1.readyState == 4){
			if(xhr1.status == 200){
				suggest();
			}else{
				alert("post 요청 실패: " + xhr.status);
			}
		}
	}
	xhr1.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr1.send(para);	
}
function changeXhr(aaa){
	var v = aaa.value;
	//alert(v);
	xhr2 = new XMLHttpRequest();
	xhr2.open("post", "Ajax12_xml(2).jsp", true);
	xhr2.onreadystatechange = function(){
		if(xhr2.readyState == 4){
			if(xhr2.status == 200){
				process();
			}else{
				alert("post 요청 실패: " + xhr.status);
			}
		}
	}
	xhr2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr2.send("name=" + v);	
}

function suggest(){
	var data = xhr1.responseXML;
	//alert(data);
	var sawonNode = data.getElementsByTagName("sawon");
	ibsayearNode = data.getElementsByTagName("ibsayear");
	var yearbefore = "";
	var str = "";
	for (var i = 0; i < sawonNode.length; i++) {
		if((i == 0) ||(yearbefore !=  ibsayearNode[i].childNodes[0].nodeValue)){ //년도 중복배제
			str+= "<a href=\"javascript:selectbox('"+ ibsayearNode[i].childNodes[0].nodeValue + "')\">" 
						+  ibsayearNode[i].childNodes[0].nodeValue +"</a><br>";
			yearbefore =  ibsayearNode[i].childNodes[0].nodeValue;
		}
	}
	document.getElementById("suggest").innerHTML = str;
}

function selectbox(d){
	alert(d); //입사년도
	
	var data = xhr1.responseXML;
	var sawonNode = data.getElementsByTagName("sawon");
	var sawon_nameNode = data.getElementsByTagName("sawon_name");
	ibsayearNode = data.getElementsByTagName("ibsayear");
	var str = "";
		str += "<option>선택하세요.</option>";
		alert(sawonNode.length);
	for (var i = 0; i < sawonNode.length; i++) {
		if(ibsayearNode[i].childNodes[0].nodeValue == d){
			str+= "<option value='"+ sawon_nameNode[i].childNodes[0].nodeValue + "'>";
			str+= sawon_nameNode[i].childNodes[0].nodeValue;
			str+= "</option>";	
		}
	}
	alert(str);
	document.getElementById("sel").innerHTML= str;		
}

function process(){
	//alert("process");
	
	var data = xhr2.responseXML;
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

