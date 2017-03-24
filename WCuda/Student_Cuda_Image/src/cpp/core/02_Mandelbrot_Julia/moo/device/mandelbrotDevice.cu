#include "Indice2D.h"
#include "cudaTools.h"
#include "Device.h"
#include "IndiceTools_GPU.h"
#include "DomaineMath_GPU.h"
#include "MandelbrotMath.h"

using namespace gpu;

/*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

__global__ void mandelbrot(uchar4* ptrDevPixels, uint w, uint h, float t, DomaineMath domaineMath);

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

/*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

__global__ void mandelbrot(uchar4* ptrDevPixels, uint w, uint h, float t, DomaineMath domaineMath)
    {
    MandelbrotMath mandelbrotMath = MandelbrotMath(t);

    const int TID = Indice2D::tid();
    const int NB_THREAD = Indice2D::nbThread();
    const int WH = w * h;

    int s = TID;
    int i, j;
    double x, y;
    while (s < WH)
	{
	IndiceTools::toIJ(s, w, &i, &j);
	domaineMath.toXY(i, j, &x, &y);

	mandelbrotMath.colorXY(&ptrDevPixels[s], x, y, t);
	s += NB_THREAD;
	}
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

