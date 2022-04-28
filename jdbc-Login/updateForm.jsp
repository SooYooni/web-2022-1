<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.sql.*"
%>
 <%
	String id = request.getParameter("id");
 %>
 
 
<%
	// 1. jdbc driver를 로드한다.
	Class.forName("org.mariadb.jdbc.Driver");
	
	
	// 2. db와의 연결(connection)을 생성한다.
	String url = "jdbc:mariadb://localhost:3333/sooyoondb";
	String user = "sooyoon";
	String pwd = "1111";
	Connection con = DriverManager.getConnection(url, user, pwd);
	
	
	// 3. 연결 후 그 통로를 통해 sql문을 실행한다.
	String sql = "select * from login where id=?";
	PreparedStatement ptmt=con.prepareStatement(sql);
	ptmt.setString(1,id);
	
	// 4. SQL 실행
	ResultSet rs = ptmt.executeQuery();
	
	String name = "";
	String pwd2 = "";
	//5. 반환된 데이터 출력
		while(rs.next()){
			name = rs.getString("name");
			pwd2 = rs.getString("pwd");
		}
			
		// 6. 객체 해지
		rs.close();
		ptmt.close();
		con.close();
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<h2>로그인</h2>
	<form name="Login" action="updatePro.jsp" method="post">
		아이디 : <input type="text" name="id" value=<%=id %>><br>
		이름 : <input type="text" name="name" value=<%=name %>><br>
		암호 : <input type="password" name="pwd" value=<%=pwd2 %>><br><br>
		<input type="submit" value="변경저장">
		<button type="button" onclick="location.href='list.jsp'">목록조회</button>
		<button type="button" onclick="location.href='Sign_delete.jsp?id=<%=id%>'">삭제</button>
	</form>
</body>
</html>