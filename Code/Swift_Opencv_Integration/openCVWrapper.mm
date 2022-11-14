#include "OpenCVWrapper.h"
#import "UIImage+OpenCV.h"
#include <opencv2/opencv.hpp>
using namespace cv;
using namespace std;
@implementation OpenCVWrapper : NSObject
    +(UIImage *)processImageWithOpenCV:(UIImage*)inputImage{
        Mat mat = [inputImage CVMat];
        //processing
        return [UIImage imageWithCVMat:mat];
    }
@end