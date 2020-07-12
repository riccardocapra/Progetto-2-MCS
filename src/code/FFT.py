from scipy import fftpack
def get_2D_dct(img):
    # Get 2D Cosine Transform of Image
    return fftpack.dct(fftpack.dct(img.T, norm='ortho').T, norm='ortho')
def get_2d_idct(coefficients):
    # Get 2D Inverse Cosine Transform of Image
    return fftpack.idct(fftpack.idct(coefficients.T, norm='ortho').T,norm='ortho')