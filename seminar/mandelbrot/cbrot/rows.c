#include "erl_nif.h"
#include  "stdio.h"

int test(double cR, double cI, int max){
    // z0 of mandelbrot
    long double zr = 0.0;
    long double zi = 0.0;
    long double cReal = cR;
    long double cImag = cI;

    // placeholder for abs(zi)

    int depth = 0;
    while (depth <= max) {
        //printf("depth:%d max:%d\n", depth, max);
        long double zr2 = zr*zr;
        long double zi2 = zi*zi;
        long double a = zr2+zi2;
        if(a >= 4.0){
            //printf("%d\n", depth);
            return depth;
        } else{
            depth++;
            zi = 2*zr*zi+cImag;
            zr = zr2-zi2+cReal;

        }
    }
    //printf("%d\n", 0);
    return 0;
}

static ERL_NIF_TERM
mandelbrot(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]){
    double cReal, cImag;
    int max;
    int res;

    if(!enif_get_double(env, argv[0], &cReal) ||
       !enif_get_double(env, argv[1], &cImag) ||
       !enif_get_int(env, argv[2], &max))
        return enif_make_badarg(env);

    res = test(cReal, cImag, max);
    return enif_make_int(env, res);
}

static ErlNifFunc nif_funcs[] = {
    {"mandelbrot", 3, mandelbrot}
};

ERL_NIF_INIT(Elixir.Mandelbrot, nif_funcs, NULL, NULL, NULL, NULL)
