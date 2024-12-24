---
title: "Testing Mermaid Diagrams in Neovim"
---

[mermaid cheatsheet](https://jojozhuang.github.io/tutorial/mermaid-cheat-sheet/)

This is an example of me trying to render a markdown diagram.

```mermaid
erDiagram
    CUSTOMER }|..|{ DELIVERY-ADDRESS : has
    CUSTOMER ||--o{ ORDER : places
    CUSTOMER ||--o{ INVOICE : "liable for"
    DELIVERY-ADDRESS ||--o{ ORDER : receives
    INVOICE ||--|{ ORDER : covers
    ORDER ||--|{ ORDER-ITEM : includes
    PRODUCT-CATEGORY ||--|{ PRODUCT : contains
    PRODUCT ||--o{ ORDER-ITEM : "ordered in"

```

# Diagram number 2: experimenting with Mermaid "graphs"

```mermaid
graph LR
 a(this is a curved rectangle)
 -->|relationship|b[this is a rectangle]
 --> c>this is an odd shape]
 --> d{this is a rhombus}
 --> e((this is a circle))
```
