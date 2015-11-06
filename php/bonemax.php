<?php
    $ITERATIONS = 100000;
    $MAXLENGTH = 65536;
    
    for( $l=16; $l<=$MAXLENGTH; $l*=2 ) {
        $start=microtime(true);
        for( $i=0; $i<$ITERATIONS;++$i) {
            $b="";
            $ones=0;
            for( $j=0; $j<$l; ++$j ) $b.=(rand()/getrandmax()<0.5)?"0":"1";
            for( $j=0; $j<$l; ++$j ) $ones+=$b[$j]=="1";
        }
        $end=microtime(true);
        echo "PHP-bitstring, ".strlen($b).", ".($end-$start)."\n";
    }
    ?>
