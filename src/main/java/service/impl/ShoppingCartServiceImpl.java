package service.impl;

import java.util.List;

import entity.Page;
import entity.ShoppingCart;
import repositories.ShoppingCartRepositories;
import service.ShoppingCartService;

public class ShoppingCartServiceImpl implements ShoppingCartService {

	ShoppingCartRepositories shoppingCartRepositories = new ShoppingCartRepositories();

	@Override
	public List<ShoppingCart> queryShoppingList(Long memberId) {
		return shoppingCartRepositories.queryShoppingList(memberId);
	}

	@Override
	public int addShoppingCarts(List<ShoppingCart> shoppingCarts, Long memberId) {
		return shoppingCartRepositories.addShoppingCarts(shoppingCarts, memberId);
	}

	@Override
	public List<ShoppingCart> queryShoppingCart(ShoppingCart shoppingCart, Page page) {
		return shoppingCartRepositories.queryShoppingCart(shoppingCart, page);
	}

	@Override
	public int count() {
		return shoppingCartRepositories.count();
	}

	

	
}
