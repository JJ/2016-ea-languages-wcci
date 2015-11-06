<?php
    // Setting "const"
    $ITERATIONS = 100000;
    $MAXLENGTH = 32768;
    
    for( $l=16; $l<=$MAXLENGTH; $l*=2 ) {
        // Initilizing chromosomes
        $b1=$b2="";
        for( $j=0; $j<$l; ++$j ) {
            // Every chromosome is composed of $l randomly generated 0's and 1's
            $b1.=(rand()/getrandmax()<0.5)?"0":"1";
            $b2.=(rand()/getrandmax()<0.5)?"0":"1";
        }
        
        $start=microtime(true);
        for( $i=0; $i<$ITERATIONS;++$i) {
            // Initial point for xover
            $p1=rand(0,$l-2);
            // Final point for xover
            $p2=rand($p1+1, $l-1);
            $tmpB1=$b1;
            // INterchanging information: values at positions $p1 and $p2 are also interchanged
            $b1=substr_replace ( $b1, substr($b2, $p1, $p2-$p1+1), $p1, $p2-$p1+1 );
            $b2=substr_replace ( $b2, substr($tmpB1, $p1, $p2-$p1+1), $p1, $p2-$p1+1 );        }
        $end=microtime(true);
        echo "PHP-bXOver, ".strlen($b1).", ".($end-$start)."\n";
    }
    ?>
