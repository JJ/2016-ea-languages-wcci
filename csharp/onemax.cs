using System;
using System.Diagnostics;

namespace onemax
{
	class MainClass
	{
		const uint ITERATIONS = 100000;
		const ushort LENGTH     =  ushort.MaxValue;
		static Random rnd = new Random();

		public static void Main (string[] args)
		{

			for (ushort length = 16; length != 0 ; length <<= 1) {


				bool[] bits = new bool[length];

				for (uint i = 0; i < bits.Length; i++) {
					bits [i] = Convert.ToBoolean (rnd.Next (0, 2));
				}

				Stopwatch stopwatch = Stopwatch.StartNew (); 

				for (uint i = 0; i < length; i++) {
					
					ushort ones =  0;
					if( bits[i])
						ones++;
				}
				stopwatch.Stop ();

				long ticks = stopwatch.ElapsedTicks;
				double s = (double)ticks / Stopwatch.Frequency;

				Console.WriteLine ("{0},{1}",length,s);
			}
		}
	}
}