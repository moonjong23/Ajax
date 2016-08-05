var xhr;
var checkFirst = loopSend = false;
var lastKeyword = "";


function sijak1(){
	
	if(checkFirst == false){
	setTimeout("sendKeyword()", 1000);
	loopSend = true;
	}
}

function sendKeyword(){
	if(loopSend == false) return;
	var ibsail = document.frm.ibsail.value;

	
	if(ibsail == ""){
		lastKeyword="";
		hide("suggest");
	}else if(ibsail != lastKeyword){
		lastKeyword = ibsail;
	
		if(ibsail != ""){
			var para = "keyword="+ibsail;
			xhr = new XMLHttpRequest();
			xhr.open("post","ajaxLastexxml.jsp",true);
			xhr.onreadystatechange = function(){
				if(xhr.readyState==4){
					if(xhr.status==200){
						process();
					}else{
						alert("실패!: "+xhr.status);
					}
				}
			}
			xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			xhr.send(para);
		
		
		}
	}else{
		
		show("suggest");
	}
	setTimeout("sendKeyword()",500);
	
}//sendkeyword끝	

function process(){
	//연도를 가져옴 1입력시 리턴값 1999
	var data = xhr.responseXML;
	
	var ibsailNode = data.getElementsByTagName("ibsail");
	var test="";
	
	for (var i = 0; i < ibsailNode.length; i++) {
		
		test+="<a href=\"javascript:func('"+ibsailNode[i].childNodes[0].nodeValue+"')\">"+ibsailNode[i].childNodes[0].nodeValue+"</a><br />";
		//func(data); 호출 a태그 클릭시
	}
	var listView = document.getElementById("suggestList");
	listView.innerHTML = test;
	
	show("suggest");
}

function func(data){

//연도값에 해당하는 a태그 선택시 DOM을 이용하여 select Tag에 option Tag를 DOM을 이용하여 추가해줌
//year를 파라미터로 주고 연도에 해당하는 직원명을 얻는 두번째 ajax 처리를 함
	
	var year = data;
	var para = "keyword="+year;
	xhr = new XMLHttpRequest();
	xhr.open("post","ajaxLastexxmlyear.jsp",true);
	xhr.onreadystatechange = function(){
		if(xhr.readyState==4){
			if(xhr.status==200){
				processToName();
			}else{
				alert("실패!: "+xhr.status);
			}
		}
	}
	xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	xhr.send(para);
	
	loopSend = checkFirst = false;
	lastKeyword ="";
	
	hide("suggest");
}


function processToName(){
	var data = xhr.responseXML;
	
	var sname = document.getElementById("sname");
	
	
	var snameNode = data.getElementsByTagName("sname");

	
	for(i=sname.length-1; i>=0; i--){
		sname.remove(i);
	}
	
	var row = document.createElement("option");
	var text = document.createTextNode("직원명");
	row.setAttribute("value", "직원명");
	row.appendChild(text);
	sname.appendChild(row);

	
	for (var i = 0; i < snameNode.length; i++) {
		var row = document.createElement("option");
		var text = document.createTextNode(snameNode[i].childNodes[0].nodeValue);
		row.setAttribute("value", snameNode[i].childNodes[0].nodeValue);
		row.appendChild(text);
		sname.appendChild(row);
	}



}


function hide(ele){
	var e = document.getElementById(ele);
	if (e) e.style.display = "none";
}
function show(ele){
	var e = document.getElementById(ele);
	if (e) e.style.display = "";
}

//직원명에 해당하는 버튼 클릭시 selectEvent가 호출
//호출하면 innerhtml방식으로 테이블로 담당 고객을 출력함

function selectEvent(selectObj) {
	//alert(selectObj.value + "가 선택 되었습니다.");
	var selectItem=selectObj.value;
	
	xhr = new XMLHttpRequest();
	xhr.open("post","ajaxLastexgogek.jsp",true);
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState==4){
			if(xhr.status == 200){
				processToGogek();
			}else{
				alert("get 요청 실패"+xhr.status);
			}	
		}
	}
	xhr.setRequestHeader("content-Type", "application/x-www-form-urlencoded");
	xhr.send("name="+selectItem);
	
}


function processToGogek(){
	var data = xhr.responseXML;
	var gogekNode = data.getElementsByTagName("gogek");
	var codeNode = data.getElementsByTagName("code");
	var nameNode = data.getElementsByTagName("name");
	var juminNode = data.getElementsByTagName("jumin");
	var telNode = data.getElementsByTagName("tel");
	
	var str = "<table border ='1'>";
	str += "<h3>관리고객</h3>";
	str += "<tr><th>고객번호</th><th>이름</th><th>주민번호</th><th>전화번호</th></tr>";
	
	var count =0;
	for(var i= 0; i < gogekNode.length; i ++){
		str += "<tr>";
		str += "<td>"+codeNode[i].childNodes[0].nodeValue+"</td>";
		str += "<td>"+nameNode[i].childNodes[0].nodeValue+"</td>";
		str += "<td>"+juminNode[i].childNodes[0].nodeValue+"</td>";
		str += "<td>"+telNode[i].childNodes[0].nodeValue+"</td>";
		str += "</tr>";	
		count++;
	}
	str += "<tr>";
	str += "<td>"+"인원수"+"</td>";
	str += "<td>"+count+"</td>";
	str += "</tr>";	
	
	document.getElementById("disp").innerHTML =str;


}


