/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DbUtils;

/**
 *
 * @author tungi
 */
public class ProductDAO {

    // SQL Queries
    private static final String GET_ALL_PRODUCTS = "SELECT id, name, image, description, price, size, status FROM tblProducts";
    private static final String GET_PRODUCT_BY_ID = "SELECT id, name, image, description, price, size, status FROM tblProducts WHERE id = ?";
    private static final String CREATE_PRODUCT = "INSERT INTO tblProducts (id, name,image, description, price, size, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_PRODUCT = "UPDATE tblProducts SET name = ?, image=?, description = ?, price = ?, size = ?, status = ? WHERE id = ?";
    private static final String DELETE_PRODUCT = "DELETE FROM tblProducts WHERE id = ?";

    public List<ProductDTO> getAll() {
        List<ProductDTO> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(GET_ALL_PRODUCTS);
            rs = ps.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setId(rs.getString("id"));
                product.setName(rs.getString("name"));
                product.setImage(rs.getString("image"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setSize(rs.getString("size"));
                product.setStatus(rs.getBoolean("status"));

                products.add(product);
            }
        } catch (Exception e) {
            System.err.println("Error in getAll(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return products;
    }

    /**
     * Get product by ID
     *
     * @param id Product ID to search
     * @return ProductDTO object or null if not found
     */
    public ProductDTO getProductByID(String id) {
        ProductDTO product = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(GET_PRODUCT_BY_ID);
            ps.setString(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                product = new ProductDTO();
                product.setId(rs.getString("id"));
                product.setName(rs.getString("name"));
                product.setImage(rs.getString("image"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setSize(rs.getString("size"));
                product.setStatus(rs.getBoolean("status"));
            }
        } catch (Exception e) {
            System.err.println("Error in getProductByName(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return product;
    }

    /**
     * Create new product
     *
     * @param product ProductDTO object to create
     * @return true if successful, false otherwise
     */
    public boolean create(ProductDTO product) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(CREATE_PRODUCT);

            ps.setString(1, product.getId());
            ps.setString(2, product.getName());
            ps.setString(3, product.getImage());
            ps.setString(4, product.getDescription());
            ps.setDouble(5, product.getPrice());
            ps.setString(6, product.getSize());
            ps.setBoolean(7, product.isStatus());

            int rowsAffected = ps.executeUpdate();
            success = (rowsAffected > 0);

        } catch (Exception e) {
            System.err.println("Error in create(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }

        return success;
    }

    /**
     * Update existing product
     *
     * @param product ProductDTO object with updated information
     * @return true if successful, false otherwise
     */
    public boolean update(ProductDTO product) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(UPDATE_PRODUCT);

            ps.setString(1, product.getName());
            ps.setString(2, product.getImage());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());
            ps.setString(5, product.getSize());
            ps.setBoolean(6, product.isStatus());
            ps.setString(7, product.getId()); // WHERE condition

            int rowsAffected = ps.executeUpdate();
            success = (rowsAffected > 0);

        } catch (Exception e) {
            System.err.println("Error in update(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }

        return success;
    }

    /**
     * Delete product by ID
     *
     * @param id Product ID to delete
     * @return true if successful, false otherwise
     */
    public boolean delete(String id) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(DELETE_PRODUCT);
            ps.setString(1, id);

            int rowsAffected = ps.executeUpdate();
            success = (rowsAffected > 0);

        } catch (Exception e) {
            System.err.println("Error in delete(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }

        return success;
    }

    /**
     * Close database resources safely
     *
     * @param conn Connection to close
     * @param ps PreparedStatement to close
     * @param rs ResultSet to close
     */
    private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            System.err.println("Error closing resources: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Check if product exists by ID
     *
     * @param id Product ID to check
     * @return true if exists, false otherwise
     */
    public boolean isProductExists(String id) {
        return getProductByID(id) != null;
    }

    /**
     * Get products by status
     *
     * @param status Status to filter (true for active, false for inactive)
     * @return List of ProductDTO objects
     */
    public List<ProductDTO> getProductsByStatus(boolean status) {
        List<ProductDTO> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String query = GET_ALL_PRODUCTS + " WHERE status = ?";

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setBoolean(1, status);
            rs = ps.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setId(rs.getString("id"));
                product.setName(rs.getString("name"));
                product.setImage(rs.getString("image"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setSize(rs.getString("size"));
                product.setStatus(rs.getBoolean("status"));

                products.add(product);
            }
        } catch (Exception e) {
            System.err.println("Error in getProductsByStatus(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return products;
    }
    
    public List<ProductDTO> getProductsByName(String name) {
        List<ProductDTO> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String query = GET_ALL_PRODUCTS + " WHERE name like ?";
        System.out.println(query);
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%"+name+"%");
            rs = ps.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setId(rs.getString("id"));
                product.setName(rs.getString("name"));
                product.setImage(rs.getString("image"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setSize(rs.getString("size"));
                product.setStatus(rs.getBoolean("status"));

                products.add(product);
            }
        } catch (Exception e) {
            System.err.println("Error in getProductsByStatus(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return products;
    }
    
    public List<ProductDTO> getActiveProductsByName(String name) {
        List<ProductDTO> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String query = GET_ALL_PRODUCTS + " WHERE name like ? and status=1";
        System.out.println(query);
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%"+name+"%");
            rs = ps.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setId(rs.getString("id"));
                product.setName(rs.getString("name"));
                product.setImage(rs.getString("image"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setSize(rs.getString("size"));
                product.setStatus(rs.getBoolean("status"));

                products.add(product);
            }
        } catch (Exception e) {
            System.err.println("Error in getProductsByStatus(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return products;
    }

    public boolean updateProductStatus(String productId, boolean status) {
        ProductDTO product = getProductByID(productId);
        if(product!=null){
            product.setStatus(status);
            return update(product);
        }else{
            return false;
        }
    }
}
