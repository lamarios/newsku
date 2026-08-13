package com.github.lamarios.newsku.persistence.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "feed_clicks")
public class FeedClick {
    @Id
    private String id;
    @ManyToOne
    @JoinColumn(name = "feed_id")
    private Feed feed;
    @Column(name = "timecreated")
    private long timeCreated;

    public Feed getFeed() {
        return feed;
    }

    public void setFeed(Feed feed) {
        this.feed = feed;
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
}
