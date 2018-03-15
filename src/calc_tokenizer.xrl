Definitions.

Whitespace = [\s\t]
Terminator = \n|\r\n|\r
Comma      = ,
Dot        = \.
D               = [0-9]

Rules.

{Whitespace} : skip_token.
{Terminator} : skip_token.
(\+|\-)?{D}+ : {token,{int,list_to_integer(TokenChars),TokenLine}}.
(\+|\-)?{D}+\.{D}+((E|e)(\+|\-)?{D}+)? : {token,{float,list_to_float(TokenChars),TokenLine}}.

Erlang code.

