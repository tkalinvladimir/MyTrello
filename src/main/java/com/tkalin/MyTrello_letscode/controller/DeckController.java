package com.tkalin.MyTrello_letscode.controller;

import com.tkalin.MyTrello_letscode.domain.Deck;
import com.tkalin.MyTrello_letscode.domain.DeckStatuses;
import com.tkalin.MyTrello_letscode.repos.DeckRepo;
import com.tkalin.MyTrello_letscode.repos.DeckStatusesRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
public class DeckController {
    @Autowired
    private DeckRepo deckRepo;
    @Autowired
    private DeckStatusesRepo deckStatusesRepo;

    @GetMapping("/deck/{deck}")
    public String deckEditForm(@PathVariable Deck deck, Model model) {
        model.addAttribute("deck", deck);

        Iterable<DeckStatuses> deckStatuses = deckStatusesRepo.findByDeck(deck);
        model.addAttribute("deck_statuses", deckStatuses);

        //дел

        model.addAttribute("deckstatus1", 7L);

        return "deckEdit";
    }

    @PostMapping("/deck")
    public String deckSave(
            @RequestParam String deckname,
            @RequestParam Map<String, String> form,
            @RequestParam("deckId") Deck deck
    ) {
        deck.setName(deckname);
        deckRepo.save(deck);

        return "redirect:/main";
    }

    @PostMapping("/deckDel")
    public String deckDel(
            @RequestParam Map<String, String> form,
            @RequestParam("deck_id") Deck deck
    ) {
        deckRepo.deleteById(deck.getId());
        return "redirect:/main";
    }

    @PostMapping("/deckStatusAdd")
    public String deckStatusSave(
            @RequestParam String deckstatus,
            @RequestParam Map<String, String> form,
            @RequestParam("deckId") Deck deck
    ) {
        DeckStatuses deckStatus = new DeckStatuses(deckstatus, deck);
        deckStatusesRepo.save(deckStatus);

        return "redirect:/deck/"+deck.getId();
    }

    @PostMapping("/deckStatusDel")
    public String deckStatusDelete(
            @RequestParam Long deckstatusid,
            @RequestParam("deckId") Deck deck
    ) {
        deckStatusesRepo.deleteById(deckstatusid);
        return "redirect:/deck/"+deck.getId();
    }
}
