package com.github.lamarios.newsku.persistence.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.github.lamarios.newsku.models.EmailDigestFrequency;
import com.github.lamarios.newsku.models.ReadItemHandling;
import jakarta.persistence.*;
import java.util.List;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

@Entity
@Table(name = "users")
public class User {
    @Id
    private String id;
    private String username;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String password;
    private String email;
    @Column(name = "feed_item_preference")
    private String feedItemPreference;
    @Column(name = "oidc_sub")
    private String oidcSub;
    @Column(name = "minimum_importance")
    private int minimumImportance;
    @Column(name = "read_item_handling")
    @Enumerated(EnumType.STRING)
    private ReadItemHandling readItemHandling;
    @Column(name = "first_time_setup_done")
    private boolean firstTimeSetupDone;
    @JdbcTypeCode(SqlTypes.ARRAY)
    @Column(name = "email_digest")
    @Enumerated(EnumType.STRING)
    private List<EmailDigestFrequency> emailDigest;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFeedItemPreference() {
        return feedItemPreference;
    }

    public void setFeedItemPreference(String feedItemPreference) {
        this.feedItemPreference = feedItemPreference;
    }

    public String getOidcSub() {
        return oidcSub;
    }

    public void setOidcSub(String oidcSub) {
        this.oidcSub = oidcSub;
    }

    public int getMinimumImportance() {
        return minimumImportance;
    }

    public void setMinimumImportance(int minimumImportance) {
        this.minimumImportance = minimumImportance;
    }

    public ReadItemHandling getReadItemHandling() {
        return readItemHandling;
    }

    public void setReadItemHandling(ReadItemHandling readItemHandling) {
        this.readItemHandling = readItemHandling;
    }

    public boolean isFirstTimeSetupDone() {
        return firstTimeSetupDone;
    }

    public void setFirstTimeSetupDone(boolean firstTimeSetupDone) {
        this.firstTimeSetupDone = firstTimeSetupDone;
    }

    public List<EmailDigestFrequency> getEmailDigest() {
        return emailDigest;
    }

    public void setEmailDigest(List<EmailDigestFrequency> emailDigest) {
        this.emailDigest = emailDigest;
    }
}
