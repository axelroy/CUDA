#include "RayTracingProvider.h"

#include "MathTools.h"
#include "Grid.h"
#include "../moo/host/RayTracing.h"


/*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

/**
 * Override
 */
Animable_I<uchar4>* RayTracingProvider::createAnimable()
    {
    // Animation;
    float dt = 2 * PI / 1000;

    // Dimension
    int dw = 16 * 60 * 2;
    int dh = 16 * 60;

    // Grid Cuda
    int mp=Device::getMPCount();
    int coreMP=Device::getCoreCountMP();

    dim3 dg = dim3(mp, 2, 1);
    dim3 db = dim3(coreMP, 2, 1);
    Grid grid(dg, db);

    // Nombre de spheres
    int nbSphere = 500;

    return new RayTracing(nbSphere, grid, dw, dh, dt);
    }

/**
 * Override
 */
Image_I* RayTracingProvider::createImageGL(void)
    {
    ColorRGB_01 colorTexte(1, 0, 0); // red
    return new ImageAnimable_RGBA_uchar4(createAnimable(), colorTexte);
    }

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/
