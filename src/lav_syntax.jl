# NOTE: Expect this file to be re-structured away in to a more general file 
# that contains type definitions.

struct ParsedModel 
    lhs
    op
    rhs
    mod_idx 
    block
    fixed
    start 
    lower
    upper
    label
    prior
    efa
end  


function lav_parse_model_string(model_syntax::String)
    # Remove comments up to newline, and keep newline
    model_syntax = replace(model_syntax, r"[#!].*(?=\n)" => "")

    # Replace semi-colon with newline
    model_syntax = replace(model_syntax, ";", "\n")

    # Remove all whitespace 
    model_syntax = replace(model_syntax, "[ \t]+", "")

end 


