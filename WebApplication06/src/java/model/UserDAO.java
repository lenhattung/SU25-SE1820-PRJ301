/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
import sun.text.normalizer.UBiDiProps;
import utils.DbUtils;

/**
 *
 * @author tungi
 */
public class UserDAO {

    public UserDAO() {
    }

    public boolean login(String userID, String password) {
        try {
            UserDTO user = getUserById(userID);
            if (user != null) {
                if (user.getPassword().equals(password)) {
                    if (user.isStatus()) {
                        return true;
                    }
                }
            }
        } catch (Exception e) {
        }
        return false;
    }

    public UserDTO getUserById(String userID) {
        try {
            String sql = "SELECT * FROM tblUsers "
                    + " WHERE userID=?";
            // B1 - Ket noi
            Connection conn = DbUtils.getConnection();
            //
            // B2 - Tao cong cu thuc thi cau lenh
            PreparedStatement pr = conn.prepareStatement(sql);
            pr.setString(1, userID);
            ResultSet rs = pr.executeQuery();

            // B3 - Duyet bang 
            while (rs.next()) {
                String userId = rs.getString("userID");
                String fullName = rs.getString("fullName");
                String password1 = rs.getString("password");
                String roleID = rs.getString("roleID");
                boolean status = rs.getBoolean("status");

                UserDTO userDTO = new UserDTO(userId, fullName, password1, roleID, status);
                return userDTO;
            }
            return null;
        } catch (Exception e) {
            return null;
        }
    }
}