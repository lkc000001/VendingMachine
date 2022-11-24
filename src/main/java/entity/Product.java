package entity;

import java.io.Serializable;
import java.util.Date;

public class Product implements Serializable{
	private Long id;
	
	private String name;
	
	private Integer price;
	
	private Integer cost;
	
	private Integer stock;
	
	private String unit;
	
	private String image;
	
	private String classify;
	
	private String enabled;
	
	private Date createtime;
	
	
	private String state;
	
	public Product() {
	}

	public Product(Long id, String name, String enabled, String classify) {
		super();
		this.id = id;
		this.name = name;
		this.enabled = enabled;
		this.classify = classify;
	}

	public Product(Long id, Integer cost, Integer stock) {
		super();
		this.id = id;
		this.cost = cost;
		this.stock = stock;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public Integer getCost() {
		return cost;
	}

	public void setCost(Integer cost) {
		this.cost = cost;
	}

	public Integer getStock() {
		return stock;
	}

	public void setStock(Integer stock) {
		this.stock = stock;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getClassify() {
		return classify;
	}

	public void setClassify(String classify) {
		this.classify = classify;
	}

	public String getEnabled() {
		return enabled;
	}

	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Override
	public String toString() {
		return "Product [id=" + id + ", name=" + name + ", price=" + price + ", cost=" + cost + ", stock=" + stock
				+ ", unit=" + unit + ", image=" + image + ", classify=" + classify + ", enabled=" + enabled
				+ ", createtime=" + createtime + "]";
	}

}
