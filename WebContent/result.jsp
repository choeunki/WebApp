<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
   <%@ page import="java.sql.*"%>
   <%@ page import="java.util.*"%>
   <%
      response.setCharacterEncoding("EUC-KR");
      String allqt = request.getParameter("allqt");
      int intAllqt = Integer.valueOf(allqt);
      int score = 0;
      String qtAnswer = null;
      String userAnswer = null;

      int pass;
      //시험 채점
      for(int i=0; i<intAllqt; i++){
         qtAnswer = request.getParameter("answer"+i);
         userAnswer = request.getParameter(""+i);

         System.out.println("디비"+qtAnswer);
         System.out.println("유저"+userAnswer);
         if(qtAnswer.equals(userAnswer)){
            score++;
         }
      }
      //합격 여부 판단 
      
      if (score >= 7){
    	pass = 1;
   	}else{
   		pass = 0;
   	}
      
      Connection conn = null; // null로 초기화 한다.
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         String url = "jdbc:oracle:thin:@localhost:1521:orcl"; // 사용하려는 데이터베이스명을 포함한 URL 기술
         String id = "scott"; // 사용자 계정
         String pw = "0013"; // 사용자 계정의 패스워드

         Class.forName("oracle.jdbc.driver.OracleDriver"); // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
         conn = DriverManager.getConnection(url, id, pw); // DriverManager 객체로부터 Connection 객체를 얻어온다.

         /* 시험유형 조회 */
         String sql = "INSERT INTO pass(pass_index, pass_date, pass_type, pass_score) VALUES (pass_pass_index.NEXTVAL, TO_DATE(SYSDATE,'YYYY-MM-DD'),"+pass+","+score+")"; // sql 쿼리
         pstmt = conn.prepareStatement(sql); // prepareStatement에서 해당 sql을 미리 컴파일한다.
         rs = pstmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.

      } catch (Exception e) { // 예외가 발생하면 예외 상황을 처리한다.
         e.printStackTrace();
         out.println("member 테이블 호출에 실패했습니다.");
      } finally { // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다.  (순서중요)
         if (rs != null)
            try {
               rs.close();
            } catch (SQLException sqle) {
            } // Resultset 객체 해제
         if (pstmt != null)
            try {
               pstmt.close();
            } catch (SQLException sqle) {
            } // PreparedStatement 객체 해제
         if (conn != null)
            try {
               conn.close();
            } catch (SQLException sqle) {
            } // Connection 해제
      }
   %>
   
   
   점수 : <%=score %><br>
   <%
      if(score>=7){
         %>
         축하합니다 합격입니다
         <%
      }else{
         %>
         불합격입니다
         <%
      }
   %>
</body>
</html>