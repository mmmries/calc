Definitions.

Parenthesis = \(|\)
Whitespace  = [\s\t]
Terminator  = \n|\r\n|\r
Comma       = ,
D           = [0-9]
Operators   = \+|\-|\/|\*
Comparators = ==|>|>=|<=|<

Rules.

{Whitespace}  : skip_token.
{Terminator}  : skip_token.
(\+|\-)?{D}+  : {token,{int,list_to_integer(TokenChars)}}.
(\+|\-)?{D}+\.{D}+((E|e)(\+|\-)?{D}+)? : {token,{float,list_to_float(TokenChars)}}.
{Operators}   : {token, {list_to_atom(TokenChars)}}.
{Comparators} : {token, {list_to_atom(TokenChars)}}.
{Parenthesis} : {token, {list_to_atom(TokenChars)}}.
[A-Za-z]+     : {token, {var, list_to_atom(TokenChars)}}.

Erlang code.

