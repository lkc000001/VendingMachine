package service;

import java.util.List;

import entity.Member;
import entity.Page;
import entity.Product;
import entity.Purchase;
import entity.ShoppingCart;

public interface ProductService {
	
	Product getProductById(Long id);
	
	List<Product> queryProduct(Product product, Page page);
	
	int addProduct(Product product);
	
	int updateProduct(Product product);
	
	int updateStock(ShoppingCart shoppingCarts);
	
	int deleteProduct(Long id);
	
	int addPurchase(Purchase purchase);
	
	int addStock(Product product);
	
	int count(boolean isEnable);
}
