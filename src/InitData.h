#ifndef INITDATA
	#define INITDATA

	#include "Main.h"
	#include "matrix.h"
	#include "cube.h"
	#include <stdio.h>
	#include <vector>

	using namespace std;

	#if DEBUG_ARRAY_STATIC	
		extern double StateIn[MaxJ][MaxTau]; 
		extern double F[MaxJ][MaxTau]; 
		extern double L[MaxJ][MaxTau]; 
		extern double G[MaxJ][MaxTau]; 
		extern double H[MaxJ][MaxTau][MaxRunlength + 1];
		extern double L1[MaxJ][MaxTau];  
		extern double N[MaxTau];  
		extern double Norm[MaxJ][MaxTau];  
		extern double d[MaxJ][MaxRunlength + 1]; 
		extern double D[MaxJ][MaxTau + 1]; 
		extern double mean_d[MaxJ];
		extern double p[MaxJ][MaxJ];   
		extern double pi[MaxJ];  																																																																																							
		extern double eta[MaxJ][MaxRunlength];  																																																																																	 
		extern double xi[MaxJ][MaxRunlength];  																																																																																	 
		extern double alpha[MaxJ][MaxTau];
		extern int maxI[MaxJ][MaxTau];
		extern int maxU[MaxJ][MaxTau];
		extern double pdf[MaxJ][MaxTau];
		extern int hiddenStates[MaxTau];
	#else
		extern double** StateIn;
		extern double** F;
		extern double** L; 
		extern double** G; 
		extern double*** H;
		extern double** L1;  
		extern double* N;  
		extern double** Norm;  
		extern double** d; 
		extern double** D;  
		extern double* mean_d;
		extern double** p;
		extern double* pi;  																																																																																						 																																																																																						
		extern double** eta;  																																																																																	 
		extern double** xi;  																																																																																	 
		extern double** alpha;
		extern int** maxI;
		extern int** maxU;
		extern double** pdf;
		extern int* hiddenStates;
	#endif

	extern int J, Y, tau, M;
	extern int Censoring, Output;
	extern bool LeftCensoring, RightCensoring;
	extern ofstream log_strm;

	int InitInputData(char inputFilename[], double InputData[]);
	void InitOutputData(char outputPath[]);
	void InitParaAndVar(int CensoringPara, int tauPara, int JPara, 
						int MPara, double dPara[], double pPara[], double piPara[], double pdfPara[]);
	void freeMemory();

#endif
