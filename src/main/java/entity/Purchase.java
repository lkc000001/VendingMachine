package entity;

import java.util.Date;

public class Purchase {
	private Long id;
	
	private Long productId;
	
	private Integer productCost;
	
	private Integer quantity;
	
	private Date createtime;
	
	public Purchase() {

	}

	public Purchase(Long productId, Integer productCost, Integer quantity) {
		super();
		this.productId = productId;
		this.productCost = productCost;
		this.quantity = quantity;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public Integer getProductCost() {
		return productCost;
	}

	public void setProductCost(Integer productCost) {
		this.productCost = productCost;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
}
