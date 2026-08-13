package com.github.lamarios.newsku.persistence.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "tag_clicks")
public class TagClick {
    @Id
    private String id;
    @Column(name = "timecreated")
    private long timeCreated;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    private String tag;

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

    public long getTimeCreated() {
        return timeCreated;
    }

    public void setTimeCreated(long timeCreated) {
        this.timeCreated = timeCreated;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }
}
