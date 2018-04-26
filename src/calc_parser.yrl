Terminals
  float
  int
  var
  '+'
  '-'
  '*'
  '/'
  '('
  ')'
  '>'
  '>='
  '<'
  '<='
.

Nonterminals
  expression
.

Left 1 '>' '>=' '<=' '<'.
Left 2 '+' '-'.
Left 3 '*' '/'.

Rootsymbol expression.

expression -> '(' expression ')' : '$2'.
expression -> expression '*' expression : {'*', [], ['$1', '$3']}.
expression -> expression '+' expression : {'+', [], ['$1', '$3']}.
expression -> expression '-' expression : {'-', [], ['$1', '$3']}.
expression -> expression '/' expression : {'/', [], ['$1', '$3']}.
expression -> expression '>' expression : {'>', [], ['$1', '$3']}.
expression -> expression '>=' expression : {'>=', [], ['$1', '$3']}.
expression -> expression '<' expression : {'<', [], ['$1', '$3']}.
expression -> expression '<=' expression : {'<=', [], ['$1', '$3']}.
expression -> int : value('$1').
expression -> float : value('$1').
expression -> var : {'var!', [], [{value('$1'), [], 'Elixir'}]}.

Erlang code.

value({_type, Value}) -> Value.
