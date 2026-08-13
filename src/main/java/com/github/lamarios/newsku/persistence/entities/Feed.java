package com.github.lamarios.newsku.persistence.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

@Entity
@Table(name = "feeds")
public class Feed {
    @Id
    private String id;
    private String name;
    private String description;
    private String url;
    @Column(name = "feed_item_preference")
    private String itemPreference;
    private String image;
    @Column(name = "last_refresh_errors")
    private int lastRefreshErrors;

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @ManyToOne
    @JoinColumn(name = "user_id")
    @JsonIgnore
    private User user;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "category_id")
    private FeedCategory category;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getItemPreference() {
        return itemPreference;
    }

    public void setItemPreference(String itemPreference) {
        this.itemPreference = itemPreference;
    }

    public int getLastRefreshErrors() {
        return lastRefreshErrors;
    }

    public void setLastRefreshErrors(int lastRefreshErrors) {
        this.lastRefreshErrors = lastRefreshErrors;
    }

    public FeedCategory getCategory() {
        return category;
    }

    public void setCategory(FeedCategory category) {
        this.category = category;
    }
}
