{ lib, ... }:
{
  toTitle = s: lib.concatStrings (
    map (w:
      if w == []
        then " " # Split turns all spaces into []
        else
          let
            word = lib.stringToCharacters w;
          in
            lib.concatStrings (
              # Upper case the first letter
              [ (lib.strings.toUpper (builtins.head word)) ] ++
                # And combine it with the rest
              (builtins.tail word))
            )
    (builtins.split " " s)
  );
};
