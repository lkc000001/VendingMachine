package service.impl;

import java.util.List;

import entity.Wallet;
import repositories.WalletRepositories;
import service.WalletService;

public class WalletServiceImpl implements WalletService {

	WalletRepositories walletRepositories = new WalletRepositories();

	@Override
	public Wallet getWalletByMemberIdId(Long memberId) {
		return walletRepositories.getWalletByMemberId(memberId);
	}

	@Override
	public int getAmount(Long memberId) {
		return walletRepositories.getAmount(memberId);
	}

	@Override
	public List<Wallet> queryAmountList(Long memberId) {
		return walletRepositories.queryAmountList(memberId);
	}
	
	@Override
	public int addWallet(Wallet wallet) {
		return walletRepositories.addWallet(wallet);
	}

}
