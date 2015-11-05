/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ea.lenguajes;

import java.util.BitSet;
import java.util.Random;

/**
 *
 * @author Antonio Fernández Ares <antares@ugr.es>
 */
public class EaLenguajes {

    /**
     * @param args the command line arguments
     *
     */
    private static final int ITERATIONS = 100000;
    private static final int MAXLENGTH = 32768;

    public static void mutationBitflip() {

        Random r = new Random();

        for (int length = 16; length <= MAXLENGTH; length = length * 2) {
            BitSet b = new BitSet(length);

            long timestart = System.nanoTime();

            for (int ite = 0; ite < ITERATIONS; ite++) {
                b.flip(r.nextInt(length));
            }

            long timeend = System.nanoTime();

            long estimated = timeend - timestart;

            System.out.println("java-BitSet," + length + " , " + (double) estimated / 1000000000);

            b.clear();
        }
    }

    //TO DO 
    public static void mutationMaxoner() {

        Random r = new Random();

        for (int length = 16; length <= MAXLENGTH; length = length * 2) {
            BitSet b = new BitSet(length);

            long timestart = System.nanoTime();

            for (int ite = 0; ite < ITERATIONS; ite++) {
                b.flip(r.nextInt(length));
            }

            long timeend = System.nanoTime();

            long estimated = timeend - timestart;

            System.out.println("java-bitflip:" + length + " , " + (double) estimated / 1000000000);

            b.clear();
        }
    }

    
    //TO DO
    public static void mutationXOVER() {

        Random r = new Random();

        for (int length = 16; length <= MAXLENGTH; length = length * 2) {
            BitSet b = new BitSet(length);

            long timestart = System.nanoTime();

            for (int ite = 0; ite < ITERATIONS; ite++) {
                b.flip(r.nextInt(length));
            }

            long timeend = System.nanoTime();

            long estimated = timeend - timestart;

            System.out.println("java-bitflip:" + length + " , " + (double) estimated / 1000000000);

            b.clear();
        }
    }

    public static void main(String[] args) {

        mutationBitflip();

    }

}
