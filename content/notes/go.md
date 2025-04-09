---
title: The Ancient Game of Go
description: My learnings on how to play Go
date_created: 2025-04-08T14:45:00
date: 2025-04-08T14:45:02
publish: true
author: Sushant Vema
tags:
  - resource
---

Go is a game that is played on a square grid of lines, typically 19
intersections to a side. 13x13 and 9x9 are also common.

For beginners, smaller boards are recommended.

There are two players, each using a set of black and white stones respectively.

## Objective

Win by surrounding the most territory by the end of the game.

## Rules

There are 4 main rules to this game.

### 1) Game Flow

- Black begins in standard matches
- Each player takes a turn to place a single stone on any of the intersections.
- Stoned placed on the board stay on that intersection UNLESS they are captured
  by the opponent.

### 2) Capturing of Stones

- The empty intersections immediately adjacent to a stone are called
  **liberties**. Liberties are NOT the diagonal intersections, only the adjacent
  ones
  - A stone in the middle of the board has 4 liberties
  - A stone in the side of the board has 3 liberties
  - A stone in the corner of the board has only 2 liberties
- Stones that have all of their liberties occupied by stone of the opposite
  color are considered **captured** and taken by the opponent.
- Adjacent-connected stones of the same color share their liberties, and if
  captured, are captured as a group.
- A group that is under threat of being captured (having only one liberty) are
  said to be in **atari**
- You are not allowed to play stones in intersections where it would be
  immediately captured by the opponent.

### 3) _Ko_ - Eternity

- You may not immediately replicate a previous board position.
  - Unlike chess which allows for players to repeat moves and thereby force a
    draw, Go does not allow draws by repetition due to the Ko Rule
- However, after 2 turns of placing stones elsewhere on the board, a previous
  position can be repeated. This often leads to _"Ko Fights"_

### 4) Concluding the game

- If a player feels like they have no more worthwhile moves to play, they can
  pass.
- If both players pass in succession, the game ends.
- Dead stones are immediately removed from the game as "captured"
- Territory is then counted for each player as the number of intersections
  surrounded by their stones
- A point counts as a territory when it can only reach stones of a single
  player's color.
- The scores are then reduced by the number of one's stones captured by the
  opponent. This is frequently done by placing those captured stoned in one's
  territories.
- In games against evenly matched opponents, the white player is given an
  advantage in points as compensation for going second. This is usually 6.5 or 7.5
  points, with a half point for breaking ties. This is called **Komi**
  - For more uneven matchups, white is given a smaller komi
  - Sometimes black will get to start with multiple stones on the board

## On Life and Death

- As an implication of Rule 1 and Rule 2, a group is considered **alive** if
  they can make 2 eyes.

## Ko Fights

- Good evaluation of ko fights is difficult because of how difficult it can be
  to evaluation points on the board.

## Position Evaluation

- Positional evaluation is critical in the game of Go

## Resources

- [Go - Basic Rukes (Udacity YT)](https://www.youtube.com/watch?v=5PTXdR8hLlQ)
- [Go - Life and Death (Udacity YT)](https://www.youtube.com/watch?v=YPMog4LAmvg)
