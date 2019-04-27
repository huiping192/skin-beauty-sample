//
//  GPUImageEmptyFilter.m
//  ShowRoom
//
//  Created by Huiping Guo on 2019/03/03.
//

#import "GPUImageEmptyFilter.h"

NSString *const kLFGPUImageEmptyFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 
 void main(){
     lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     
     gl_FragColor = vec4((textureColor.rgb), textureColor.w);
 }
 
 );

@implementation GPUImageEmptyFilter


- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kLFGPUImageEmptyFragmentShaderString])) {
        return nil;
    }
    
    return self;
}

@end
