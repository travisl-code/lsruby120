**Description of game**
21 is a game played with a standard deck of cards (52 cards total, with 4 suits and 13 cards in each suit).
Players are dealt 2 cards from the deck to start, and then they take turns deciding if they want to hit or stay.
The objective of the game is to get as close to (up to/including) 21 as possible, without the value of their cards going over 21.
If a player goes over 21, they lose the game.

Other implementation details I forgot...
- The player takes the first turn. If over 21, they bust and lose
- Dealer draws cards until at least 17 (or over player cards)
- If dealer busts, the player wins
- Player with highest value (that didn't bust) wins, or tie if they're the same

**Nouns and Verbs**
Deck
Cards
Players

Deal
Hit
Stay
Bust

*Organized...*
Deck  - Cards         - Deal

Players - Dealer      - Deal, hit, stay, bust
        - Human       - Hit, stay, bust
        - Computer?


**Basic Turn**
Check point total
Busted?
  - If no, hit or stay (display for human)
    - If hit, add card
    - If stay, break