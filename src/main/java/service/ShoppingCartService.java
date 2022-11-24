package service;

import java.util.List;

import entity.Member;
import entity.Page;
import entity.Product;
import entity.ShoppingCart;
import entity.Wallet;

public interface ShoppingCartService {
	
	List<ShoppingCart> queryShoppingCart (ShoppingCart shoppingCart, Page page);
	
	List<ShoppingCart> queryShoppingList (Long memberId);
	
	int addShoppingCarts(List<ShoppingCart> shoppingCarts, Long memberId);
	
	int count();

}
