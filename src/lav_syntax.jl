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
    model_syntax = replace(model_syntax, ";" => "\n")

    # Remove all whitespace 
    model_syntax = replace(model_syntax, "[ \t]+" => "")

    # Remove occurrence of >= 2 consecutive newlines to eliminate blank 
    # statements; this retains blank newline at the beginning, if such exists, 
    # but parser will not choke because of start.idx
    model_syntax = replace(model_syntax, "\n{2,}" => "\n")
    
    # break up in lines
    model = split(model_syntax, "\n")

    # check for multi-line formulas: they contain no operator symbol
    # but before we do that, we remove all strings between double quotes
    # to avoid confusion with for example equal("f1=~x1") statements
    # model.simple <- gsub("\\(.*\\)\\*", "MODIFIER*", model)
    model_simple <- replace(model, r"\\\".[^\\\"]*\\\"" => "LABEL")

    operators = ["=~", "<~", "~*~", "~~", "~", "==", "<", ">", ":=", ":", "\\|", "%"]
    lhs_modifiers = ["efa"]
    operators_extra = vcat(operators, lhs_modifiers)

    # start_idx = Regex(join(operators_extra, "|"))
    model
end 


