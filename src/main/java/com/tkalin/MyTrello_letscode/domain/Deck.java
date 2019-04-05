package com.tkalin.MyTrello_letscode.domain;

import javax.persistence.*;

@Entity
public class Deck {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;

    private String name;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User user;

    public Deck() {
    }

    public Deck(String name, User user) {
        this.name = name;
        this.user = user;
    }

    public String getUserName() {
        return user != null ? user.getUsername() : "<none>";
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}