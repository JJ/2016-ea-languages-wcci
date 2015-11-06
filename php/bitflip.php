<?php
    $ITERATIONS = 100000;
    $MAXLENGTH = 32768;
    for( $l=16; $l<=$MAXLENGTH; $l*=2 ) {
        $b="";
        for( $i=0; $i<$l; ++$i ) $b.=(rand()/getrandmax()<0.5)?"0":"1";
        $start=microtime(true);
        for( $i=0; $i<$ITERATIONS;++$i) {
            $b[$aleat=rand(0,$l-1)]=($b[$aleat]=="0")?"1":"0";
        }
        $end=microtime(true);
        echo "    PHP-bitflip, ".strlen($b).", ".($end-$start)."\n";
    }
    ?>
