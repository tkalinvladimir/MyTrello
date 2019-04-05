package com.tkalin.MyTrello_letscode.repos;

import com.tkalin.MyTrello_letscode.domain.Deck;
import com.tkalin.MyTrello_letscode.domain.User;
import org.springframework.data.repository.CrudRepository;

public interface DeckRepo extends CrudRepository<Deck, Long> {
    Iterable<Deck> findByUser(User user);
}
