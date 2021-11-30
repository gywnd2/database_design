package main;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class JDBC_LeeHyoJung {
    public static void main(String[] args) throws ClassNotFoundException, SQLException{
        String city, district, dong, id;
        int selection, state;
        Scanner scanner;

        scanner=new Scanner(System.in);

            System.out.println("------- 기능 선택 -------");
            System.out.println("1. 찜한 상품 지역별 검색");
            System.out.println("2. 특정 지역 거래 랭킹 보기");
            System.out.println("3. 종료");
            System.out.print("원하는 기능의 번호를 입력하세요 : ");

            selection=scanner.nextInt();

            switch (selection){
                case 1:
                    System.out.println("------- 찜한 상품 지역별 검색 -------");
                    System.out.print("ID를 입력하세요 : ");
                    id=scanner.next();
                    System.out.print("시를 입력하세요 : ");
                    city=scanner.next();
                    System.out.print("구를 입력하세요 : ");
                    district=scanner.next();
                    System.out.print("동을 입력하세요 : ");
                    dong= scanner.next();
                    showLikedItemAroundArea(id, city, district, dong);
                    break;
                case 2:
                    System.out.println("------- 특정 지역 거래 랭킹 보기 -------");
                    System.out.print("시를 입력하세요 : ");
                    city=scanner.next();
                    System.out.print("구를 입력하세요 : ");
                    district=scanner.next();
                    System.out.print("동을 입력하세요 : ");
                    dong= scanner.next();
                    System.out.print("거래 상태를 입력하세요. 1 = 판매 중, 2 = 예약 중, 3 = 거래 완료 : ");
                    state= scanner.nextInt();
                    showDealRank(city, district, dong, state);
                    break;
            }

    }

<<<<<<< HEAD
    // item, likeditem, user, location
=======
>>>>>>> main
    public static void showLikedItemAroundArea(String id, String city, String district, String dong){
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hyojung?useUnicode=true&useJDBCCompliantTimezoneShift=true&"
                    + "useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "root");

            // user10 , 안양시 만안구 석수2동
<<<<<<< HEAD
            PreparedStatement pStmt= conn.prepareStatement("select a.item_name, a.price, a.seller_id from item as a, likeditem as liked where liked.user_id= ? and a.item_id = liked.item_id and a.item_id in (select b.item_id from item as b where b.seller_id in (select user.user_id from user where location_id=(select location_id from location where city= ? and district= ? and eup_dong= ? )))");
=======
            PreparedStatement pStmt= conn.prepareStatement("select a.item_name as king, a.price, a.seller_id from item as a, likeditem as liked where liked.user_id= ? and a.item_id = liked.item_id and a.item_id in (select b.item_id from item as b where b.seller_id in (select user.user_id from user where location_id=(select location_id from location where city= ? and district= ? and eup_dong= ? )))");
>>>>>>> main
            pStmt.setString(1, id);
            pStmt.setString(2, city);
            pStmt.setString(3, district);
            pStmt.setString(4, dong);
            ResultSet rset=pStmt.executeQuery();

            while (rset.next()) {
                System.out.println("상품명 : "+rset.getString("a.item_name")+ " / 가격 : "+rset.getString("a.price")+
                        " / 판매자명 : "+rset.getString("a.seller_id"));
            }

            pStmt.close();
            conn.close();
        }
        catch(SQLException sqle) {
            System.out.println("SQLException: "+sqle);
        }
    }

    public static void showDealRank(String city, String district, String dong, int state){
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/hyojung?useUnicode=true&useJDBCCompliantTimezoneShift=true&"
                    + "useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "root");

            // 서울시 동작구 흑석동, 거래 완료
<<<<<<< HEAD
            PreparedStatement pStmt= conn.prepareStatement("select u.nickname as username, count(h.item_id) as num from dealhistory as h, user as u where h.user_id=u.user_id and u.location_id=(select location_id from location where city= ? and district= ? and eup_dong= ?) and h.transaction_state= ? group by username order by num DESC");
=======
            PreparedStatement pStmt= conn.prepareStatement("select u.nickname as username, count(h.item_id) as num from dealhistory as h, user as u where h.user_id=u.user_id and u.location_id=(select location_id from location where city= ? and district= ? and eup_dong= ?) and h.transaction_state= ? group by username");
>>>>>>> main
            pStmt.setString(1, city);
            pStmt.setString(2, district);
            pStmt.setString(3, dong);
            switch(state){
                case 1:
                    pStmt.setString(4, "판매 중");
                    break;
                case 2:
                    pStmt.setString(4, "예약 중");
                    break;
                case 3:
                    pStmt.setString(4, "거래 완료");
                    break;
            }
            ResultSet rset=pStmt.executeQuery();

            while (rset.next()) {
                System.out.println("사용자명 : "+rset.getString("username")+ " / 거래 수 : "+rset.getInt("num"));
            }

            pStmt.close();
            conn.close();
        }
        catch(SQLException sqle) {
            System.out.println("SQLException: "+sqle);
        }
    }
}