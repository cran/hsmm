#include "InitData.h"
#include "matrix.h"
#include "cube.h"
#include "error.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <iostream>
#include <fstream>
#include <sstream>



int InitInputData(char inputFilename[], double InputData[])
{
	int i;
	char str[100];
	FILE *stream;

	stream = fopen(inputFilename, "r" );
	i = 0;
	while (fgets(str, 100, stream) != NULL)
	{
		InputData[i] = atof(str);
		i++;
	}
    fclose(stream);

	return i;
}


void InitParaAndVar(int CensoringPara, 
					int tauPara, int JPara, int MPara, double dPara[], 
					double pPara[], double piPara[], double pdfPara[])
{
	int i, j, u;
	ofstream init_strm;

	if (DEBUG_OUTPUT)
	{
		init_strm.open("C:/Init.txt");
		if (init_strm.fail())
		{
			stringstream ss;
			ss << "init_strm";
			throw file_exception(ss.str());
			
		}
	}

	Censoring = CensoringPara;

	tau = tauPara;
	J = JPara;
	M = MPara;

	#if DEBUG_ARRAY_STATIC == 0
		StateIn = matrix<double>(J, tau);
		if (StateIn == NULL)
		{
			stringstream ss;
			ss << "StateIn";
			throw memory_exception(ss.str());
		}

		F = matrix<double>(J, tau);
		if (F == NULL)
		{
			stringstream ss;
			ss << "F";
			throw memory_exception(ss.str());
		}

		L = matrix<double>(J, tau); 
		if (L == NULL)
		{
			stringstream ss;
			ss << "L";
			throw memory_exception(ss.str());
		}

		G = matrix<double>(J, tau); 
		if (G == NULL)
		{
			stringstream ss;
			ss << "G";
			throw memory_exception(ss.str());
		}

		H = cube<double>(J, tau, M + 1);
		if (H == NULL)
		{
			stringstream ss;
			ss << "H";
			throw memory_exception(ss.str());
		}

		L1 = matrix<double>(J, tau); 
		if (L1 == NULL)
		{
			stringstream ss;
			ss << "L1";
			throw memory_exception(ss.str());
		}

		N = new double[tau];
		if (N == NULL)
		{
			stringstream ss;
			ss << "N";
			throw memory_exception(ss.str());
		}

		Norm = matrix<double>(J, tau);  
		if (Norm == NULL)
		{
			stringstream ss;
			ss << "Norm";
			throw memory_exception(ss.str());
		}

		d = matrix<double>(J, M + 1);
		if (d == NULL)
		{
			stringstream ss;
			ss << "d";
			throw memory_exception(ss.str());
		}

		if (M + 1 > tau)
			D = matrix<double>(J, M + 1);
		else
			D = matrix<double>(J, tau + 1);
		if (D == NULL)
		{
			stringstream ss;
			ss << "D";
			throw memory_exception(ss.str());
		}

		mean_d = new double[J];
		if (mean_d == NULL)
		{
			stringstream ss;
			ss << "mean_d";
			throw memory_exception(ss.str());
		}

		p = matrix<double>(J, J);
		if (p == NULL)
		{
			stringstream ss;
			ss << "p";
			throw memory_exception(ss.str());
		}

		pi = new double[J];
		if (pi == NULL)
		{
			stringstream ss;
			ss << "pi";
			throw memory_exception(ss.str());
		}

		eta = matrix<double>(J, M + 1);  
		if (eta == NULL)
		{
			stringstream ss;
			ss << "eta";
			throw memory_exception(ss.str());
		}

		xi = matrix<double>(J, M + 1);  
		if (xi == NULL)
		{
			stringstream ss;
			ss << "xi";
			throw memory_exception(ss.str());
		}

		alpha = matrix<double>(J, tau);
		if (alpha == NULL)
		{
			stringstream ss;
			ss << "alpha";
			throw memory_exception(ss.str());
		}

		maxI = matrix<int>(J, tau);
		if (maxI == NULL)
		{
			stringstream ss;
			ss << "maxI";
			throw memory_exception(ss.str());
		}

		maxU = matrix<int>(J, tau);
		if (maxU == NULL)
		{
			stringstream ss;
			ss << "maxU";
			throw memory_exception(ss.str());
		}

		pdf = matrix<double>(J, tau);
		if (pdf == NULL)
		{
			stringstream ss;
			ss << "pdf";
			throw memory_exception(ss.str());
		}

		hiddenStates = new int[tau];
		if (hiddenStates == NULL)
		{
			stringstream ss;
			ss << "hiddenStates";
			throw memory_exception(ss.str());
		}
	#endif

	for (j = 0; j <= J - 1; j++)
	{
		pi[j] = piPara[j];
	}

	for (j = 0; j <= J - 1; j++)
		for (u = 0; u <= M - 1; u++)
		{
			d[j][u + 1] = dPara[j * M + u];
		}

	for (i = 0; i <= J - 1; i++)
		for (j = 0; j <= J - 1; j++)
		{
			p[i][j] = pPara[i * J + j];
		}

	for (j = 0; j <= J - 1; j++)
		for (u = 0; u <= tau - 1; u++)
		{
			pdf[j][u] = pdfPara[j * tau + u];
		}

	switch (Censoring)
	{
		case noCensoring:
		{
			LeftCensoring = false;
			RightCensoring = false;
			break;
		}
		case rightCensoring:
		{
			LeftCensoring = false;
			RightCensoring = true;
			break;
		}
		case leftRightCensoring:
		{
			LeftCensoring = true;
			RightCensoring = true;
			break;
		}
	}
}


void freeMemory()
{
#if DEBUG_ARRAY_STATIC == 0
	if (StateIn != NULL) free_matrix(StateIn);
	if (F != NULL) free_matrix(F);
	if (L != NULL) free_matrix(L); 
	if (G != NULL) free_matrix(G); 
	if (H != NULL) free_cube(H);
	if (L1 != NULL) free_matrix(L1);  
	if (N != NULL) delete [] N;
	if (Norm != NULL) free_matrix(Norm);  
	if (d != NULL) free_matrix(d); 
	if (D != NULL) free_matrix(D); 
	if (mean_d != NULL) delete [] mean_d;
	if (p != NULL) free_matrix(p);  
	if (pi != NULL) delete [] pi;  																																																																																			
	if (eta != NULL) free_matrix(eta);  																																																																																	 
	if (xi != NULL) free_matrix(xi);  																																																																																	 
	if (alpha != NULL) free_matrix(alpha);
	if (maxI != NULL) free_matrix(maxI);
	if (maxU != NULL) free_matrix(maxU);	
	if (pdf != NULL) free_matrix(pdf);
#endif
}
