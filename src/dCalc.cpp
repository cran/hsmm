#include "dCalc.h"

void CalcStoreD()
{
	double x;
	int j, u, v;

	// Store D
	for (j = 0; j <= J
- 1; j++)
	{
		for (u = 1; u <= M; u++)
		{
			x = 0;
			
for (v = u; v <= M; v++)
				x += d[j][v];
			D[j][u] = x;
		
}
		for (u = M + 1; u <= tau; u++)
		{
			D[j][u] = 0;
		}
	
}

	// Store mean_d
	for (j = 0; j <= J - 1; j++)
	{
		x = 0;
		for (v = 0; v <= M; v++)
			x += d[j][v] * v;
		mean_d[j] = x;
	}
}


