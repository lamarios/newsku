package com.github.lamarios.newsku.persistence.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

@Entity
@Table(name = "api_keys")
public class ApiKey {
  @Id private String id;
  private String name;

  @JsonIgnore
  @ManyToOne
  @JoinColumn(name = "user_id")
  private User user;

  @JsonIgnore
  @Column(name = "key_hash")
  private String keyHash;

  @Column(name = "time_created")
  private long timeCreated;

  @Column(name = "expires_at")
  private Long expiresAt;

  @Column(name = "last_used")
  private Long lastUsed;

  public boolean isExpired() {
    return expiresAt != null && expiresAt < System.currentTimeMillis();
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

  public String getKeyHash() {
    return keyHash;
  }

  public void setKeyHash(String keyHash) {
    this.keyHash = keyHash;
  }

  public long getTimeCreated() {
    return timeCreated;
  }

  public void setTimeCreated(long timeCreated) {
    this.timeCreated = timeCreated;
  }

  public Long getExpiresAt() {
    return expiresAt;
  }

  public void setExpiresAt(Long expiresAt) {
    this.expiresAt = expiresAt;
  }

  public Long getLastUsed() {
    return lastUsed;
  }

  public void setLastUsed(Long lastUsed) {
    this.lastUsed = lastUsed;
  }
}
