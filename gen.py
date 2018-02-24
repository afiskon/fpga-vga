#!/usr/bin/env python3

# vim: set ai et ts=4 sw=4:

def gen(arg, begin, pixels, arr):
    for i in range(0, int(2**len(arr))):
        if i > 0:
            print("else");
        if i != int(2**len(arr)) - 1:
            print("if({} < ({} + ({}/{})*{}))".format(
                arg, begin, pixels, int(2**len(arr)), i+1))
        print("begin")
        for j in range(0, len(arr)):
            print((" " * 4) + "{} <= {};".format(
                arr[j], "1" if i & (1 << j) else "0"))
        print("end")


gen("hctr", "horiz_vis_begin", "horiz_active_pixels",
    ["r[0]", "r[1]", "r[2]", "g[0]"])
gen("vctr", "vert_vis_begin", "vert_active_pixels",
    ["g[1]", "g[2]", "b[0]", "b[1]"])

