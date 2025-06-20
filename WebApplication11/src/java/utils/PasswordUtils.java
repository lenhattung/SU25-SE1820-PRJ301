/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import model.UserDAO;
import model.UserDTO;

/**
 *
 * @author tungi
 */
public class PasswordUtils {

    public static String encryptSHA256(String password) {
        if (password == null || password.isEmpty()) {
            return null;
        }
        try {
            // Tạo MessageDigest instance cho SHA-256
            MessageDigest md = MessageDigest.getInstance("SHA-256");

            // Chuyển đổi password thành byte array và hash
            byte[] hashBytes = md.digest(password.getBytes(StandardCharsets.UTF_8));

            // Chuyển đổi byte array thành hex string
            StringBuilder hexString = new StringBuilder();
            for (byte hashByte : hashBytes) {
                String hex = Integer.toHexString(0xff & hashByte);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }

            return hexString.toString();

        } catch (NoSuchAlgorithmException e) {
            System.err.println("SHA-256 algorithm not available: " + e.getMessage());
            return null;
        } catch (Exception e) {
            System.err.println("Error during SHA-256 encryption: " + e.getMessage());
            return null;
        }
    }
    
    public static void main(String[] args) {
        System.out.println(encryptSHA256("123"));
        // Cat nhat lai mat khau
        UserDAO udao = new UserDAO();
        List<UserDTO> list = udao.getAllUsers();
        for (UserDTO user : list) {
            udao.updatePassword(user.getUserID(), encryptSHA256(user.getPassword()));
        }
    }
}
