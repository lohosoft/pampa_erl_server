-module (myutils).

-export ([binary_to_hexstring/1]).

binary_to_hexstring(B) when is_binary(B) ->
    T = {$0,$1,$2,$3,$4,$5,$6,$7,$8,$9,$a,$b,$c,$d,$e,$f},
    << <<(element(X bsr 4 + 1, T)), (element(X band 16#0F + 1, T))>>
    || <<X:8>> <= B >>.