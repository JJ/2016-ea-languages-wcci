using System;
using System.Diagnostics;
using System.Linq;

namespace xover
{
	class MainClass
	{
		const uint ITERATIONS = 100000;
		const ushort LENGTH     =  ushort.MaxValue;
		static Random rnd = new Random();

		public static void Main (string[] args)
		{

			for (ushort length = 16; length != 0 ; length <<= 1) {


				bool[] bits1 = new bool[length];
				bool[] bits2 = new bool[length];

				for (uint i = 0; i < length; i++) {
					bits1[i] = Convert.ToBoolean (rnd.Next (0, 2));
					bits2[i] = Convert.ToBoolean (rnd.Next (0, 2));

				}

				Stopwatch stopwatch = Stopwatch.StartNew (); 

				for (int i = 0; i < ITERATIONS; i++) {
					
				


					//  FROM POINT
					int point =  rnd.Next (length);
					for (int j = point; j < length; j++)
						if (Convert.ToBoolean (rnd.Next (0, 2))) {
							bool tmp = bits1 [j];
							bits1 [j] = bits2 [j];
							bits2 [j] = tmp;

						}
					
					/*
					 *  ALL THE ARRAY
					for (int j = 0; j < length; j++)
						if (Convert.ToBoolean (rnd.Next (0, 2))) {
							bool tmp = bits1 [j];
							bits1 [j] = bits2 [j];
							bits2 [j] = tmp;
						
						}
						*/


				}
				    

				stopwatch.Stop ();

				long ticks = stopwatch.ElapsedTicks;
				double s = (double)ticks / Stopwatch.Frequency;

				Console.WriteLine ("{0},{1}",length,s);
			}
		}
	}
}