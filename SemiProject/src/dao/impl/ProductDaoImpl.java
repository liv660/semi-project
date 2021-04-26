package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.JDBCTemplate;
import dao.face.ProductDao;

import dto.Product;
import dto.ProductImg;
import dto.Userorder;
import util.ProductPaging;

public class ProductDaoImpl implements ProductDao {

	private PreparedStatement ps = null;
	private ResultSet rs = null;
	
	
	
	@Override
	public List<Product> selectAll(Connection conn, ProductPaging paging) {
		
		String sql = "";
		sql += "SELECT * FROM (";
		sql += " 	SELECT rownum rnum, P.* FROM (";
		sql += " 		SELECT";
		sql += " 			PB.product_id, PB.category_id, PB.product_name, PB.price, PB.content, PI.stored_img";
		sql += " 		FROM product PB, (";
		sql += "			SELECT PRODUCT_IMG.* FROM (";
		sql += "				SELECT";
		sql += " 					row_number() over( partition by product_id order by image_no) rnum";
		sql += " 					, image_no, product_id, origin_img, stored_img";
		sql += "				FROM product_img";
		sql += "			) PRODUCT_IMG";
		sql += "			WHERE rnum = 1";
		sql += " 		)PI";
		sql += " 		WHERE PB.product_id = PI.product_id(+)";
		sql += " 		ORDER BY product_id DESC";
		sql += "	) P";
		sql += " ) product";
		sql += " WHERE rnum BETWEEN ? AND ?";
				
		
		List<Product> productList = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt( 1, paging.getStartNo() );
			ps.setInt( 2, paging.getEndNo() );
			
			rs = ps.executeQuery();
			
			while ( rs.next() ) {
				
				Product p = new Product();
				
				p.setProductId( rs.getInt("product_Id") );
				p.setCategoryId( rs.getInt("category_Id") );
				p.setProductName( rs.getString("product_Name") );
				p.setPrice( rs.getInt("price") );
				p.setContent( rs.getString("content") );
				p.setStoredName(rs.getString("stored_img"));
				
				productList.add(p);
				
				
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			// DB객체 닫기
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		
		
		return productList;
	}


	
	
	@Override
	public int selectCntAll(Connection conn) {
		
		String sql = "";
		sql += "SELECT count(*) cnt FROM product";
		
		int cnt = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next() ) {
				cnt = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		
		return cnt;
	}

	
	@Override
	public Product selectProdByProdId(Connection conn, Product productid) {
		String sql = "";
		sql += "SELECT * FROM product";
		sql += " WHERE product_id = ?";
		
		Product product = null;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, productid.getProductId());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				product = new Product();
				product.setProductId( rs.getInt("product_id") );
				product.setCategoryId( rs.getInt("category_id") );
				product.setProductName( rs.getString("product_name") );
				product.setPrice( rs.getInt("price") );
				product.setContent( rs.getString("content") );
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		return product;
	}

	@Override
	public List<ProductImg> selectImg(Connection connection, Product viewProduct) {
		
		//SQL
		String sql = "";
		sql += "SELECT * FROM product_img";
		sql += " WHERE product_id = ?";

		
		List<ProductImg> productImg = new ArrayList<>();
		
		System.out.println("dao의 productId = " + viewProduct.getProductId() );
		
		try {
			ps = connection.prepareStatement(sql);
		
			ps.setInt(1, viewProduct.getProductId() );
		
			rs = ps.executeQuery();
			
			while(rs.next() ) {
				ProductImg pi = new ProductImg();
				
				pi.setProductId( rs.getInt("product_Id") );
				pi.setImageNo( rs.getInt("image_No") );
				pi.setOriginImg( rs.getString("origin_Img") );
				pi.setStoredImg( rs.getString("stored_Img") );
				
				//결과값 저장
				productImg.add(pi);
				
			}
			
		}  catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//DB객체 닫기
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return productImg;
	}
	
	@Override
	public List<ProductImg> selectMainImg(Connection connection, List<Product> product) {
		//SQL
		String sql = "";
		sql += "SELECT * FROM product_img";
		sql += " WHERE product_id = ?";

		
		List<ProductImg> productImg = new ArrayList<>();
		
//		게시글수
		int i = 0;
		
		System.out.println("dao의 productId = " + product.get(i).getProductId() );
		
		try {
			ps = connection.prepareStatement(sql);
		
			ps.setInt(1, product.get(i).getProductId() );
		
			rs = ps.executeQuery();
			
			while(rs.next() ) {
				ProductImg pi = new ProductImg();
				
				pi.setProductId( rs.getInt("product_Id") );
				pi.setImageNo( rs.getInt("image_No") );
				pi.setOriginImg( rs.getString("origin_Img") );
				pi.setStoredImg( rs.getString("stored_Img") );
				
				//결과값 저장
				productImg.add(pi);
				
			}
			
		}  catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//DB객체 닫기
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return productImg;
	}

	@Override
	public int selectproductId(Connection conn) {
		String sql = "";
		sql += "SELECT product_seq.nextval FROM dual";
		
		int prodId = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				prodId = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		return prodId;
	}


	@Override
	public int insert(Connection conn, Product product) {
		
		String sql = "";
		sql += "INSERT INTO product (product_id, category_id, product_name, price, content)";
		sql += " VALUES (?, ?, ?, ?, ?)";
		
		int result = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, product.getProductId());
			ps.setInt(2, product.getCategoryId());
			ps.setString(3, product.getProductName());
			ps.setInt(4, product.getPrice());
			ps.setString(5, product.getContent());
			
			result = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		System.out.println("DAO의 result 값 = " + result);
		return result;
	}


	@Override
	public int insertImg(Connection conn, List<ProductImg> productImgs) {
		String sql = "";
		sql += "INSERT INTO product_img (image_no, product_id, origin_img, stored_img)";
		sql += " VALUES (product_img_seq.nextval, ?, ?, ?)";

		int result = -1;
		int res = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			for(int i = 0; i < productImgs.size(); i++) {
				ps.setInt(1, productImgs.get(i).getProductId());
				ps.setString(2, productImgs.get(i).getOriginImg());
				ps.setString(3, productImgs.get(i).getStoredImg());
			
				res += ps.executeUpdate();
			}//for() END
			
			result = res;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return result;
	}




	@Override
	public int insertUserOrder(Connection conn, Userorder param) {
		
		String sql = "";
		sql += "INSERT INTO userorder( userorder_no, product_id, user_no, total_pay)";
		sql += " VALUES (userorder_seq.nextval, ?, ?, ?)";
		
		System.out.println("DAO - insertUserOrder 전달 완료 ");

		int res = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, param.getProduct_id() );
			ps.setInt(2, param.getUser_no() );
			ps.setInt(3, param.getTotal_pay() );
			
			res = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		
		return res;
	}








	



}
