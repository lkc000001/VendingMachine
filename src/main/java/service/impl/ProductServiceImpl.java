package service.impl;

import java.util.List;

import entity.Member;
import entity.Page;
import entity.Product;
import entity.Purchase;
import entity.ShoppingCart;
import repositories.MemberRepositories;
import repositories.ProductRepositories;
import repositories.PurchaseRepositories;
import service.MemberService;
import service.ProductService;

public class ProductServiceImpl implements ProductService {

	ProductRepositories productRepositories = new ProductRepositories();

	PurchaseRepositories purchaseRepositories = new PurchaseRepositories();
	
	@Override
	public Product getProductById(Long id) {
		return productRepositories.getProductById(id);
	}

	@Override
	public List<Product> queryProduct(Product product, Page page) {
		return productRepositories.queryProduct(product, page);
	}

	@Override
	public int addProduct(Product product) {
		return productRepositories.addProduct(product);
	}

	@Override
	public int updateProduct(Product product) {
		return productRepositories.updateProduct(product);
	}

	@Override
	public int updateStock(ShoppingCart shoppingCarts) {
		return productRepositories.updateStock(shoppingCarts);
	}
	
	@Override
	public int deleteProduct(Long id) {
		return productRepositories.deleteProduct(id);
	}

	@Override
	public int addPurchase(Purchase purchase) {
		return purchaseRepositories.addPurchase(purchase);
	}

	@Override
	public int addStock(Product product) {
		return productRepositories.addStock(product);
	}

	@Override
	public int count(boolean isEnable) {
		return productRepositories.count(isEnable);
	}
	
	
}
