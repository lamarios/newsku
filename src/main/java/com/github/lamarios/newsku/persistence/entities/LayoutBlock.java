package com.github.lamarios.newsku.persistence.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.github.lamarios.newsku.models.LayoutBlockSettings;
import com.github.lamarios.newsku.models.LayoutBlockType;
import jakarta.persistence.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

@Entity
@Table(name = "layout_blocks")
public class LayoutBlock {
  @Id private String id;

  @Enumerated(EnumType.STRING)
  private LayoutBlockType type;

  @Column(name = "display_order")
  private int order;

  @JdbcTypeCode(SqlTypes.JSON)
  private LayoutBlockSettings settings;

  @ManyToOne
  @JoinColumn(name = "user_id")
  @JsonIgnore
  private User user;

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public LayoutBlockType getType() {
    return type;
  }

  public void setType(LayoutBlockType type) {
    this.type = type;
  }

  public int getOrder() {
    return order;
  }

  public void setOrder(int order) {
    this.order = order;
  }

  public LayoutBlockSettings getSettings() {
    return settings;
  }

  public void setSettings(LayoutBlockSettings settings) {
    this.settings = settings;
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }
}
