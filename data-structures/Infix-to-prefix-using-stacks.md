## Infix to prefix notation using stacks

We can easily transform an infix notation, `2 * 3 - 3 + 8 / 4 / (1 + 1)`, to a prefix one `(+ - * 2 3 3 / / 8 4 + 1 1)` with two queues:

These are the steps:
 1) Reverse the expression, and the parenthesis, brackets and so on, e.g. `(1 + 2) * 2` reversed would be `2 * ) 2 + 1 (` 
 2) Traverse the reversed expression
   2.1) if it is a closing parenthesis, push to the operator stack
   2.2) if it is an opening parenthesis, push the operators on the operator stack until the closing bracket
   2.3) if it is an operator
     2.3.1) if the operator has equal or greater precedence then the top operator, push the operator
     2.3.2) if the operator has less precedence, push on the infix stack until one has greater precedence
   2.4) if it is an operand, push to the infix stack
 3) Reverse the infix stack
   
   
So, given `2 * 3 - 3 + 8 / 4 / (1 + 1)`, and its reverse `) 1 + 1 ( / 4 / 8 + 3 - 3 * 2` 

|input   |operator    |infix         |
|--------|------------|--------------|
|)       |)           |              |
|1       |)           |1             |
|+       |)+          |1             |
|1       |)+          |11            |
|(       |            |11+           |
|/       |/           |11+           |
|4       |/           |11+4          |
|/       |//          |11+4          |
|8       |//          |11+48         |
|+       |+           |11+48//       |
|3       |+           |11+48//3      |
|-       |+-          |11+48//3      |
|3       |+-          |11+48//33     |
|*       |+-*         |11+48//33     |
|2       |+-*         |11+48//332    |
|        |+-*         |11+48//332*-+ |

The result is `+ - * 2 3 3 / / 8 4 + 1 1`, with parenthesis it is easier to understand: `(+ (- (* 2 3) 3) (/ (/ 8 4) (+ 1 1)))`

