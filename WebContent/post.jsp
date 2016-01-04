<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
   <!-- Bootstrap -->
    <link href="bootstrap-3.3.4-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
</head>
<body>

	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.*"%>
	<%
		ArrayList list = new ArrayList();
		Connection conn = null; // null�� �ʱ�ȭ �Ѵ�.
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String url = "jdbc:oracle:thin:@localhost:1521:orcl"; // ����Ϸ��� �����ͺ��̽����� ������ URL ���
			String id = "scott"; // ����� ����
			String pw = "0013"; // ����� ������ �н�����

			Class.forName("oracle.jdbc.driver.OracleDriver"); // �����ͺ��̽��� �����ϱ� ���� DriverManager�� ����Ѵ�.
			conn = DriverManager.getConnection(url, id, pw); // DriverManager ��ü�κ��� Connection ��ü�� ���´�.

			String sql = "select * from test"; // sql ����
			pstmt = conn.prepareStatement(sql); // prepareStatement���� �ش� sql�� �̸� �������Ѵ�.

			rs = pstmt.executeQuery(); // ������ �����ϰ� ����� ResultSet ��ü�� ��´�.

			while (rs.next()) { // ����� �� �྿ ���ư��鼭 �����´�.
				list.add(rs.getString("test_type") + "  " + rs.getString("test_question") + "  "
						+ rs.getString("test_answer1") + "  " + rs.getString("test_answer2") + "  "
						+ rs.getString("test_answer3") + "  " + rs.getString("test_answer4") + "  "
						+ rs.getString("test_answer"));
	%>

	<%
		}
		} catch (Exception e) { // ���ܰ� �߻��ϸ� ���� ��Ȳ�� ó���Ѵ�.
			e.printStackTrace();
			out.println("member ���̺� ȣ�⿡ �����߽��ϴ�.");
		} finally { // ������ ���� �Ǵ� ���п� ������� ����� �ڿ��� ���� �Ѵ�.  (�����߿�)
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException sqle) {
				} // Resultset ��ü ����
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException sqle) {
				} // PreparedStatement ��ü ����
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException sqle) {
				} // Connection ����
		}
	%>

	<table width="550" border="1">
		<%
			for (int i = 0, j = 0; i < list.size(); i++) {
		%>
		<tr width="100">
			<td><%=list.get(i)%></td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>