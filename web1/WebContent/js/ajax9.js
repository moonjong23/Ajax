
var xhr

function Play(g){
	//alert("play: " + g);
	var gen = g.id;
	//alert(gen);
	
	if(document.all.RR[0].checked == true){
		//alert("XML누름");
		xhr = new XMLHttpRequest();
		xhr.open("post", "ajax9_xml.jsp", true);
		first(gen);
	}else if(document.all.RR[1].checked == true ){
		//alert("JSON누름");
		xhr = new XMLHttpRequest();
		xhr.open("post", "ajax9_json.jsp", true);
		first(gen);
	}
}

function first(id){
	//alert("first로 감");
	var gen = id;
	//alert("frist의 gen값: "+gen);
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4){
			if(xhr.status == 200){
				if(document.all.RR[0].checked == true){
					XML();
				}else if(document.all.RR[1].checked == true){
					JSON();
				}						
			}else{
				alert("post 요청 실패: " + xhr.status);
			}
		}
	}
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr.send("gen=" + gen);
	//alert(gen);
}

function XML(){
	var data = xhr.responseXML;
	//alert(data);
	var gogekNode = data.getElementsByTagName("gogek");
	var gogek_nameNode = data.getElementsByTagName("gogek_name");
	var gogek_telNode = data.getElementsByTagName("gogek_tel");
	var genNode = data.getElementsByTagName("gen");
	var sawon_nameNode = data.getElementsByTagName("sawon_name");
	var buser_telNode = data.getElementsByTagName("buser_tel");
	
	var str = "<table border='1'>";
	str += "<tr><td>고객명</td><td>고객번호</td><td>성별</td><td>담당사원</td><td>부서번호</td></tr>"
	for(var i = 0; i < gogekNode.length; i++){
		str +="<tr style='background-color:black; color:white''>";
		str +="<td>" +gogek_nameNode[i].childNodes[0].nodeValue + "</td>";
		str +="<td>" +gogek_telNode[i].childNodes[0].nodeValue + "</td>";
		str +="<td>" +genNode[i].childNodes[0].nodeValue + "</td>";
		str +="<td>" +sawon_nameNode[i].childNodes[0].nodeValue + "</td>";
		str +="<td>" +buser_telNode[i].childNodes[0].nodeValue + "</td>";
		str +="<tr>";
	}
	str+="</table>";
	document.getElementById("Show").innerHTML = str;
}

function JSON(){
	//alert("process까지 감");
	var data = xhr.responseText;
	//alert(data);
	var parseData = eval("("+data+")"); //JSON.parse(data) 버그
	//alert(parseData);
	var str = "<table border='1'>";
	str += "<tr><td>고객명</td><td>고객번호</td><td>성별</td><td>담당사원</td><td>부서번호</td></tr>"
	for(var i = 0; i < parseData.gogeks.length; i++){
		str+= "<tr style='background-color:blue; color:orange'>";
		str+= "<td>" + parseData.gogeks[i].gogek_name + "</td>" +
			"<td>" + parseData.gogeks[i].gogek_tel + "</td>" +
			"<td>" + parseData.gogeks[i].gen + "</td>" +
			"<td>" + parseData.gogeks[i].sawon_name + "</td>" +
			"<td>" + parseData.gogeks[i].buser_tel + "</td>";
		str += "</tr>"
	}
	str += "</table>";	
	document.getElementById("Show").innerHTML = str;	
}

function Out(){
	//alert("마우스 나감");
	str = null;
	document.getElementById("Show").innerHTML = str;
	
}







