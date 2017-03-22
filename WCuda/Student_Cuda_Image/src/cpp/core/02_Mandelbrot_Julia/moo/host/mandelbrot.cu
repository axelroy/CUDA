#include "mandelbrot.h"

#include <iostream>
#include <assert.h>

#include "Device.h"
#include <assert.h>

using std::cout;
using std::endl;

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Imported	 	*|
 \*-------------------------------------*/

extern __global__ void mandelbrot(uchar4* ptrDevPixels, uint w, uint h, float t, DomaineMath domaineMath);

/*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

/*-------------------------*\
 |*	Constructeur	    *|
 \*-------------------------*/

Mandelbrot::Mandelbrot(uint nMin, uint nMax, const Grid& grid, uint w, uint h, const DomaineMath& domaineMath) :
	Animable_I<uchar4>(grid, w, h, "Mandelbrot_Cuda_RGBA_uchar4", domaineMath), variateurAnimation(Interval<float>(nMin, nMax), 1.f)
    {
    // Tools
    this->t = nMin; // protected dans Animable
    }

Mandelbrot::~Mandelbrot()
    {
    // rien
    }

/*-------------------------*\
 |*	Methode		    *|
 \*-------------------------*/

/**
 * Override
 * Call periodicly by the API
 *
 * Note : domaineMath pas use car pas zoomable
 */
void Mandelbrot::process(uchar4* ptrDevPixels, uint w, uint h, const DomaineMath& domaineMath)
    {
    Device::lastCudaError("mandelbrot rgba uchar4 (before kernel)"); // facultatif, for debug only, remove for release

    t = variateurAnimation.get();
    mandelbrot <<<dg,db>>>(ptrDevPixels,w,h,t,domaineMath);

    // le kernel est importer ci-dessus (ligne 19)

    Device::lastCudaError("mandelbrot rgba uchar4 (after kernel)"); // facultatif, for debug only, remove for release

    Device::synchronize(); // Temp,debug, only for printf in  GPU
    }

/**
 * Override
 * Call periodicly by the API
 */
void Mandelbrot::animationStep()
    {
    t = variateurAnimation.varierAndGet();
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

