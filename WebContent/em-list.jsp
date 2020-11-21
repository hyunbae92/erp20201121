<%@page import="erp.common.DBCon"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/head.jsp"></jsp:include>
</head>
<body> 
<form class="box">
<h1>JSP Test</h1>
<input type="radio" name="search_type" id="type1" value="di_num" checked onchange="checkSearchType(this)">
<label for="type1">선택</label>
<input type="radio" name="search_type" id="type2" value="di_name" onchange="checkSearchType(this)">
<label for="type2">검색</label><br>
부서명 : 
<select name="di_num" id="di_num">
	<option value="">부서명선택</option>
<%
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	try{
		con=DBCon.getConnectin();
		String sql = "select di_num, di_name from depart_info order by di_code";
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery();
		while(rs.next()){
%>
		<option value="<%=rs.getString("di_num")%>"><%=rs.getString("di_name")%></option>
<%
		}
	}catch(Exception e){
		out.println(e);
	}finally{
		if(rs!=null){
			rs.close();
		}
		if(ps!=null){
			ps.close();
		}
		if(con!=null){
			con.close();
		}
	}
%>
</select>
<input type="text" name="di_name" id="di_name" style="display: none;"><br>
사원명 : <input type="text" name=em_name id="em_name"><input type="submit" value="검색">
<table border="1">
	<tr>
		<th>사원번호</th>
		<th>사원이름</th>
		<th>부서명</th>
		<th>사원아이디</th>
		<th>입사일</th>
	</tr>
<%
try{
	String diNum = request.getParameter("di_num");
	String emName = request.getParameter("em_name");
	String diName = request.getParameter("di_name");
	con = DBCon.getConnectin();
	String sql = "select em.*, di.di_num, di.di_name from employee em ,depart_info di where em.di_num=di.di_num ";
	if(diNum!=null && !"".equals(diNum)){
		sql += " and em.di_num=? ";
	}else if(diName!=null && !"".equals(diName)){
		sql += " and di.di_name like '%' || ? || '%' ";
	}
	if(emName!=null && !"".equals(emName)){
		sql += " and em.em_name like '%' || ? || '%' ";
	}
	sql += " order by em.em_num ";
	ps = con.prepareStatement(sql); 
	
	if(diNum!=null && !"".equals(diNum)){
		ps.setString(1, diNum);
		if(emName!=null && !"".equals(emName)){
			ps.setString(2, emName);
		}
	}else if(diName!=null && !"".equals(diName)){
		ps.setString(1, diName);
		if(emName!=null && !"".equals(emName)){
			ps.setString(2, emName);
		}
	}else if(emName!=null && !"".equals(emName)){
		ps.setString(1, emName);
	}
	
	rs = ps.executeQuery();
	int cnt = 0;
	while(rs.next()){
		cnt++;
%>
	<tr>
		<td><%=rs.getString("em_num")%></td>
		<td><a href="javascript:void(0)" onclick="goView(<%=rs.getString("em_num")%>)"><%=rs.getString("em_name")%></a></td>
		<td><%=rs.getString("di_name")%></td>
		<td><%=rs.getString("em_id")%></td> 
		<td><%=rs.getString("credat")%></td>	
	</tr>
<%
	}
	if(cnt==0){
%>
		<tr>
			<td colspan="5" align="center">아무것도 발견하지 못했습니다.</td>	
		</tr>
<%		
	}
	}catch(Exception e){
		e.printStackTrace();
		out.print(e);
	}finally{
		if(rs!=null){
			rs.close();
		}
		if(ps!=null){
			ps.close();
		}
		if(con!=null){
			con.close();
		}
	}
%>
</table>
<a href="/em-insert.jsp"><input type="button" value="사원등록"></a>

</form>
<script>
window.onload= function (){
	var search_type = '<%=request.getParameter("search_type")%>';
	var di_num = '<%=request.getParameter("di_num")%>';
	var di_name = '<%=request.getParameter("di_name")%>';
	var em_name = '<%=request.getParameter("em_name")%>';
	if(em_name && em_name!='null'){
		document.querySelector('#em_name').value = em_name;
	}
	if(di_num && di_num!='null'){
		document.querySelector('#di_num').value = di_num;
	}
	if(di_name && di_name!='null'){
		document.querySelector('#di_name').value = di_name;
	}
	if(search_type && search_type!='null'){
		document.querySelector('[name=search_type][value='+search_type+']').checked = true;
		checkSearchType(document.querySelector('[name=search_type]:checked'));	
	}
}
function checkSearchType(obj){
	if(obj.value=='di_name'){
		document.querySelector('#di_num').value = '';
		document.querySelector('#di_num').style.display = 'none';
		document.querySelector('#di_name').style.display = '';
	}else{
		document.querySelector('#di_name').value = '';
		document.querySelector('#di_num').style.display = '';
		document.querySelector('#di_name').style.display = 'none';
	}
}

function goView(emNum){
	var em_num = emNum;
	var search_type = document.querySelector('[name=search_type]:checked').value;
	var di_num = document.querySelector('#di_num').value;
	var di_name = document.querySelector('#di_name').value;
	var em_name = document.querySelector('#em_name').value;
	location.href = '/em-view.jsp?em_num='+em_num+'&search_type='+search_type+'&di_num='+di_num+'&di_name='+di_name+'&em_name='+em_name;
}
</script>
</body>
</html>