package com.tkalin.MyTrello_letscode.domain;

import javax.persistence.*;

@Entity
public class DeckStatuses {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;

    private String status;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "deck_id")
    private Deck deck;

    public DeckStatuses() {
    }

    public DeckStatuses(String status, Deck deck) {
        this.status = status;
        this.deck = deck;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Deck getDeck() {
        return deck;
    }

    public void setDeck(Deck deck) {
        this.deck = deck;
    }
}
