package entity;

import java.io.Serializable;
import java.util.Date;

public class Wallet implements Serializable {
	
	private Long id;
	
	private Long memberId;
	
	private Integer amount;
	
	private Date createtime;

	public Wallet() {

	}

	public Wallet(Long memberId, Integer amount) {
		this.memberId = memberId;
		this.amount = amount;
	}

	public Long getMemberId() {
		return memberId;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	@Override
	public String toString() {
		return "Wallet [memberId=" + memberId + ", amount=" + amount + ", createtime=" + createtime + "]";
	}
	
}
