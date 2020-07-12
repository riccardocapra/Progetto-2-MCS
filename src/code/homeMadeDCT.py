import numpy as np
import math
def dct2_my_implementation(img):
    dct = img.copy()
    Nx = img.shape[0]
    Ny = img.shape[1]
    for i in range(Ny):
        col = dct[:, i]
        dct_col = dct_my_implementation(col)
        dct[:, i] = dct_col
    for i in range(Nx):
        row = dct[i, :]
        dct_row = dct_my_implementation(row)
        dct[i, :] = dct_row
    return dct

def idct2_my_implementation(dct2):
    img = dct2.copy()
    Nx = dct2.shape[0]
    Ny = dct2.shape[1]
    for i in range(Ny):
        col = img[:, i]
        img_col = idct_my_implementation(col)
        img[:, i] = img_col
    for i in range(Nx):
        row = img[i, :]
        img_row = idct_my_implementation(row)
        img[i, :] = img_row
    return img

def dct_my_implementation(f):
    N = f.size
    a = np.zeros(N)
    dct = np.zeros(N)
    a[0] = 1 / math.sqrt(N)
    a[1:] = math.sqrt(2 / N)
    for k in range(N):
        for i in range(N):
            dct[k] += f[i] * math.cos(math.pi * k * (2 * i + 1) / (2 * N)
            )
            dct[k] = a[k] * dct[k]

    return dct
    
def idct_my_implementation(dct):
    N = dct.size
    a = np.zeros(N)
    a[0] = 1 / math.sqrt(N)
    a[1:] = math.sqrt(2 / N)
    f = np.zeros(N)
    for j in range(N):
        for k in range(N):
            f[j] += dct[k] * a[k] * math.cos(math.pi * k * (2 * j + 1) /
            (2 * N))
    return f
