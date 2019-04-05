package com.tkalin.MyTrello_letscode.controller;


import com.tkalin.MyTrello_letscode.domain.Deck;
import com.tkalin.MyTrello_letscode.domain.User;
import com.tkalin.MyTrello_letscode.repos.DeckRepo;
import com.tkalin.MyTrello_letscode.repos.MessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
public class MainController {
    @Autowired
    private MessageRepo messageRepo;
    @Autowired
    private DeckRepo deckRepo;

    @GetMapping("/")
    public String greeting(Map<String, Object> model) {
        return "greeting";
    }

    @GetMapping("/main")
    public String main(@AuthenticationPrincipal User user,Model model) {
        Iterable<Deck> decks = deckRepo.findByUser(user);
        model.addAttribute("decks", decks);
        return "main";
    }

    @PostMapping("/main")
    public String add(
            @AuthenticationPrincipal User user,
            @RequestParam String name,
            Map<String, Object> model
    ) {
        Deck deck = new Deck(name, user);

        deckRepo.save(deck);

        Iterable<Deck> decks = deckRepo.findByUser(user);

        model.put("decks", decks);

        return "main";
    }
}