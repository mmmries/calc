Definitions.

Whitespace  = [\s\t]
Terminator  = \n|\r\n|\r
Comma       = ,
D           = [0-9]
Operators   = \+|\-|\/|\*
Comparators = ==|>|>=|<=|<

Rules.

{Whitespace}  : skip_token.
{Terminator}  : skip_token.
(\+|\-)?{D}+  : {token,{int,list_to_integer(TokenChars),TokenLine}}.
(\+|\-)?{D}+\.{D}+((E|e)(\+|\-)?{D}+)? : {token,{float,list_to_float(TokenChars),TokenLine}}.
{Operators}   : {token, {list_to_atom(TokenChars), TokenLine}}.
{Comparators} : {token, {list_to_atom(TokenChars), TokenLine}}.

Erlang code.

