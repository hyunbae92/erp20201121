<%@page import="java.sql.ResultSet"%>
<%@page import="erp.common.DBCon"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
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
<%
request.setCharacterEncoding("UTF-8");
if(request.getMethod().equals("POST")){
	int diNum = Integer.parseInt(request.getParameter("di_num"));
	String emName = request.getParameter("em_name");
	String emId = request.getParameter("em_id");
	String emPwd = request.getParameter("em_pwd");
	if(emName!=null && emName!=null){
		Connection con = null;
		PreparedStatement ps = null;
		try{
			con = DBCon.getConnectin();
			String sql = "insert into employee(em_num, em_name, em_id, em_pwd, di_num)";
			sql += " values(seq_em_num.nextval, ?,?,?,?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, emName);
			ps.setString(2, emId);
			ps.setString(3, emPwd);
			ps.setInt(4, diNum);
			if(ps.executeUpdate()==1){
%>
	<script>
		alert('등록완료');
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
	return;
}else if("GET".equals(request.getMethod())){
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	try{
		con=DBCon.getConnectin();
		String sql = "select di_num, di_name from depart_info order by di_code";
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery();
%>
<form method="post" class="box">
	<h1>사원등록</h1> 
	<p>사원이름</p><input type="text" name="em_name"><br>
	<p>아이디</p><input type="text" name="em_id"><br>
	<p>비밀번호</p><input type="password" name="em_pwd"><br>
	<p>부서명</p>  
	<select name="di_num">
		<option value="" selected>부서선택</option>
<%
		while(rs.next()){
%>
		<option value="<%=rs.getString("di_num")%>"><%=rs.getString("di_name")%></option>
<%
		}
	}catch(Exception e){
		out.println(e);
	}
}
%>

	</select><br>
	<input type="submit" value="사원등록">
	<input type="button" value="취소" onclick="goBack()">
</form>
<script>
function goBack(){
	location.href = '/em-list.jsp';
}
</script>
</body>
</html>