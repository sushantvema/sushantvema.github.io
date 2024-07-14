---
title: "Beancount: Double-Entry Accounting from Text Files."
description: "My learnings about a useful plaintext-based accounting framework."
author: "Sushant Vema"
date_created: "2024-07-12T16:35:56"
date: "2024-07-12T16:35:59"
tags:
  - "evergreen"
publish: true
---
# Command-line Accounting in Context
[reference](https://beancount.github.io/docs/command_line_accounting_in_context.html).

Everyone wants to better wrangle their finances but very few people want to go into the weeds and establish a process.

People who ask "why bother?" are typically those who mentally oversimplify the complexities of their financial lives. 

> The fact is, the double-entry method is a basic technique that everyone should have been taught in high school. And using it for yourself is a simple and powerful process you can use to drive your entire financial life. 

# What exactly is "Accounting"?
An implicit reference to one or more distinct financial processes:

- **Bookkeeping**: Having past transactions in a single location. Also called a "ledger" commonly. This usually entails copying the amounts and categories of financial transactions which take place in external account statements into a single system unifying all of these accounts. 
- **Invoices:** Preparing invoices and tracking pending payments. Highly pertinent to contractors. If you're manaing a company's finances, processing payroll is heavy in bookkeeping. 
- **Taxes:** Finding or assessing taxable income; filling out tax forms and filings. An arduous process of adult life. When personal assets start to increase in complexity (many types of accounts, increasing reporting requirements), can be stressful. 
- **Expenses:** "Where is my money going?" This develops awareness.  
- **Budgeting:** Forecasting future expenses; allocating limited amounts for categorical spending; tracking how close actual spend is to these allocations. Usually for paying down debt or finding ways to save more. For companies, this is usually for planning for various projects. 
- **Reporting:** Public companies have regulatory requirements to show transparency to their investors. They usually report an annual income statement as well as a balance sheet for the beginning and the end. These same reports are useful when applying for a personal loan or a mortgage at a bank. Provide a window to someone's financial health.

# What can it do for me?
- **I have some cash to invest. Given my portfolio, where should I invest it?** Being able to report on the totality of your holdings, you can determine your asset class and currency exposures. This can help you decide where to place new savings in order to match a target portfolio allocation. 
- **How much am I worth?** Say you have a 401k, an IRA, and taxable accounts. A remaining student loan or maybe sitting on real-estate with two mortgages. What's the total? It's really nice to obtain a single number telling you how far you are from retirement goals. Beancount can easily compute net worth to the cent.
- **Taxes suck.** They suck because of uncertainty and doubt. "It's not fun to not know what's going on." For some people there's a single stream of income, but for many others, it gets complicated. Qualified vs ordinary dividends, long-term vs short-term capital gains, income from secondary sources, etc. When it's time to do taxes, you can bring up the year's income statement and a clear list of items to put in and deductions to make.
- **Want to buy a home. How much can I gather for a down payment?** Can produce a list of all holdings and can aggregate them by liquidity. 
- **Impress the banker.** Just bring your balance sheet. Freshly generated from the morning.
- **Instructions for your eventual passing**. Making a will involves listing your assets. Make your children's lives easier should you pass by having a full list of the beans to pass on or be collected. Amounts are just part of the story. Being able to list all of the accounts and institutions will make it easier for someone to clear your assets. 
- **Can't remember if I was paid.** If you send invoices and have receivables, nice to have a method to track who has paid and who just says they'll pay.

# Keeping Books
The central and most basic activity providing support for all others is bookkeeping. Copying all financial transactions into single integrated system lets you produce reports that solve all other problems. 

> You are building a corpus of data, a list of dated transaction objects that each represents movements of money between some of the accounts that you own. This data provides a full timelines of your financial activity.

All it takes is to enter each transaction while respecting a simple constraint. The [double entry method](https://en.wikipedia.org/wiki/Double-entry_bookkeeping).
> Each time an amount is posted to an account, it must have a corresponding inverse amount posted to some other account(s), and the sum of these amounts must be zero.

An ensemble of transactions that respects this constraint acquires nice properties which are discussed later.

All accounts are further labeled with one of four categories:
  - Assets
  - Liabilities
  - Income
  - Expenses
  - Equity (summarizes history of all previous income and expense transactions)

Command-line accounting systems are simplistic computer languages which basically add any kind of "thing" in dedicated counters ("accounts"). 

The text file is the input to a command-line accounting system. Here's an example:

```text
2014-05-23 * "CAFE MOGADOR  NEW YO" "Dinner with Caroline"
  Liabilities:US:BofA:CreditCard    -98.32 USD
  Expenses:Restaurant
```

This transaction has two "postings" or "legs". `Expenses:Restaurant` is an account, not a category. Accounts often act like categories. Amount on expenses tag is left unspecified, a convenience allowed by the input language.

Most institutions provide a downloadable summary of account activity. Most transaction details are automatically pulled in from downloaded file, using csript converting to above syntax. 
- Transaction date is always available from downloable files
- the "`CAFE MOGADOR NEW YO`" part is the "memo", provided by downloaded file. 
- Manually can add comments. 
- Importer brought in the `Liabilities:US:BofA:CreditCard` parting with the amount automatically. Had to insert `Expenses:Restaurant` manually. Everything can be automated. 

Syntax also allows to represent stock purchases and sales, tracking cost basis of assets, and other stuff. Can define and count any kind of "thing" in an account. Like "vacation hours accumulated". This is the essence of what command-line accounting can enable you to do. 

The author replicated all the transactions from accounts like this, mostly automated. 

Every couple of weeks spend 1-2 hours to update this input file. Only for most used accounts (credit card and checking accounts). 

You obtain a full history, a complete timeline of all of the financial transactions from all the accounts over time, often connected together, in a single text file.


