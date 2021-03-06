#include "Indice2D.h"
#include "cudaTools.h"
#include "Device.h"
#include "IndiceTools_GPU.h"

#include "math/RayTracingMath.h"
#include "math/Sphere.h"
using namespace gpu;

 /*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

__global__ void rayTracing(Sphere* ptrDevTabSphere, int nbSphere, uchar4* ptrDevPixels,uint w, uint h,float t);

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

__global__ void rayTracing(Sphere* ptrDevTabSphere,int nbSphere, uchar4* ptrDevPixels, uint w, uint h, float t)
    {
    RayTracingMath rayTracingMath = RayTracingMath(nbSphere, ptrDevTabSphere);

    const int WH=w*h;
    const int TID = Indice2D::tid();
    const int NB_THREAD = Indice2D::nbThread();

    int i;	// in [0,h[
    int j; 	// in [0,w[

    int s = TID;  // in [0,...
    while (s < WH)
	{
	IndiceTools::toIJ(s, w, &i, &j); 	// update (i, j)

	rayTracingMath.colorIJ(&ptrDevPixels[s],i, j, t); 	// update ptrDevPixels[s]

	s += NB_THREAD;
	}
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

