package entity;

import java.io.Serializable;
import java.util.Date;

public class Member implements Serializable {
	
	private Long id;
	
	private String account;
	
	private String pwd;
	
	private String name;
	
	private Date createtime;
	
	private String enabled;
	
	private String role;

	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Member(Long id, String account, String name, String enabled, String role) {
		super();
		this.id = id;
		this.account = account;
		this.name = name;
		this.enabled = enabled;
		this.role = role;
	}

	public Long getId() {
		if(id == null || id.equals("")){
            return 0L;
        }
        return Long.valueOf(id);
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getCreatetime() {
		if(createtime == null || createtime.equals("")){
			createtime = new Date();
		}
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getEnabled() {
		return enabled;
	}

	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	@Override
	public String toString() {
		return "Member [id=" + id + ", account=" + account + ", pwd=" + pwd + ", name=" + name + ", createtime="
				+ createtime + ", enabled=" + enabled + ", role=" + role + "]";
	}
}
