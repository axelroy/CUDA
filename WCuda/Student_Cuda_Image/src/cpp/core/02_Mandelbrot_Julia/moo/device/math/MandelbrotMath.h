#pragma once

#include <math.h>
#include "MathTools.h"

#include "ColorTools_GPU.h"
#include "Calibreur_GPU.h"

using namespace gpu;

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

class MandelbrotMath
    {

	/*--------------------------------------*\
	|*		Constructor		*|
	 \*-------------------------------------*/

    public:

	__device__ MandelbrotMath(uint n) :
		calibreur(Interval<float>(0.f, n), Interval<float>(0.f, 1.f))
	    {
	    this->n = n;
	    }

	// constructeur copie automatique car pas pointeur dans VagueMath

	__device__
	     virtual ~MandelbrotMath()
	    {
	    // rien
	    }

	/*--------------------------------------*\
	|*		Methodes		*|
	 \*-------------------------------------*/

    public:

	__device__
	void colorXY(uchar4* ptrColor, float x, float y, int t)
	    {
	    float z = f(x, y, t);

	    if (z == t)
		{
		ptrColor->x = 0;
		ptrColor->y = 0;
		ptrColor->z = 0;
		}
	    else
		{
		float hue01 = z;
		calibreur.calibrer(hue01);
		ColorTools::HSB_TO_RVB(hue01, ptrColor); // update color
		}
	    ptrColor->w = 255; // opaque
	    }

    private:

	__device__
	float f(float x, float y, int t)
	    {
	    float a = 0;
	    float b = 0;
	    float aCopy = 0;

	    for (int i = 0; i < t; i++)
		{
		aCopy = a;
		a = (a * a - b * b) + x;
		b = 2.f * aCopy * b + y;

		if (a * a + b * b > 4.f)
		    return i;
		}
	    return t;
	    }

	/*--------------------------------------*\
	|*		Attributs		*|
	 \*-------------------------------------*/

    private:

	// Inputs
	uint n;

	// Tools
	Calibreur<float> calibreur;

    };

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
