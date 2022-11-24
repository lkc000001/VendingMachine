package entity;

import java.io.Serializable;
import java.util.Date;

public class ShoppingCart implements Serializable {
	
	private Long id;
	
	private String orderId;
	
	private Long memberId;
	
	private Long productId;
	
	private String productName;
	
	private String productImage;
	
	private Integer productPrice;
	
	private Integer productCost;
	
	private Integer productStock;
	
	private Integer buyQuantity;
	
	private Integer total;
	
	private Date createtime;

	
	private String startDate;
	
	private String endDate;
	
	public ShoppingCart() {
	}

	public ShoppingCart(Long productId, String productName, String productImage, 
			Integer productPrice, Integer productCost, Integer buyQuantity) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.productImage = productImage;
		this.productPrice = productPrice;
		this.productCost = productCost;
		this.buyQuantity = buyQuantity;
		
	}

	public ShoppingCart(Long memberId, Long productId, String startDate, String endDate) {
		super();
		this.memberId = memberId;
		this.productId = productId;
		this.startDate = startDate;
		this.endDate = endDate;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public Long getMemberId() {
		return memberId;
	}

	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductImage() {
		return productImage;
	}

	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}

	public Integer getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(Integer productPrice) {
		this.productPrice = productPrice;
	}

	public Integer getProductCost() {
		return productCost;
	}

	public void setProductCost(Integer productCost) {
		this.productCost = productCost;
	}

	public Integer getProductStock() {
		return productStock;
	}

	public void setProductStock(Integer productStock) {
		this.productStock = productStock;
	}

	public Integer getBuyQuantity() {
		return buyQuantity;
	}

	public void setBuyQuantity(Integer buyQuantity) {
		this.buyQuantity = buyQuantity;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	@Override
	public String toString() {
		return "ShoppingCart [id=" + id + ", orderId=" + orderId + ", memberId=" + memberId + ", productId=" + productId
				+ ", productName=" + productName + ", productImage=" + productImage + ", productPrice=" + productPrice
				+ ", productCost=" + productCost + ", productStock=" + productStock + ", buyQuantity=" + buyQuantity
				+ ", total=" + total + ", createtime=" + createtime + ", startDate=" + startDate + ", endDate="
				+ endDate + "]";
	}
}
