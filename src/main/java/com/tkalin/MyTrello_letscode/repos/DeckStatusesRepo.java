package com.tkalin.MyTrello_letscode.repos;

import com.tkalin.MyTrello_letscode.domain.Deck;
import com.tkalin.MyTrello_letscode.domain.DeckStatuses;
import org.springframework.data.repository.CrudRepository;

public interface DeckStatusesRepo extends CrudRepository<DeckStatuses, Long> {
    Iterable<DeckStatuses> findByDeck(Deck deck);

}
