Write a ruby program that accepts credit card numbers. Card numbers must be passed in line by line
(one set of numbers per line). The program should print the card in the following format "TYPE: NUMBERS (VALIDITY)".

Card type is identified by the following rules:

+============+=============+===============+
| Card Type  | Begins With | Number Length |
+============+=============+===============+
| AMEX       | 34 or 37    | 15            |
+------------+-------------+---------------+
| Discover   | 6011        | 16            |
+------------+-------------+---------------+
| MasterCard | 51-55       | 16            |
+------------+-------------+---------------+
| Visa       | 4           | 13 or 16      |
+------------+-------------+---------------+

Card numbers are validated by the Luhn algorithm. The steps are:
1. Starting with the next to last digit and continuing with every other digit going back to the beginning of the card,
   double the digit
2. Sum all doubled and untouched digits in the number. For digits greater than nine, split them and sum them 
   independently (i.e. "10", 1 + 0).
3. If that total is a multiple of 10, the number is valid.
