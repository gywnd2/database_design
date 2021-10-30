package main;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
public class JDBC_LeeHyoJung {
    public static void main(String[] args) throws ClassNotFoundException, SQLException{
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hyojung?useUnicode=true&useJDBCCompliantTimezoneShift=true&"
                    + "useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "root");

//            Select all tuples from R
            System.out.println("!!!!Select all tuples from R before insert a tuple!!!!");
            Statement stmt= conn.createStatement();
            ResultSet rset= stmt.executeQuery("select * from user");
            while (rset.next()) {
                System.out.println("User "+rset.getString("userid")+ " / signupdate = "+rset.getString("signupdate")+
                        " / nickname = "+rset.getString("nickname")+" / introduction = "+rset.getString("introduction")+
                        " / point = "+rset.getInt("point")+" / city = "+rset.getString("city")+" / district = "+rset.getString("district"));
            }

//            Dynamic insert clause
            System.out.println("!!!!Insert a tuple with dynamic insert clause!!!!");
            String sql= "insert into user values (?,?,?,?,?,?,?)";
            PreparedStatement pstmt= conn.prepareStatement(sql);
            pstmt.setString(1, "lastoneman");
            pstmt.setString(2,"2021-10-30");
            pstmt.setString(3, "bestcustomer");
            pstmt.setString(4, "nicetomeetyou");
            pstmt.setInt(5, 85);
            pstmt.setString(6, "Seoul");
            pstmt.setString(7, "Yongsan-gu");
            pstmt.executeUpdate();

//            Select all tuples from R
            System.out.println("!!!!Select all tuples from R again after insertion!!!!");
            conn.createStatement();
            rset= stmt.executeQuery("select * from user");
            while (rset.next()) {
                System.out.println("User "+rset.getString("userid")+ " / signupdate = "+rset.getString("signupdate")+
                        " / nickname = "+rset.getString("nickname")+" / introduction = "+rset.getString("introduction")+
                        " / point = "+rset.getInt("point")+" / city = "+rset.getString("city")+" / district = "+rset.getString("district"));
            }
            stmt.close();
            conn.close();
        }
        catch(SQLException sqle) {
            System.out.println("SQLException: "+sqle);
        }
    }
}