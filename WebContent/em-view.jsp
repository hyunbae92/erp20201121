<%@page import="erp.common.DBCon"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/head.jsp"></jsp:include>
<style>
*{
	font-family: sans-serif;
	padding: 0;
	margin: 0;
	position: relative;
}
body{
	width : 100%;
	position: absolute;
	align-content: center;
}
</style>
<%
	if("POST".equals(request.getMethod())){
		if(request.getParameter("em_num")!=null){
			int emNum = Integer.parseInt(request.getParameter("em_num"));
			Connection con = null;
			PreparedStatement ps = null;
			try{
				con = DBCon.getConnectin();
				String sql = "delete from EMPLOYEE where em_num=?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, emNum);
				if(ps.executeUpdate()==1){
%>
<script>
	alert('삭제되었습니다.');
	location.href = '/em-list.jsp';
</script>
<%
				}
			}catch(Exception e){
				out.println(e);
			}finally{
				if(ps!=null){
					ps.close();
				}
				if(con!=null){
					con.close();
				}
			}
		}
	}
%>
</head>
<body>
<h1>JSP Test</h1>
<form method="POST">
<table border="1">
	<tr>
		<th>사원번호</th>
		<th>사원이름</th>
		<th>부서명</th>
		<th>아이디</th>
		<th>비밀번호</th>
		<th>입사일</th>
	</tr>
<%
	if("GET".equals(request.getMethod())){
		int emNum = Integer.parseInt(request.getParameter("em_num"));
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			con = DBCon.getConnectin();
			String sql = "select em.*, di.di_name from employee em ,depart_info di where em.di_num=di.di_num and em_num=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, emNum);
			rs = ps.executeQuery();
			if(rs.next()){
%>
	<tr>
		<td><%=rs.getInt("em_num")%></td>
		<td><%=rs.getString("em_name")%></td>
		<td><%=rs.getString("di_name")%></td>
		<td><%=rs.getString("em_id")%></td>
		<td><%=rs.getString("em_pwd")%></td>
		<td><%=rs.getString("credat")%></td>
	</tr>
</table>
	<button type="button" onclick="goEmUpdate(<%=rs.getInt("em_num")%>)">수정</button>
	<button>삭제</button>
	<button type="button" onclick="goEmList()">목록</button>
</form>
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
	}
%>
<script>
function goEmUpdate(emNum){
	location.href = '/em-update.jsp?em_num='+emNum;
}
function goEmList(){
	var search_type = '<%=%>'
	var di_num = document.querySelector('#di_num').value;
	var di_name = document.querySelector('#di_name').value;
	var em_name = document.querySelector('#em_name').value;
	location.href = '/em-list.jsp';
}
</script>
</body>
</html>