package com.tkalin.MyTrello_letscode.controller;

import com.tkalin.MyTrello_letscode.domain.Card;
import com.tkalin.MyTrello_letscode.domain.Deck;
import com.tkalin.MyTrello_letscode.domain.DeckStatuses;
import com.tkalin.MyTrello_letscode.domain.User;
import com.tkalin.MyTrello_letscode.repos.CardRepo;
import com.tkalin.MyTrello_letscode.repos.DeckRepo;
import com.tkalin.MyTrello_letscode.repos.DeckStatusesRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Controller
public class DeckViewController {
    @Autowired
    private DeckRepo deckRepo;
    @Autowired
    private CardRepo cardRepo;
    @Autowired
    private DeckStatusesRepo deckStatusesRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/deck_view/{deck}")
    public String deckEditForm(@AuthenticationPrincipal User user,
                               @PathVariable Deck deck,
                               Model model) {
        model.addAttribute("deck", deck);

        // get decks only for acceptable user
        if (deck.getUser().getId() != user.getId()) {
            return "redirect:/main";
        }
        //

        Iterable<Card> cards = cardRepo.findByDeck(deck);
        model.addAttribute("cards", cards);

        Iterable<DeckStatuses> statuses = deckStatusesRepo.findByDeck(deck);
        model.addAttribute("available_statuses", statuses);

        return "deckView";
    }

    @PostMapping("/addCard")
    public String addCart(
            @Valid Card card,
            BindingResult bindingResult,
            Model model,
            @RequestParam("deckstatus_id") DeckStatuses deckStatuses,
            @RequestParam Map<String, String> form,
            @RequestParam("deckId") Deck deck,
            @RequestParam("file")MultipartFile file

            ) throws IOException {

        card.setStatus(deckStatuses);
        card.setDeck(deck);

        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);

            model.mergeAttributes(errorsMap);
            model.addAttribute("card", card);
        } else {

            if (file != null && !file.getOriginalFilename().isEmpty()) {
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                String uuidFile = UUID.randomUUID().toString();
                String resultFileName = uuidFile + "." + file.getOriginalFilename();
                file.transferTo(new File(uploadPath + "/" + resultFileName));
                card.setFileName(resultFileName);
            }
            model.addAttribute("card", null);

            cardRepo.save(card);
        }
            return "redirect:/deck_view/" + deck.getId();

    }

    @PostMapping("/cardDel")
    public String cardDelete(
            @RequestParam Long card_id,
            @RequestParam("deckId") Deck deck
    ) {
        cardRepo.deleteById(card_id);
        return "redirect:/deck_view/"+deck.getId();
    }

    @PostMapping("/cardChange")
    public String cardChangeText(
            @RequestParam("id") Card card,
            @RequestParam String text,
            @RequestParam("deckId") Deck deck
    ) {

        card.setText(text);
        cardRepo.save(card);

        return "redirect:/deck_view/"+deck.getId();
    }

    @PostMapping("/cardChangeStatus")
    public String cardChangeStatus(
            @RequestParam("id") Card card,
            @RequestParam("status") DeckStatuses status,
            @RequestParam("deckId") Deck deck
    ) {

        card.setStatus(status);
        cardRepo.save(card);

        return "redirect:/deck_view/"+deck.getId();
    }


}
