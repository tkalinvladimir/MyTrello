package com.tkalin.MyTrello_letscode.repos;

import com.tkalin.MyTrello_letscode.domain.Card;
import com.tkalin.MyTrello_letscode.domain.Deck;
import org.springframework.data.repository.CrudRepository;

public interface CardRepo extends CrudRepository<Card, Long> {
    Iterable<Card> findByDeck(Deck deck);
}
