package com.tkalin.MyTrello_letscode.domain;

import javax.persistence.*;

@Entity
public class Card {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;

    private String text;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "status_id")
    private DeckStatuses status;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "deck_id")
    private Deck deck;

    private String fileName;

    public Card() {
    }

    public Card(String text, DeckStatuses status, Deck deck) {
        this.text = text;
        this.status = status;
        this.deck = deck;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public DeckStatuses getStatus() {
        return status;
    }

    public void setStatus(DeckStatuses status) {
        this.status = status;
    }

    public Deck getDeck() {
        return deck;
    }

    public void setDeck(Deck deck) {
        this.deck = deck;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
}
