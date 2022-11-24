package service;

import java.util.List;

import entity.Member;
import entity.Product;
import entity.Wallet;

public interface WalletService {
	
	Wallet getWalletByMemberIdId(Long memberId);
	
	int getAmount(Long memberId);
	
	List<Wallet> queryAmountList(Long memberId);
	
	int addWallet(Wallet wallet);
	
}
